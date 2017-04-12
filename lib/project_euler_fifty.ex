defmodule ProjectEulerFifty do

  def longest_sum_of_consecutive_primes(ceiling) do
    {:ok, primes} = PrimalEx.primes(ceiling)
    filter_non_prime_sums = filter_non_prime_sums(primes)
    result = process_prime_set(primes, [], ceiling, filter_non_prime_sums)
    %{sum: Enum.sum(result), count: Enum.count(result)}
  end

  def process_prime_set([],leader, _ceiling,_), do: leader
  def process_prime_set([prime|remainder], leader, ceiling, filter_non_prime_sums) do
    primes = [prime|remainder]
    prime_winner = process_prime(primes, [], leader , ceiling, filter_non_prime_sums)
    new_leader = cond do
      prime_winner > leader ->
        prime_winner
      true ->
        leader
    end
    process_prime_set(remainder, new_leader, ceiling, filter_non_prime_sums)
  end

  def process_prime([], _,leader,_,_), do: leader
  def process_prime([prime|remainder], last_set, leader, ceiling, filter_non_prime_sums) do
    new_set = [prime|last_set]
    new_set_sum = Enum.sum(new_set)
    cond do
      new_set_sum >= ceiling ->
        process_prime([], [], leader, ceiling, filter_non_prime_sums)
      Enum.count(new_set) <= Enum.count(leader) ->
        process_prime(remainder, new_set, leader, ceiling, filter_non_prime_sums)
      !filter_non_prime_sums.(new_set_sum) ->
        process_prime(remainder, new_set, leader, ceiling, filter_non_prime_sums)
      Enum.count(new_set) > Enum.count(leader) ->
        process_prime(remainder, new_set, new_set, ceiling, filter_non_prime_sums)
      true ->
        process_prime(remainder, new_set, leader, ceiling, filter_non_prime_sums)
    end
  end

  def filter_non_prime_sums(primes) do
    fn(x) -> Enum.member?(primes, x) end
  end

end
