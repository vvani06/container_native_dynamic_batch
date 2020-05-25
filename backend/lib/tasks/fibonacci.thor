class Fibonacci < Thor
  desc 'calc', 'calc fibonnaci number at the index'
  def calc(index)
    puts FibonacciJob.perform_now(index.to_i)
  end
end
