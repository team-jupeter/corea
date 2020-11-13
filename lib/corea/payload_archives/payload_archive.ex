defmodule Corea.Mulets.PayloadArchive do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "payload_archives" do
    field :payload, :string
    field :payload_hash, :string

    belongs_to :supul, Corea.Supuls.Supul, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(payload_archive, attrs) do
    payload_archive
    |> cast(attrs, [:payload, :payload_hash])
    |> validate_required([])
    |> put_payload_hash()
  end

  defp put_payload_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{payload: payload}} ->
        payload_hash = Pbkdf2.hash_pwd_salt(payload)
        put_change(changeset, :payload_hash, payload_hash)

      _ ->
        changeset
    end
  end
end
