# frozen_string_literal: true

def fibonacci(num)
  return 0 if num <= 0
  return 1 if num == 1

  fibonacci(num - 1) + fibonacci(num - 2)
end

10.times { |i| puts fibonacci(i) }
