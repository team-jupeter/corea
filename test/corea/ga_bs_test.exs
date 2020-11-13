defmodule Corea.GABsTest do
  use Corea.DataCase

  alias Corea.GABs

  describe "gabs" do
    alias Corea.GABs.GAB

    @valid_attrs %{name: "some name", t1_balance: "120.5", t2_balance: "120.5", t3_balance: "120.5", t4_balance: "120.5", t5_balance: "120.5", telephones: [], unique_digits: "some unique_digits"}
    @update_attrs %{name: "some updated name", t1_balance: "456.7", t2_balance: "456.7", t3_balance: "456.7", t4_balance: "456.7", t5_balance: "456.7", telephones: [], unique_digits: "some updated unique_digits"}
    @invalid_attrs %{name: nil, t1_balance: nil, t2_balance: nil, t3_balance: nil, t4_balance: nil, t5_balance: nil, telephones: nil, unique_digits: nil}

    def gab_fixture(attrs \\ %{}) do
      {:ok, gab} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GABs.create_gab()

      gab
    end

    test "list_gabs/0 returns all gabs" do
      gab = gab_fixture()
      assert GABs.list_gabs() == [gab]
    end

    test "get_gab!/1 returns the gab with given id" do
      gab = gab_fixture()
      assert GABs.get_gab!(gab.id) == gab
    end

    test "create_gab/1 with valid data creates a gab" do
      assert {:ok, %GAB{} = gab} = GABs.create_gab(@valid_attrs)
      assert gab.name == "some name"
      assert gab.t1_balance == Decimal.new("120.5")
      assert gab.t2_balance == Decimal.new("120.5")
      assert gab.t3_balance == Decimal.new("120.5")
      assert gab.t4_balance == Decimal.new("120.5")
      assert gab.t5_balance == Decimal.new("120.5")
      assert gab.telephones == []
      assert gab.unique_digits == "some unique_digits"
    end

    test "create_gab/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GABs.create_gab(@invalid_attrs)
    end

    test "update_gab/2 with valid data updates the gab" do
      gab = gab_fixture()
      assert {:ok, %GAB{} = gab} = GABs.update_gab(gab, @update_attrs)
      assert gab.name == "some updated name"
      assert gab.t1_balance == Decimal.new("456.7")
      assert gab.t2_balance == Decimal.new("456.7")
      assert gab.t3_balance == Decimal.new("456.7")
      assert gab.t4_balance == Decimal.new("456.7")
      assert gab.t5_balance == Decimal.new("456.7")
      assert gab.telephones == []
      assert gab.unique_digits == "some updated unique_digits"
    end

    test "update_gab/2 with invalid data returns error changeset" do
      gab = gab_fixture()
      assert {:error, %Ecto.Changeset{}} = GABs.update_gab(gab, @invalid_attrs)
      assert gab == GABs.get_gab!(gab.id)
    end

    test "delete_gab/1 deletes the gab" do
      gab = gab_fixture()
      assert {:ok, %GAB{}} = GABs.delete_gab(gab)
      assert_raise Ecto.NoResultsError, fn -> GABs.get_gab!(gab.id) end
    end

    test "change_gab/1 returns a gab changeset" do
      gab = gab_fixture()
      assert %Ecto.Changeset{} = GABs.change_gab(gab)
    end
  end
end
