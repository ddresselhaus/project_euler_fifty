defmodule OldProjectEulerFifty do

  def longest_sum_of_consecutive_primes(ceiling) do
    {:ok, primes} = PrimalEx.primes(ceiling)
    filter_non_prime_sums = filter_non_prime_sums(primes)
    result = consecutive_primes_less_than_ceiling(primes, 0, ceiling, [], filter_non_prime_sums)
    |> Enum.filter(filter_non_prime_sums)
    |> Enum.sort_by(&Enum.count/1)
    |> Enum.reverse()
    |> Enum.at(0)

    %{count: Enum.count(result), sum: Enum.sum(result)}
  end

  def consecutive_primes_less_than_ceiling([],_, _ceiling, results,_), do: results
  def consecutive_primes_less_than_ceiling([prime|remainder], high_score, ceiling, results, filter_non_prime_sums) do
    primes = [prime|remainder]
    additional_results = primes_less_than_ceiling(primes, [], high_score , ceiling, [], filter_non_prime_sums)
    consecutive_primes_less_than_ceiling(remainder, high_score, ceiling, additional_results ++ results, filter_non_prime_sums)
  end

  def primes_less_than_ceiling([], _, _,_, result,_), do: result
  def primes_less_than_ceiling([prime|remainder], last_set, high_score, ceiling, result, filter_non_prime_sums) do
    new_set = [prime|last_set]
    cond do
      Enum.sum(new_set) >= ceiling ->
        primes_less_than_ceiling([], [], high_score, ceiling, result, filter_non_prime_sums)
      Enum.count(new_set) < high_score || !filter_non_prime_sums(new_set) ->
        primes_less_than_ceiling(remainder, new_set, high_score, ceiling, result, filter_non_prime_sums)
      Enum.count(new_set) > high_score ->
        primes_less_than_ceiling(remainder, new_set, Enum.count(new_set), ceiling, [new_set|result], filter_non_prime_sums)
      true ->
        primes_less_than_ceiling(remainder, new_set, high_score, ceiling, [new_set|result], filter_non_prime_sums)
    end
  end

  def filter_non_prime_sums(primes) do
    fn(x) -> Enum.member?(primes, Enum.sum(x)) end
  end

end
