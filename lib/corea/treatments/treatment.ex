defmodule Corea.CDC.Treatment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "treatments" do
    field :clinic_id, :string
    field :doctor, :string
    field :nurse, :string

    field :disease, :string
    field :comment, :string

    belongs_to :prescription, Corea.CDC.Prescription, type: :binary_id

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(treatment, attrs) do
    treatment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
