defmodule Corea.Campus.School do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "schools" do
    field :description, :string
    field :type, :string
    field :mentors, {:array, :map}
    field :monthly_tution_fee, :decimal, precision: 8, scale: 2
    field :students, {:array, :map}

    belongs_to :supul, Corea.Supuls.Supul, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:title, :description, :mentors])
    |> validate_required([:title, :description, :mentors])
  end
end
