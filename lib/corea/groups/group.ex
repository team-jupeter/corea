defmodule Corea.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "groups" do
    field :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0
    field :type, :string
    field :name, :string

    belongs_to :supul, Corea.Supuls.Supul, type: :binary_id

    has_many :entities, Corea.Entities.Entity
    # many_to_many(
    #   :entities,
    #   Entity,
    #   # join_through: Corea.Groups.EntitiesGroups,
    #   join_through: "entities_groups",
    #   on_replace: :delete
    # )

    has_one :financial_report, Corea.Reports.FinancialReport
    has_one :income_statement, Corea.Reports.IncomeStatement
    has_one :balance_sheet, Corea.Reports.BalanceSheet
    has_one :cf_statement, Corea.Reports.CFStatement
    has_one :equity_statement, Corea.Reports.EquityStatement
    has_one :gab_account, Corea.GabAccounts.GabAccount, on_replace: :nilify

    timestamps()
  end

  @fields [
    :t1_balance, :type, :name
  ]
  @doc false
  def changeset(group, attrs = %{entities: entities}) do
    group
    |> cast(attrs, @fields)
    |> put_assoc(:entities, entities)
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
    |> put_assoc(:gab_account, attrs.ga)
  end

  @doc false
  def changeset(group, attrs = %{t1_balance: t1_balance}) do
    IO.puts("group, changeset")

    group
    |> cast(attrs, @fields)
  end

  def changeset(group, attrs) do
    IO.puts("group, changeset")

    group
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
    |> put_assoc(:gab_account, attrs.ga)
  end
end
