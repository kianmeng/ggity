defmodule GGity.Scale.Alpha.Continuous do
  @moduledoc false

  alias GGity.Scale.Alpha

  @type t() :: %__MODULE__{}

  defstruct range: {0.1, 1},
            transform: nil

  @spec new(keyword()) :: Alpha.Continuous.t()
  def new(options \\ []), do: struct(Alpha.Continuous, options)

  @spec train(Alpha.Continuous.t(), {number(), number()}) :: Alpha.Continuous.t()
  def train(scale, {value_min, value_max}) do
    domain = value_max - value_min
    transformations(scale, domain, value_min)
  end

  defp transformations(scale, 0, _value_min) do
    struct(scale, transform: fn _value -> 1 end)
  end

  defp transformations(scale, domain, value_min) do
    {range_min, range_max} = scale.range
    range = range_max - range_min

    struct(scale,
      transform: fn value -> range_min + (value - value_min) / domain * range end
    )
  end
end
