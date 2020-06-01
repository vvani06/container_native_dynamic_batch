class ContainerWatchJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  def perform(container_identifier)
    @finished = false
    
    @timers = Timers::Group.new
    @timers.now_and_every(30) do
      @status = fetch_status(container_identifier)
      puts "#{@status}: #{container_identifier}"
      @finished = true if @status != :running
    end
    
    loop do
      break if @finished

      @timers.wait
    end

    @status
  end

  private 

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
    
    description = client.describe_tasks({
      cluster: ENV['ECS_CLUSTER'],
      tasks: [container_identifier]
    })

    raise :no_task if description.failures.any? { |f| f.reason == 'MISSING' }

    return :failure if description.failures.present?
    return :running if description.tasks.any? { |task| task.stop_code.nil? }
    
    return :success
  end
end
