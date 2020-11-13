defmodule Corea.Products.ProductAnnotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_annotations" do
    field :at, :integer
    field :body, :string
    field :star, :integer

    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    belongs_to :product, Corea.Products.Product, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(annotation, attrs) do
    annotation
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
