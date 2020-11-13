defmodule Corea.Repo.Migrations.CreateFairTrades do
  use Ecto.Migration

  def change do
    create table(:fair_trades) do
      add :fair?, :boolean, default: false, null: false

      timestamps()
    end

  end
end
