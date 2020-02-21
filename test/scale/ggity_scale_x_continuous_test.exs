defmodule GGityScaleXContinuousTest do
  use ExUnit.Case

  alias GGity.Scale.X

  describe "new/3" do
    test "creates a correct transformation function" do
      values = [1, 3, 5]
      scale = X.Continuous.new(values)
      assert scale.transform.(1) == 0
      assert scale.transform.(3) == 100
      assert scale.transform.(5) == 200
    end
  end
end
