class FibonacciJob < ApplicationJob
  self.queue_adapter = :inline
  queue_as :default

  def perform(fibonacci_index)
    return fibonacci(fibonacci_index)
  end

  private 

  def fibonacci(index)
    if index <= 1
      puts 1
      return 1
    end

    calced = fibonacci(index - 1) + fibonacci(index - 2)
    puts "calculation finished. value = #{calced}"
    return calced
  end
end
