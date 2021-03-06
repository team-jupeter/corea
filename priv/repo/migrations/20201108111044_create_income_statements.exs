defmodule Corea.Repo.Migrations.CreateIncomeStatements do
  use Ecto.Migration

  def change do
    create table(:income_statements, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cost_of_goods_sold, :decimal, precision: 12, scale: 2, default: 0.0
      add :compensation, :decimal, precision: 12, scale: 2, default: 0.0
      add :depreciation_and_amortization, :decimal, precision: 12, scale: 2, default: 0.0
      add :employee_benefits, :decimal, precision: 12, scale: 2, default: 0.0
      add :entity_name, :string
      add :expense, :decimal, precision: 12, scale: 2, default: 0.0
      add :insurance, :decimal, precision: 12, scale: 2, default: 0.0
      add :marketing, :decimal, precision: 12, scale: 2, default: 0.0
      add :office, :decimal, precision: 12, scale: 2, default: 0.0
      add :supplies, :decimal, precision: 12, scale: 2, default: 0.0
      add :payroll, :decimal, precision: 12, scale: 2, default: 0.0
      add :professional_fees, :decimal, precision: 12, scale: 2, default: 0.0
      add :rent, :decimal, precision: 12, scale: 2, default: 0.0
      add :revenue, :decimal, precision: 12, scale: 2, default: 0.0
      add :repair_and_maintenance, :decimal, precision: 12, scale: 2, default: 0.0
      add :sales_discounts, :decimal, precision: 12, scale: 2, default: 0.0
      add :taxes, :decimal, precision: 12, scale: 2, default: 0.0
      add :travel_and_entertainment, :decimal, precision: 12, scale: 2, default: 0.0
      add :utilities, :decimal, precision: 12, scale: 2, default: 0.0
      add :income_taxes, :decimal, precision: 12, scale: 2, default: 0.0

      add(:t1, {:array, :jsonb}, default: [])
      add(:t2, {:array, :jsonb}, default: [])
      add(:t4, {:array, :jsonb}, default: [])

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :group_id, references(:groups, type: :uuid, null: false)
      add :taxation_id, references(:taxations, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
