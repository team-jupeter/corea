defmodule Corea.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime

      add :type, :string
      add :name, :string
      add :ssn, :string
      add :address, :string
      add :username, :string
      add :gps, {:array, :map}
      add :default_entity_id, :binary_id
      add :default_entity_name, :string
      add :nationality, :string
      add :auth_code, :string
      add :birth_date, :naive_datetime
      add :password_hash, :string
      add :supul_code, :string
      add :family_code, :string, default: nil
      add :supul_name, :string
      add :married, :boolean, default: false
      add :default_family, :boolean, default: false
      add :default_currency, :string


      add :family_id, references(:families, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :nation_id, references(:nations, type: :uuid, null: false)
      add :constitution_id, references(:constitutions, type: :uuid, null: false)

      add :entity_id, references(:entities, type: :uuid, null: false)
      add :school_id, references(:schools, type: :uuid)

      timestamps()
    end

    create(unique_index(:users, [:email, :username]))

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
