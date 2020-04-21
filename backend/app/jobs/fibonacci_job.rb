class FibonacciJob < ApplicationJob
  queue_as :default

  def perform(fibonacci_index)
    return fibonacci(fibonacci_index)
  end

  private 

  def fibonacci(index)
    return 1 if index <= 1

    fibonacci(index - 1) + fibonacci(index - 2)
  end
end
