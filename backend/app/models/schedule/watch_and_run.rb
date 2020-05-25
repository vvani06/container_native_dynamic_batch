require 'timers'

class Schedule::WatchAndRun
  def initialize
    @timers = Timers::Group.new
    @previous_time = Time.now
  end

  def exec
    @timers.now_and_every(60) do
      previous = @previous_time
      current = Time.now
      @previous_time = current
      Schedule.where(run_at: previous...current).each do |schedule|
        puts run_task(schedule)
      end
    end

    loop { @timers.wait }
  end

  private

  def run_task(schedule)
    puts "Run: #{schedule}"
    
    # Run ECS task 
    client = Aws::ECS::Client.new(
      region: ENV['ECS_REGION'],
      credentials: Aws::Credentials.new(
        ENV['ECS_API_KEY'],
        ENV['ECS_SECRET_KEY']
      ),
    )
    
    response = client.run_task(
      cluster: ENV['ECS_CLUSTER'],
      task_definition: ENV['ECS_TASK_DEFINITION'],
      tags: [
        {
          key: "schedule_id",
          value: schedule.id.to_s
        }
      ]
      network_configuration: {
        awsvpc_configuration: {
          subnets: ENV['ECS_NETWORK_SUBNETS'].split(','),
          assign_public_ip: 'ENABLED'
        }
      },
      overrides: {
        container_overrides: [
          {
            name: 'backend',
            command: %W(bundle exec thor fibonacci:calc #{schedule.calc_index})
          }
        ]
      }
    )

    return response[:tasks][0][:task_arn]
  end
end
