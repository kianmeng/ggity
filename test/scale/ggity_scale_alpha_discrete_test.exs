defmodule GGityScaleAlphaDiscreteTest do
  use ExUnit.Case

  import SweetXml

  alias GGity.Scale.Alpha

  setup do
    %{scale: Alpha.Discrete.new(["beef", "chicken", "lamb", "fish"])}
  end

  describe "new/2" do
    test "returns a proper scale for discrete values", %{scale: scale} do
      assert_in_delta scale.transform.("beef"), 0.1, 0.000001
      assert_in_delta scale.transform.("chicken"), 0.4, 0.000001
      assert_in_delta scale.transform.("fish"), 0.7, 0.000001
      assert_in_delta scale.transform.("lamb"), 1, 0.000001
    end
  end

  describe "draw_legend/2" do
    test "returns an empty list if scale has one or zero levels" do
      assert [] ==
               Alpha.Discrete.new([])
               |> Alpha.Discrete.draw_legend("Nothing Here")

      assert [] ==
               Alpha.Discrete.new(["fish"])
               |> Alpha.Discrete.draw_legend("Nothing Here")
    end

    test "returns a legend if scale has two or more levels", %{scale: scale} do
      legend =
        Alpha.Discrete.draw_legend(scale, "Fine Meats")
        |> IO.chardata_to_string()
        |> String.replace_prefix("", "<svg>")
        |> String.replace_suffix("", "</svg>")

      assert xpath(legend, ~x"//text/text()"ls) == [
               "Fine Meats",
               "beef",
               "chicken",
               "fish",
               "lamb"
             ]

      assert xpath(legend, ~x"//circle/@fill-opacity"lf) ==
               Enum.map(scale.levels, fn value -> scale.transform.(value) end)
    end
  end
end