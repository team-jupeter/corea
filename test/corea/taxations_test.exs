defmodule Corea.TaxationsTest do
  use Corea.DataCase

  alias Corea.Taxations

  describe "taxations" do
    alias Corea.Taxations.Taxation

    @valid_attrs %{auth_code: "some auth_code", name: "some name", t1_balance: "120.5", telephones: [], unique_digits: "some unique_digits"}
    @update_attrs %{auth_code: "some updated auth_code", name: "some updated name", t1_balance: "456.7", telephones: [], unique_digits: "some updated unique_digits"}
    @invalid_attrs %{auth_code: nil, name: nil, t1_balance: nil, telephones: nil, unique_digits: nil}

    def taxation_fixture(attrs \\ %{}) do
      {:ok, taxation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Taxations.create_taxation()

      taxation
    end

    test "list_taxations/0 returns all taxations" do
      taxation = taxation_fixture()
      assert Taxations.list_taxations() == [taxation]
    end

    test "get_taxation!/1 returns the taxation with given id" do
      taxation = taxation_fixture()
      assert Taxations.get_taxation!(taxation.id) == taxation
    end

    test "create_taxation/1 with valid data creates a taxation" do
      assert {:ok, %Taxation{} = taxation} = Taxations.create_taxation(@valid_attrs)
      assert taxation.auth_code == "some auth_code"
      assert taxation.name == "some name"
      assert taxation.t1_balance == Decimal.new("120.5")
      assert taxation.telephones == []
      assert taxation.unique_digits == "some unique_digits"
    end

    test "create_taxation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxations.create_taxation(@invalid_attrs)
    end

    test "update_taxation/2 with valid data updates the taxation" do
      taxation = taxation_fixture()
      assert {:ok, %Taxation{} = taxation} = Taxations.update_taxation(taxation, @update_attrs)
      assert taxation.auth_code == "some updated auth_code"
      assert taxation.name == "some updated name"
      assert taxation.t1_balance == Decimal.new("456.7")
      assert taxation.telephones == []
      assert taxation.unique_digits == "some updated unique_digits"
    end

    test "update_taxation/2 with invalid data returns error changeset" do
      taxation = taxation_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxations.update_taxation(taxation, @invalid_attrs)
      assert taxation == Taxations.get_taxation!(taxation.id)
    end

    test "delete_taxation/1 deletes the taxation" do
      taxation = taxation_fixture()
      assert {:ok, %Taxation{}} = Taxations.delete_taxation(taxation)
      assert_raise Ecto.NoResultsError, fn -> Taxations.get_taxation!(taxation.id) end
    end

    test "change_taxation/1 returns a taxation changeset" do
      taxation = taxation_fixture()
      assert %Ecto.Changeset{} = Taxations.change_taxation(taxation)
    end
  end
end
