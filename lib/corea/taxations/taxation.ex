defmodule Corea.Taxations.Taxation do
  use Ecto.Schema
  import Ecto.Changeset

  #? This schema is for Tax Authority of a supul including a nation supul.

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "taxations" do
    field :name, :string
    field :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0

    field :auth_code, :string
    field :unique_digits, :string
    field :tels, {:array, :string}

    has_many :entities, Corea.Entities.Entity
    has_many :tax_rates, Corea.Taxations.TaxRate

    belongs_to :nation, Corea.Nations.Nation, type: :binary_id
    belongs_to :nation_supul, Corea.NationSupuls.NationSupul, type: :binary_id

    has_one :financial_report, Corea.Reports.FinancialReport, on_replace: :nilify
    has_one :income_statement, Corea.Reports.IncomeStatement, on_replace: :nilify
    has_one :balance_sheet, Corea.Reports.BalanceSheet, on_replace: :nilify
    has_one :cf_statement, Corea.Reports.CFStatement, on_replace: :nilify
    has_one :equity_statement, Corea.Reports.EquityStatement, on_replace: :nilify

    timestamps()
  end

  @fields [:name, :t1_balance, :auth_code, :unique_digits, :tels, ]

  def changeset(taxation, attrs = %{auth_code: auth_code}) do
    taxation
    |> cast(attrs, @fields)
    |> put_change(:auth_code, attrs.auth_code)
  end
  @doc false
  def changeset(taxation, attrs) do
    taxation
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:nation, attrs.nation)
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
  end
end
