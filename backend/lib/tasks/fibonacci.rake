desc "calc fibonnaci number"
task :fibonacci, [:index] => :environment do |task, args|
  puts FibonacciJob.perform_now(args.index.to_i)
end
