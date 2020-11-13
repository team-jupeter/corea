defmodule Corea.DiseaseControls.DiseaseControl do
  use Ecto.Schema
  import Ecto.Changeset

  schema "disease_controls" do
    field :nationality, :string

    timestamps()
  end

  @doc false
  def changeset(disease_control, attrs) do
    disease_control
    |> cast(attrs, [:nationality])
    |> validate_required([:nationality])
  end
end
