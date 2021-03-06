defmodule Corea.Reports.CFStatement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "cf_statements" do
    field :entity_name, :string
    field :capital_expenditures, :decimal, precision: 12, scale: 2, default: 0.0
    field :changes_in_working_capital, :decimal, precision: 12, scale: 2, default: 0.0
    field :debt_issuance, :decimal, precision: 12, scale: 2, default: 0.0
    field :depreciation_amortization, :decimal, precision: 12, scale: 2, default: 0.0
    field :equity_issuance, :decimal, precision: 12, scale: 2, default: 0.0
    field :net_earnings, :decimal, precision: 12, scale: 2, default: 0.0
    field :opening_cash_balance, :decimal, precision: 12, scale: 2, default: 0.0

    belongs_to :financial_report, Corea.Reports.FinancialReport, type: :binary_id
    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    belongs_to :group, Corea.Groups.Group, type: :binary_id
    belongs_to :family, Corea.Families.Family, type: :binary_id
    belongs_to :supul, Corea.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Corea.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Corea.NationSupuls.NationSupul, type: :binary_id
    belongs_to :taxation, Corea.Taxations.Taxation, type: :binary_id

    timestamps()
  end

  @fields [
    :net_earnings,
    :depreciation_amortization,
    :changes_in_working_capital,
    :capital_expenditures,
    :debt_issuance,
    :equity_issuance,
    :opening_cash_balance
  ]
  @doc false
  def changeset(cf_statement, attrs) do
    cf_statement
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
