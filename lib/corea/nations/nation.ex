# 한국, 일본, 중국, 미국 ...
defmodule Corea.Nations.Nation do
  use Ecto.Schema
  # alias Corea.Repo
  import Ecto.Changeset
  alias Corea.Nations.Nation

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "nations" do
    field :name, :string

    field :constitution_signature, :string

    has_one :constitution,  Corea.Votes.Constitution, on_replace: :nilify
    has_one :taxation,  Corea.Taxations.Taxation, on_replace: :nilify
    has_many :entities, Corea.Entities.Entity, on_replace: :nilify
    has_many :users, Corea.Accounts.User, on_replace: :nilify
    has_many :families, Corea.Families.Family, on_replace: :nilify

    belongs_to :nation_supul, Corea.Nations.Nation
  end

  @fields [
    :name, :constitution_signature,
  ]
  def changeset(%Nation{} = nation, attrs) do
    nation
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end

  def changeset_supul(%Nation{} = nation, attrs = %{nation_supul: nation_supul}) do
    attrs = Map.merge(attrs, %{nation_supul_id: nation_supul.id})
    nation
    |> cast(attrs, @fields)
    |> put_assoc(:nation_supul, attrs.nation_supul)
  end
end
