defmodule Corea.Machines.Machine do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "machines" do
    field :title, :string
    field :gpc_code, :string
    field :location, {:array, :map}
    field :purpose, :string
    field :made_by, :binary_id
    field :made_where, :string
    field :made_when, :date

    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    has_many :reports, Corea.Reports.Report

    timestamps()
  end

  @fields [
    :gpc_code,
    :location,
    :purpose,
    :made_by,
    :made_where,
    :made_when,
   ]
  @doc false
  def changeset(machine, attrs \\ %{}) do
    machine
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
