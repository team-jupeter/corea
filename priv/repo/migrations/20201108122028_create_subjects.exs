defmodule Corea.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :category, :string
      add :starting_date, :naive_datetime
      add :ending_date, :naive_datetime
      add :interest_rate, :decimal, precision: 6, scale: 4
      add :self_funding_ratio,  :decimal, precision: 3, scale: 1
      add :documents, {:array, :binary_id}, default: []
      add :applicants, {:array, :binary_id}, default: []

      add :applicant_id, references(:applicants, type: :uuid, null: false)


      timestamps()
    end

  end
end
