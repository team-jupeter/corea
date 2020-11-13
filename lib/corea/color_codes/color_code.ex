defmodule Corea.ColorCodes.ColorCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "color_codes" do
    field :char_1, :integer

    timestamps()
  end

  @doc false
  def changeset(color_code, attrs) do
    color_code
    |> cast(attrs, [:char_1])
    |> validate_required([:char_1])
  end
end
