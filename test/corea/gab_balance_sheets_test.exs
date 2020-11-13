defmodule Corea.GABBalanceSheetsTest do
  use Corea.DataCase

  alias Corea.GABBalanceSheets

  describe "gab_balance_sheets" do
    alias Corea.GABBalanceSheets.GABBalanceSheet

    @valid_attrs %{t1: "120.5"}
    @update_attrs %{t1: "456.7"}
    @invalid_attrs %{t1: nil}

    def gab_balance_sheet_fixture(attrs \\ %{}) do
      {:ok, gab_balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GABBalanceSheets.create_gab_balance_sheet()

      gab_balance_sheet
    end

    test "list_gab_balance_sheets/0 returns all gab_balance_sheets" do
      gab_balance_sheet = gab_balance_sheet_fixture()
      assert GABBalanceSheets.list_gab_balance_sheets() == [gab_balance_sheet]
    end

    test "get_gab_balance_sheet!/1 returns the gab_balance_sheet with given id" do
      gab_balance_sheet = gab_balance_sheet_fixture()
      assert GABBalanceSheets.get_gab_balance_sheet!(gab_balance_sheet.id) == gab_balance_sheet
    end

    test "create_gab_balance_sheet/1 with valid data creates a gab_balance_sheet" do
      assert {:ok, %GABBalanceSheet{} = gab_balance_sheet} = GABBalanceSheets.create_gab_balance_sheet(@valid_attrs)
      assert gab_balance_sheet.t1 == Decimal.new("120.5")
    end

    test "create_gab_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GABBalanceSheets.create_gab_balance_sheet(@invalid_attrs)
    end

    test "update_gab_balance_sheet/2 with valid data updates the gab_balance_sheet" do
      gab_balance_sheet = gab_balance_sheet_fixture()
      assert {:ok, %GABBalanceSheet{} = gab_balance_sheet} = GABBalanceSheets.update_gab_balance_sheet(gab_balance_sheet, @update_attrs)
      assert gab_balance_sheet.t1 == Decimal.new("456.7")
    end

    test "update_gab_balance_sheet/2 with invalid data returns error changeset" do
      gab_balance_sheet = gab_balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = GABBalanceSheets.update_gab_balance_sheet(gab_balance_sheet, @invalid_attrs)
      assert gab_balance_sheet == GABBalanceSheets.get_gab_balance_sheet!(gab_balance_sheet.id)
    end

    test "delete_gab_balance_sheet/1 deletes the gab_balance_sheet" do
      gab_balance_sheet = gab_balance_sheet_fixture()
      assert {:ok, %GABBalanceSheet{}} = GABBalanceSheets.delete_gab_balance_sheet(gab_balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> GABBalanceSheets.get_gab_balance_sheet!(gab_balance_sheet.id) end
    end

    test "change_gab_balance_sheet/1 returns a gab_balance_sheet changeset" do
      gab_balance_sheet = gab_balance_sheet_fixture()
      assert %Ecto.Changeset{} = GABBalanceSheets.change_gab_balance_sheet(gab_balance_sheet)
    end
  end
end
