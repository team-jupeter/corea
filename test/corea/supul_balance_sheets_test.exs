defmodule Corea.SupulBalanceSheetsTest do
  use Corea.DataCase

  alias Corea.SupulBalanceSheets

  describe "supul_balance_sheets" do
    alias Corea.SupulBalanceSheets.SupulBalanceSheet

    @valid_attrs %{monetary_unit: "some monetary_unit"}
    @update_attrs %{monetary_unit: "some updated monetary_unit"}
    @invalid_attrs %{monetary_unit: nil}

    def supul_balance_sheet_fixture(attrs \\ %{}) do
      {:ok, supul_balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SupulBalanceSheets.create_supul_balance_sheet()

      supul_balance_sheet
    end

    test "list_supul_balance_sheets/0 returns all supul_balance_sheets" do
      supul_balance_sheet = supul_balance_sheet_fixture()
      assert SupulBalanceSheets.list_supul_balance_sheets() == [supul_balance_sheet]
    end

    test "get_supul_balance_sheet!/1 returns the supul_balance_sheet with given id" do
      supul_balance_sheet = supul_balance_sheet_fixture()
      assert SupulBalanceSheets.get_supul_balance_sheet!(supul_balance_sheet.id) == supul_balance_sheet
    end

    test "create_supul_balance_sheet/1 with valid data creates a supul_balance_sheet" do
      assert {:ok, %SupulBalanceSheet{} = supul_balance_sheet} = SupulBalanceSheets.create_supul_balance_sheet(@valid_attrs)
      assert supul_balance_sheet.monetary_unit == "some monetary_unit"
    end

    test "create_supul_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SupulBalanceSheets.create_supul_balance_sheet(@invalid_attrs)
    end

    test "update_supul_balance_sheet/2 with valid data updates the supul_balance_sheet" do
      supul_balance_sheet = supul_balance_sheet_fixture()
      assert {:ok, %SupulBalanceSheet{} = supul_balance_sheet} = SupulBalanceSheets.update_supul_balance_sheet(supul_balance_sheet, @update_attrs)
      assert supul_balance_sheet.monetary_unit == "some updated monetary_unit"
    end

    test "update_supul_balance_sheet/2 with invalid data returns error changeset" do
      supul_balance_sheet = supul_balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = SupulBalanceSheets.update_supul_balance_sheet(supul_balance_sheet, @invalid_attrs)
      assert supul_balance_sheet == SupulBalanceSheets.get_supul_balance_sheet!(supul_balance_sheet.id)
    end

    test "delete_supul_balance_sheet/1 deletes the supul_balance_sheet" do
      supul_balance_sheet = supul_balance_sheet_fixture()
      assert {:ok, %SupulBalanceSheet{}} = SupulBalanceSheets.delete_supul_balance_sheet(supul_balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> SupulBalanceSheets.get_supul_balance_sheet!(supul_balance_sheet.id) end
    end

    test "change_supul_balance_sheet/1 returns a supul_balance_sheet changeset" do
      supul_balance_sheet = supul_balance_sheet_fixture()
      assert %Ecto.Changeset{} = SupulBalanceSheets.change_supul_balance_sheet(supul_balance_sheet)
    end
  end
end
