defmodule EnumWorkshopTest do
  use ExUnit.Case, async: false
  use ExCheck
  # doctest EnumWorkshop

  property :count_list do
    for_all xs in list(int) do
      EnumWorkshop.count(xs) == Enum.count(xs)
    end
  end

end
