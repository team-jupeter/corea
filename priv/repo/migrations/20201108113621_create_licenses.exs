defmodule Corea.Repo.Migrations.CreateLicenses do
  use Ecto.Migration

  def change do
    create table(:licenses, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :licence_code, :string
      add :name, :string
      add :issued_by, :string
      add :issued_date, :date
      add :issued_to, :string
      add :document, :binary_id

      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)
      timestamps()
    end

  end
end
