defmodule Corea.FamiliesTest do
  use Corea.DataCase

  alias Corea.Families

  describe "families" do
    alias Corea.Families.Family

    @valid_attrs %{address: "some address", auth_code: "some auth_code", family_code: "some family_code", house_holder_email: "some house_holder_email", house_holder_name: "some house_holder_name", house_holder_supul_id: "some house_holder_supul_id", nationality: "some nationality", t1_balance: "120.5"}
    @update_attrs %{address: "some updated address", auth_code: "some updated auth_code", family_code: "some updated family_code", house_holder_email: "some updated house_holder_email", house_holder_name: "some updated house_holder_name", house_holder_supul_id: "some updated house_holder_supul_id", nationality: "some updated nationality", t1_balance: "456.7"}
    @invalid_attrs %{address: nil, auth_code: nil, family_code: nil, house_holder_email: nil, house_holder_name: nil, house_holder_supul_id: nil, nationality: nil, t1_balance: nil}

    def family_fixture(attrs \\ %{}) do
      {:ok, family} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Families.create_family()

      family
    end

    test "list_families/0 returns all families" do
      family = family_fixture()
      assert Families.list_families() == [family]
    end

    test "get_family!/1 returns the family with given id" do
      family = family_fixture()
      assert Families.get_family!(family.id) == family
    end

    test "create_family/1 with valid data creates a family" do
      assert {:ok, %Family{} = family} = Families.create_family(@valid_attrs)
      assert family.address == "some address"
      assert family.auth_code == "some auth_code"
      assert family.family_code == "some family_code"
      assert family.house_holder_email == "some house_holder_email"
      assert family.house_holder_name == "some house_holder_name"
      assert family.house_holder_supul_id == "some house_holder_supul_id"
      assert family.nationality == "some nationality"
      assert family.t1_balance == Decimal.new("120.5")
    end

    test "create_family/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Families.create_family(@invalid_attrs)
    end

    test "update_family/2 with valid data updates the family" do
      family = family_fixture()
      assert {:ok, %Family{} = family} = Families.update_family(family, @update_attrs)
      assert family.address == "some updated address"
      assert family.auth_code == "some updated auth_code"
      assert family.family_code == "some updated family_code"
      assert family.house_holder_email == "some updated house_holder_email"
      assert family.house_holder_name == "some updated house_holder_name"
      assert family.house_holder_supul_id == "some updated house_holder_supul_id"
      assert family.nationality == "some updated nationality"
      assert family.t1_balance == Decimal.new("456.7")
    end

    test "update_family/2 with invalid data returns error changeset" do
      family = family_fixture()
      assert {:error, %Ecto.Changeset{}} = Families.update_family(family, @invalid_attrs)
      assert family == Families.get_family!(family.id)
    end

    test "delete_family/1 deletes the family" do
      family = family_fixture()
      assert {:ok, %Family{}} = Families.delete_family(family)
      assert_raise Ecto.NoResultsError, fn -> Families.get_family!(family.id) end
    end

    test "change_family/1 returns a family changeset" do
      family = family_fixture()
      assert %Ecto.Changeset{} = Families.change_family(family)
    end
  end
end
