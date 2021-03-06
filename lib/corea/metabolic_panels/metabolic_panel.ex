defmodule Corea.CDC.MetabolicPanel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "metabolic_panels" do
      field :collection_date, :date
      field :received_date, :date
      field :reported_date, :date

      field :panel_name, :string
      field :comment, :string
      field :result, :string

      embeds_many :metabolic_items, Corea.CDC.MetabolicItemEmbed
      belongs_to :diagnosis, Corea.CDC.Diagnosis, type: :binary_id

      timestamps()
  end

  @fields [
      :panel_name, :comment, :result, :diagnosis_id
  ]
  @doc false
  def changeset(medic_panel, attrs \\ %{}) do
    medic_panel
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
