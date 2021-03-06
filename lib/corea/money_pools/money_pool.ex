defmodule Corea.MoneyPools.MoneyPool do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "money_pools" do
    field :t1, :decimal, precision: 12, scale: 4, default: 0.0 #? A specific fiat currency
    field :t2, :decimal, integer: 0 #? neutralized fiat currency
    field :t3, :decimal, integer: 0 #? PASS stock pools
    field :t4, :decimal, integer: 0 #? Specific Securities
    field :t5, :decimal, integer: 0 #? GAB stocks
    field :reserve, :decimal, precision: 12, scale: 4, default: 0.0 #? 지불준비금

    # belongs_to :gab, Corea.GABs.GAB, type: :binary_id


    timestamps()
  end

  @fields [
    :t1, :t2, :t3, :t4, :reserve,
  ]

  @doc false
  def changeset(money_pool, attrs) do
    money_pool
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
