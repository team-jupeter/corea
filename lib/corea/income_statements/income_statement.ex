defmodule Corea.Reports.IncomeStatement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "income_statements" do
    field :compensation, :decimal, precision: 12, scale: 2, default: 0.0
    field :cost_of_goods_sold, :decimal, precision: 12, scale: 2, default: 0.0
    field :depreciation_and_amortization, :decimal, precision: 12, scale: 2, default: 0.0
    field :employee_benefits, :decimal, precision: 12, scale: 2, default: 0.0
    field :entity_name, :string
    field :expense, :decimal, precision: 12, scale: 2, default: 0.0
    field :income_taxes, :decimal, precision: 12, scale: 2, default: 0.0
    field :insurance, :decimal, precision: 12, scale: 2, default: 0.0
    field :marketing, :decimal, precision: 12, scale: 2, default: 0.0
    field :office, :decimal, precision: 12, scale: 2, default: 0.0
    field :payroll, :decimal, precision: 12, scale: 2, default: 0.0
    field :professional_fees, :decimal, precision: 12, scale: 2, default: 0.0
    field :rent, :decimal, precision: 12, scale: 2, default: 0.0
    field :repair_and_maintenance, :decimal, precision: 12, scale: 2, default: 0.0
    field :revenue, :decimal, precision: 12, scale: 2, default: 0.0
    field :sales_discounts, :decimal, precision: 12, scale: 2, default: 0.0
    field :supplies, :decimal, precision: 12, scale: 2, default: 0.0
    field :taxes, :decimal, precision: 12, scale: 2, default: 0.0
    field :travel_and_entertainment, :decimal, precision: 12, scale: 2, default: 0.0
    field :utilities, :decimal, precision: 12, scale: 2, default: 0.0

    embeds_many :t1, Corea.ABC.OpenT1
    embeds_many :t2, Corea.ABC.OpenT2
    embeds_many :t4, Corea.T4s.T4

    has_many :t3s, Corea.T3s.T3

    belongs_to :financial_report, Corea.Reports.FinancialReport, type: :binary_id
    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    belongs_to :group, Corea.Groups.Group, type: :binary_id
    belongs_to :supul, Corea.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Corea.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Corea.NationSupuls.NationSupul, type: :binary_id
    belongs_to :taxation, Corea.Taxations.Taxation, type: :binary_id

    timestamps()
  end

  @fields [
    :compensation,
    :cost_of_goods_sold,
    :depreciation_and_amortization,
    :employee_benefits,
    :income_taxes,
    :insurance,
    :marketing,
    :office,
    :payroll,
    :professional_fees,
    :rent,
    :repair_and_maintenance,
    :revenue,
    :sales_discounts,
    :supplies,
    :taxes,
    :travel_and_entertainment,
    :utilities,
    :entity_id,
    :expense,
  ]
  @doc false
  def changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
