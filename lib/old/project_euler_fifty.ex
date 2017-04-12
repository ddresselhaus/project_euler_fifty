defmodule Old.ProjectEulerFifty do
  def recursive_addition([], depth, total, ceiling), do: [ depth, total ]
  def recursive_addition([prime|remainder], depth, total, ceiling) do
    if (( total + prime) > ceiling ) do
      [ depth, total ]
    else
      recursive_addition(remainder, depth + 1, total + prime, ceiling)
    end
  end
  def longest_consecutive_prime([], ceiling, high_score, primes), do: high_score
  def longest_consecutive_prime([prime|remainder], ceiling, high_score, primes) do
    [count, total] = recursive_addition([prime|remainder], 0, 0, ceiling)
    new_high_score = if count > high_score.count && Enum.member?(primes, total) do
      %{ prime: prime, total: total, count: count }
    else
      high_score
    end
    longest_consecutive_prime(remainder, ceiling, new_high_score, primes)
  end
end
