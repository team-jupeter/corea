defmodule Corea.Gopang.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tickets" do
    field :invoice_id, :binary_id
    field :package_size, {:array, :map}
    field :package_weight, :integer
    field :box_type, :string
    field :departure, :string
    field :destination, :string
    field :input, {:array, :map}, default: []
    field :output, {:array, :map}, default: []
    field :transport_type, :string
    field :transport_id, :string
    field :valid_until, :naive_datetime
    field :issued_by, :string
    field :user_id, :string
    field :departure_time, :naive_datetime
    field :arrival_time, :naive_datetime
    field :departing_terminal, :string #? terminal_name
    field :arrival_terminal, :string #? terminal_name
    field :gate, :string
    field :seat, :string
    field :caution, :string
    field :gopang_fee, :decimal, precision: 15, scale: 4
    field :status, :string, default: "ticket accepted"
    field :distance, :decimal, precision: 15, scale: 4

    embeds_many :road_sections, Corea.Gopangs.RoadSectionEmbed
    embeds_many :stations, Corea.Gopangs.StationEmbed
    embeds_one :route, Corea.Gopangs.RouteEmbed
    embeds_one :deliverybox, Corea.Gopangs.DeliveryboxEmbed

    belongs_to :transaction, Corea.Transactions.Transaction, type: :binary_id
    belongs_to :entity, Corea.Entities.Entity, type: :binary_id
    belongs_to :car, Corea.Cars.Car, type: :binary_id

    timestamps()
    end


    @fields [
      :invoice_id,
      :package_size,
      :package_weight,
      :box_type,
      :departure,
      :destination,
      :input,
      :output,
      :departure_time,
      :arrival_time,
      :caution,
      :gopang_fee,
    ]

  @doc false
  def changeset(ticket, attrs \\ %{}) do
    ticket
    |> cast(attrs, @fields)
    |> validate_required([])
    |> cast_embed(:route)
  end
end
