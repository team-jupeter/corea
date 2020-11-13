defmodule Corea.Repo.Migrations.CreateDiseaseControls do
  use Ecto.Migration

  def change do
    create table(:disease_controls) do
      add :nationality, :string

      timestamps()
    end

  end
end
