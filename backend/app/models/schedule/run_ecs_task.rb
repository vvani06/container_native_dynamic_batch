require 'timers'

class Schedule::RunEcsTask
  def initialize(schedule)
    @schedule = schedule
  end

  def exec
    @ecs_response = run_task(@schedule)
    @ecs_task_arn = @ecs_response[:tasks][0][:task_arn]

    return @ecs_task_arn
  end

  private

  def run_task(schedule)
    puts "Run: #{schedule}"
    
    client = create_client()
    task_definition = default_task_definition(schedule);
    task_definition[:overrides][:container_overrides][0][:command] = command(schedule)

    response = client.run_task(task_definition)
    puts "Ecs ARN: #{response[:tasks][0][:task_arn]}"

    return response
  end

  def command(schedule)
    return %W(bundle exec thor sleep:sleep #{@schedule.id})
  end

  def create_client
    Aws::ECS::Client.new(
      region: ENV['ECS_REGION'],
      credentials: Aws::Credentials.new(
        ENV['ECS_API_KEY'],
        ENV['ECS_SECRET_KEY']
      )
    )
  end

  def fetch_status(container_identifier)
    client = create_client
    client.describe_tasks({
      cluster: ENV['ECS_CLUSTER'],
      tasks: [container_identifier]
    })
  end

  def default_task_definition(model)
    return {
      cluster: ENV['ECS_CLUSTER'],
      task_definition: ENV['ECS_TASK_DEFINITION'],
      tags: [
        {
          key: "model_class",
          value: model.class.name
        },
        {
          key: "model_identidier",
          value: model.id.to_s
        }
      ],
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
            command: []
          }
        ]
      }
    }
  end
end
