defmodule Corea.Constitutions.Constitution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "constitutions" do
    field :content, :string
    field :content_hash, :string
    field :empowered_on, :naive_datetime
    field :nationality, :string
    field :signed_by, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(constitution, attrs) do
    constitution
    |> cast(attrs, [:nationality, :content, :content_hash, :empowered_on, :sighed_by])
    |> validate_required([:nationality, :content, :content_hash, :empowered_on, :sighed_by])
  end
end

