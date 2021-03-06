defmodule Corea.Invoices.Item do
  import Ecto.Changeset
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "items" do
    field :name, :string
    field :price, :decimal, precision: 15, scale: 4
    field :document, :string
    field :document_hash, :string
    # field :tax_rate, :integer, precision: 5, scale: 2

    # embeds_one :item_locker, Corea.Invoices.ItemLockeEmbed

    belongs_to :product, Corea.Products.Product, type: :binary_id
    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    # has_one :invoice_item, Corea.Invoices.InvoiceItem

    timestamps()
  end

  @fields [
    :name, :product_id, :price, :document, :document_hash
  ]

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required([])
    # |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
  end

end
