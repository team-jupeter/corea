defmodule Corea.TaxRates.TaxRate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tax_rates" do
    field :gpc_code, :string

    timestamps()
  end

  @doc false
  def changeset(tax_rate, attrs) do
    tax_rate
    |> cast(attrs, [:gpc_code])
    |> validate_required([:gpc_code])
  end
end
