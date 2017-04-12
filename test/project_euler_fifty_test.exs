defmodule ProjectEulerFiftyTest do
  use ExUnit.Case

  test "longest consecutive prime for 100 is 41" do
    ceiling = 100
    result = ProjectEulerFifty.longest_sum_of_consecutive_primes(ceiling)


    assert result.sum == 41
    assert result.count == 6
  end

  test "longest consecutive prime for 1000 is 953" do
    ceiling = 1000
    result = ProjectEulerFifty.longest_sum_of_consecutive_primes(ceiling)
    assert result.sum == 953
    assert result.count == 21
  end

  test "longest consecutive prime for 1_000_000 is " do
    ceiling = 1_000_000
    result = ProjectEulerFifty.longest_sum_of_consecutive_primes(ceiling)
    assert result.sum == 997651
    assert result.count == 543
  end

end
