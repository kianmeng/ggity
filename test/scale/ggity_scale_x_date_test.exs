defmodule GGityScaleXDateTest do
  use ExUnit.Case

  alias GGity.Scale.X

  describe "new/3" do
    test "creates a correct transformation function" do
      values = [~D[2001-01-01], ~D[2001-01-03], ~D[2001-01-05]]
      scale = X.Date.new(values)
      assert scale.transform.(~D[2001-01-01]) == 0
      assert scale.transform.(~D[2001-01-03]) == 100
      assert scale.transform.(~D[2001-01-05]) == 200
    end
  end
end