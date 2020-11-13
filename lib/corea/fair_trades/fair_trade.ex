defmodule Corea.FairTrades.FairTrade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fair_trades" do
    field :fair?, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(fair_trade, attrs) do
    fair_trade
    |> cast(attrs, [:fair?])
    |> validate_required([:fair?])
  end
end
