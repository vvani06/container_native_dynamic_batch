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
        task_identifier = Schedule::RunEcsTask.new(schedule).exec
        ContainerWatchJob.perform_later(task_identifier)
      end
    end

    loop { @timers.wait }
  end
end
