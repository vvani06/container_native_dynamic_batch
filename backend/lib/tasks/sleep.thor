class Sleep < Thor
  desc 'sleep', 'sleep accordings to schedule instance'
  def sleep(schedule_id)
    puts SleepJob.perform_now(schedule_id)
  end
end
