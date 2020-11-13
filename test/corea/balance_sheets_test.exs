defmodule Corea.BalanceSheetsTest do
  use Corea.DataCase

  alias Corea.BalanceSheets

  describe "balance_sheets" do
    alias Corea.BalanceSheets.BalanceSheet

    @valid_attrs %{entity_name: "some entity_name"}
    @update_attrs %{entity_name: "some updated entity_name"}
    @invalid_attrs %{entity_name: nil}

    def balance_sheet_fixture(attrs \\ %{}) do
      {:ok, balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BalanceSheets.create_balance_sheet()

      balance_sheet
    end

    test "list_balance_sheets/0 returns all balance_sheets" do
      balance_sheet = balance_sheet_fixture()
      assert BalanceSheets.list_balance_sheets() == [balance_sheet]
    end

    test "get_balance_sheet!/1 returns the balance_sheet with given id" do
      balance_sheet = balance_sheet_fixture()
      assert BalanceSheets.get_balance_sheet!(balance_sheet.id) == balance_sheet
    end

    test "create_balance_sheet/1 with valid data creates a balance_sheet" do
      assert {:ok, %BalanceSheet{} = balance_sheet} = BalanceSheets.create_balance_sheet(@valid_attrs)
      assert balance_sheet.entity_name == "some entity_name"
    end

    test "create_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BalanceSheets.create_balance_sheet(@invalid_attrs)
    end

    test "update_balance_sheet/2 with valid data updates the balance_sheet" do
      balance_sheet = balance_sheet_fixture()
      assert {:ok, %BalanceSheet{} = balance_sheet} = BalanceSheets.update_balance_sheet(balance_sheet, @update_attrs)
      assert balance_sheet.entity_name == "some updated entity_name"
    end

    test "update_balance_sheet/2 with invalid data returns error changeset" do
      balance_sheet = balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = BalanceSheets.update_balance_sheet(balance_sheet, @invalid_attrs)
      assert balance_sheet == BalanceSheets.get_balance_sheet!(balance_sheet.id)
    end

    test "delete_balance_sheet/1 deletes the balance_sheet" do
      balance_sheet = balance_sheet_fixture()
      assert {:ok, %BalanceSheet{}} = BalanceSheets.delete_balance_sheet(balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> BalanceSheets.get_balance_sheet!(balance_sheet.id) end
    end

    test "change_balance_sheet/1 returns a balance_sheet changeset" do
      balance_sheet = balance_sheet_fixture()
      assert %Ecto.Changeset{} = BalanceSheets.change_balance_sheet(balance_sheet)
    end
  end
end
