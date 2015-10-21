defmodule EnumWorkshop do
  import Kernel, except: [min: 2]

  @doc """
  reimplement the functionality of `Enum.count/1` without using the
  `count/1` function from the `Enum.module`.

    iex> EnumWorkshop.count([])
    0

    iex> EnumWorkshop.count([1])
    1

    iex> EnumWorkshop.count([1, 2, 3, 4])
    4
  """
  @spec count(list) :: [Any]
  def count([]),
    do: 0
  def count([_]),
    do: 1
  def count([_|t]),
    do: 1 + count(t)

  @doc """
  reimplement the functionality of `Enum.member?/1` without using the
  `member?/1` function from the `Enum.module`.

    iex> EnumWorkshop.member?([], 5)
    false

    iex> EnumWorkshop.member?([1], 1)
    true

    iex> EnumWorkshop.member?([1, 2, 3, 4], 3)
    true

    iex> EnumWorkshop.member?([1, 2, 3, 4], 7)
    false
  """
  @spec member?(list, Any) :: Boolean
  def member?([], _),
    do: false
  def member?([n|t], n),
    do: true
  def member?([_|t], n),
    do: member?(t, n)

  @doc """
  reimplement the functionality of `Enum.reverse/1` without using the
  `reverse/1` function from the `Enum.module`.

    iex> EnumWorkshop.reverse([1, 2, 3, 4])
    [4, 3, 2, 1]

    iex> EnumWorkshop.reverse([1, 1, 2, 2])
    [2, 2, 1, 1]

    iex> EnumWorkshop.reverse([1, 2, 1])
    [1, 2, 1]
  """
  @spec reverse(list) :: [Any]
  def reverse([]),
    do: []
  def reverse([h|t]),
    do: reverse(t) ++ [h]


  @doc """
  reimplement the functionality of `Enum.min/1` without using the
  `min/1` function from the `Enum.module`.

    iex> EnumWorkshop.min([1, 2, 3, 4])
    1

    iex> EnumWorkshop.min([4, 3, 2, 1])
    1

    iex> EnumWorkshop.min([5, 42, 3, 108, 3])
    3
  """
  @spec min([Integer]) :: Integer
  def min([h|t]),
    do: min(t, h)
  def min([], m),
    do: m
  def min([h|t], m) do
    if h < m do
      min(t, h)
    else
      min(t, m)
    end
  end

  @doc """
  reimplement the functionality of `Enum.filter/2` without using the
  `filter/2` function from the `Enum.module`.

    iex> EnumWorkshop.filter([1, 2, 3, 4], fn x -> x < 3 end)
    [1, 2]

    iex> EnumWorkshop.filter([1, 1, 2, 2], fn x -> x == 1 end)
    [1, 1]

    iex> EnumWorkshop.filter([1, 2, 3, 4, 5, 6], fn x -> rem(x, 2) == 1 end)
    [1, 3, 5]
  """
  @spec filter(list, function) :: [Any]
  def filter(list, fun),
    do: filter(list, fun, [])
  def filter([], _, acc),
    do: acc
  def filter([h|t], fun, acc) do
    case fun.(h) do
      true -> filter(t, fun, acc ++ [h])
      _ -> filter(t, fun, acc)
    end
  end

  @doc """
  reimplement the functionality of `Enum.dedup/1` without using the
  `dedup/1` function from the `Enum.module`.

    iex> EnumWorkshop.dedup([1, 2, 3, 4])
    [1, 2, 3, 4]

    iex> EnumWorkshop.dedup([1, 1, 2, 2])
    [1, 2]

    iex> EnumWorkshop.dedup([1, 1, 2, 2, 1, 1])
    [1, 2, 1]
  """
  @spec dedup(list) :: [Any]
  def dedup(list),
    do: dedup(list, [])
  def dedup([], acc),
    do: acc
  def dedup([h], acc),
    do: acc ++ [h]
  def dedup([h|[h|t]], acc),
    do: dedup([h|t], acc)
  def dedup([h1|[h2|t]], acc),
    do: dedup([h2|t], acc ++ [h1])

  @doc """
  reimplement the functionality of `Enum.chunk/2` without using the
  `chunk/1` function from the `Enum.module`.

    iex> EnumWorkshop.chunk([1, 2, 3, 4], 2)
    [[1, 2], [3, 4]]

    iex> EnumWorkshop.chunk([4, 3, 2, 1], 2)
    [[4, 3], [2, 1]]

    iex> EnumWorkshop.chunk([5, 42, 3, 108], 3)
    [[5, 42, 3]]
  """
  @spec chunk(Any, pos_integer) :: [list]
  def chunk([], n),
    do: []
  def chunk(list, n),
    do: chunk(list, n, [], [], 0)
  def chunk([], n, acc1, acc2, _) do
    if count(acc2) == n do
      acc1 ++ [acc2]
    else
      acc1
    end
  end
  def chunk([h|t], n, acc1, acc2, n) do
    chunk(t, n, acc1 ++ [acc2], [h], 1)
  end
  def chunk([h|t], n, acc1, acc2, len2) do
    chunk(t, n, acc1, acc2 ++ [h], len2 + 1)
  end

  @doc """
  reimplement the functionality of `Enum.chunk/2` without using the
  `chunk/1` function from the `Enum.module`.

    iex> EnumWorkshop.chunk2([1, 2, 3, 4], 2)
    [[1, 2], [3, 4]]

    iex> EnumWorkshop.chunk2([4, 3, 2, 1], 2)
    [[4, 3], [2, 1]]

    iex> EnumWorkshop.chunk2([5, 42, 3, 108], 3)
    [[5, 42, 3]]
  """
  @spec chunk2(Any, pos_integer) :: [list]
  def chunk2([], n),
    do: []
  def chunk2(list, n),
    do: chunk2(list, n, [])
  def chunk2(list, n, acc) do
    case take(list, n) do
      {[], _} -> acc
      {result, []} -> acc ++ [result]
      {result, left} -> chunk2(left, n, acc ++ [result])
    end
  end


  @doc """

    iex> EnumWorkshop.take([1, 2, 3, 4], 2)
    {[1, 2], [3,4]}

    iex> EnumWorkshop.take([4, 3, 2, 1], 3)
    {[4, 3, 2], [1]}

    iex> EnumWorkshop.take([4, 3, 2, 1], 10)
    {[], []}

    iex> EnumWorkshop.take([5, 42, 3, 108], 0)
    {[], [5,42, 3, 108]}

    iex> EnumWorkshop.take([], 3)
    {[], []}
  """
  def take(list, n),
    do: take(list, n, [])
  def take(list, 0, l),
    do: {l, list}
  def take([], _, l),
    do: {[], []}
  def take([h|t], n, l) do
      take(t, n-1, l ++ [h])
  end

end
