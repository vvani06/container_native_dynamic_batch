class SleepJob < ApplicationJob
  self.queue_adapter = :inline
  queue_as :default

  def perform(schedule_id)
    schedule = Schedule.find(schedule_id)
    puts("started: #{schedule.name}")
    
    log = Log.new(
      schedule_id: schedule_id,
      started_at: Time.now
    )
    
    schedule.calc_index.times do |m|
      sleep(60)
      puts("#{m + 1} minutes elapsed")
    end

    puts("finished: #{schedule.name}")
    log.finished_at = Time.now
    log.save!
  end
end
