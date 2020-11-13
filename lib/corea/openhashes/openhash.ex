defmodule Corea.Openhashes.Openhash do
  use Ecto.Schema
  import Ecto.Changeset
  alias Corea.Openhashes.Openhash

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "openhashes" do
    field :event_id, :binary_id
    field :input_email, :string
    field :output_email, :string
    field :supul_name, :string
    field :incoming_hash, :string
    field :previous_hash, :string
    field :current_hash, :string
    field :supul_signature, :string

    belongs_to :transaction, Corea.Transactions.Transaction, type: :binary_id
    belongs_to :wedding, Corea.Weddings.Wedding, type: :binary_id
    belongs_to :family, Corea.Families.Family, type: :binary_id

    belongs_to :supul, Corea.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Corea.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Corea.NationSupuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Corea.GlobalSupuls.GlobalSupul, type: :binary_id

    timestamps()
  end

  @fields [
    :event_id,
    :input_email,
    :output_email,
    :supul_name,
    :previous_hash,
    :incoming_hash,
    :current_hash,
    :supul_signature,
  ]


  # def changeset(%Openhash{} = openhash, %{supul: supul, supul_signature: supul_signature}) do
  #   attrs = %{
  #     txn_id: supul.txn_id,
  #     previous_hash: supul.previous_hash,
  #     incoming_hash: supul.incoming_hash,
  #     current_hash: supul.current_hash,
  #   }

  #   openhash
  #   |> cast(attrs, @fields)
  #   |> validate_required([])
  # end

  def changeset(%Openhash{} = openhash, attrs = %{supul_signature: supul_signature}) do
    openhash
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  @doc false
  def changeset(openhash, attrs) do
    IO.puts "Openhash, changeset"

    openhash
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
