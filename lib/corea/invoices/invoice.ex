defmodule Corea.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  # import Poison
  alias Corea.Repo
  alias Corea.Invoices.Invoice

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :openhash, :string
    field :start_at, :naive_datetime
    field :end_at, :naive_datetime
    field :total, :decimal, precision: 12, scale: 4
    field :tax_total, :decimal, precision: 5, scale: 4
    field :fiat_currency, :decimal, precision: 12, scale: 2

    field :buyer_id, :binary_id
    field :buyer_name, :string
    field :buyer_supul_id, :binary_id
    field :buyer_supul_name, :string
    field :seller_id, :binary_id
    field :seller_name, :string
    field :seller_supul_id, :binary_id
    field :seller_supul_name, :string

    has_many :invoice_items, Corea.Invoices.InvoiceItem, on_delete: :delete_all
    has_one :transaction, Corea.Transactions.Transaction

    # embeds_one :buyer, Corea.Invoices.BuyerEmbed, on_replace: :delete
    # embeds_one :seller, Corea.Invoices.SellerEmbed, on_replace: :delete
    # embeds_many :payments, Corea.Invoices.Payment, on_replace: :delete

    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    # many_to_many(
    #   :entities,
    #   Corea.Entities.Entity,
    #   join_through: Corea.Products.EntitiesInvoices,
    #   on_replace: :delete
    #   )

    timestamps()
  end


  @fields [
    :openhash, :total, :start_at, :end_at, :tax_total, :fiat_currency,
    :buyer_id,
    :buyer_name,
    :buyer_supul_id,
    :buyer_supul_name,
    :seller_id,
    :seller_name,
    :seller_supul_id,
    :seller_supul_name,
  ]

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    # |> cast_embed(:buyer)
    # |> cast_embed(:seller)
  end


  def create(_invoice, attrs) do
    changeset(%Invoice{}, attrs)
    |> put_assoc(:invoice_items, attrs.invoice_items)
    |> put_assoc(:entity, attrs.entity)
    |> put_total(attrs)
    |> Repo.insert #? {ok, invoice}

  end


  defp put_total(cs, attrs) do
    total = Enum.reduce(attrs.invoice_items, 0, fn x, sum -> Decimal.add(x.subtotal, sum) end)

    #? When we change a struct, change => put_change => update
    cs
    |> put_change(:total, total)
  end

  # defp put_buyer_data(cs) do
  #   cs
  # end

  # defp put_seller_data(cs) do
  #   seller_id = cs.data.invoice_item.entity_id
  #   seller_name = cs.data.invoice_item.entity_name

  #   cs
  #   |> put_change(:seller_id, seller_id)
  #   |> put_change(:seller_name, seller_name)
  # end

  # defp put_supul_codes(cs) do
  #   # buyer_supul_code = invoice.buyer.supul_code
  #   seller_supul_code = invoice.seller.supul_code

  #   cs
  #   |> put_change(:buyer_supul_code, buyer_supul_code)
  #   |> put_change(:buyer_supul_code, buyer_supul_code)
  # end

  # defp put_openhash({_ok, invoice}) do
  #   #? serialize the JSON
  #   msg_serialized = Poison.encode!(invoice)

  #   #? generate time-stamp
  #   ts = DateTime.utc_now() |> DateTime.to_unix()

  #   #? add a time-stamp
  #   ts_msg_serialized = "#{ts}|#{msg_serialized}"

  #   openhash = :crypto.hash(:sha256, ts_msg_serialized)
  #     |> Base.encode16()
  #     |> String.downcase()

  #   invoice
  #   |> change
  #   |> put_change(:openhash, openhash)
  #   |> Repo.update
  # end




  # defp get_items(params) do
  #   IO.puts "get items"
  #   items = items_with_prices(params[:invoice_items] || params["invoice_items"])
  #   Enum.map(items, fn(item)-> InvoiceItem.changeset(%InvoiceItem{}, item) end)
  # end


  # defp items_with_prices(items) do
  #   item_ids = Enum.map(items, fn(item) -> item[:item_id] || item["item_id"] end)
  #   q = from(i in Item, select: %{id: i.id, price: i.price}, where: i.id in ^item_ids)

  #   prices = Repo.all(q)

  #   Enum.map(items, fn(item) ->
  #     item_id = item[:item_id] || item["item_id"]
  #     %{
  #        item_id: item_id,
  #        quantity: item[:quantity] || item["quantity"],
  #        price: Enum.find(prices, fn(p) -> p[:id] == item_id end)[:price] || 0
  #      }
  #   end)
  # end

  # defp validate_item_count(cs, params) do
  #   items = params[:invoice_items] || params["invoice_items"]

  #   if Enum.count(items) <= 0 do
  #     add_error(cs, :invoice_items, "Invalid number of items")
  #   else
  #     cs
  #   end
  # end


end
