defmodule Corea.GopangBalanceSheetsTest do
  use Corea.DataCase

  alias Corea.GopangBalanceSheets

  describe "gopang_balance_sheets" do
    alias Corea.GopangBalanceSheets.GopangBalanceSheet

    @valid_attrs %{monetary_unit: "some monetary_unit"}
    @update_attrs %{monetary_unit: "some updated monetary_unit"}
    @invalid_attrs %{monetary_unit: nil}

    def gopang_balance_sheet_fixture(attrs \\ %{}) do
      {:ok, gopang_balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GopangBalanceSheets.create_gopang_balance_sheet()

      gopang_balance_sheet
    end

    test "list_gopang_balance_sheets/0 returns all gopang_balance_sheets" do
      gopang_balance_sheet = gopang_balance_sheet_fixture()
      assert GopangBalanceSheets.list_gopang_balance_sheets() == [gopang_balance_sheet]
    end

    test "get_gopang_balance_sheet!/1 returns the gopang_balance_sheet with given id" do
      gopang_balance_sheet = gopang_balance_sheet_fixture()
      assert GopangBalanceSheets.get_gopang_balance_sheet!(gopang_balance_sheet.id) == gopang_balance_sheet
    end

    test "create_gopang_balance_sheet/1 with valid data creates a gopang_balance_sheet" do
      assert {:ok, %GopangBalanceSheet{} = gopang_balance_sheet} = GopangBalanceSheets.create_gopang_balance_sheet(@valid_attrs)
      assert gopang_balance_sheet.monetary_unit == "some monetary_unit"
    end

    test "create_gopang_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GopangBalanceSheets.create_gopang_balance_sheet(@invalid_attrs)
    end

    test "update_gopang_balance_sheet/2 with valid data updates the gopang_balance_sheet" do
      gopang_balance_sheet = gopang_balance_sheet_fixture()
      assert {:ok, %GopangBalanceSheet{} = gopang_balance_sheet} = GopangBalanceSheets.update_gopang_balance_sheet(gopang_balance_sheet, @update_attrs)
      assert gopang_balance_sheet.monetary_unit == "some updated monetary_unit"
    end

    test "update_gopang_balance_sheet/2 with invalid data returns error changeset" do
      gopang_balance_sheet = gopang_balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = GopangBalanceSheets.update_gopang_balance_sheet(gopang_balance_sheet, @invalid_attrs)
      assert gopang_balance_sheet == GopangBalanceSheets.get_gopang_balance_sheet!(gopang_balance_sheet.id)
    end

    test "delete_gopang_balance_sheet/1 deletes the gopang_balance_sheet" do
      gopang_balance_sheet = gopang_balance_sheet_fixture()
      assert {:ok, %GopangBalanceSheet{}} = GopangBalanceSheets.delete_gopang_balance_sheet(gopang_balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> GopangBalanceSheets.get_gopang_balance_sheet!(gopang_balance_sheet.id) end
    end

    test "change_gopang_balance_sheet/1 returns a gopang_balance_sheet changeset" do
      gopang_balance_sheet = gopang_balance_sheet_fixture()
      assert %Ecto.Changeset{} = GopangBalanceSheets.change_gopang_balance_sheet(gopang_balance_sheet)
    end
  end
end
