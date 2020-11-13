defmodule Corea.GovBalanceSheetsTest do
  use Corea.DataCase

  alias Corea.GovBalanceSheets

  describe "gov_balance_sheets" do
    alias Corea.GovBalanceSheets.GovBalanceSheet

    @valid_attrs %{monetary_unit: "some monetary_unit"}
    @update_attrs %{monetary_unit: "some updated monetary_unit"}
    @invalid_attrs %{monetary_unit: nil}

    def gov_balance_sheet_fixture(attrs \\ %{}) do
      {:ok, gov_balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GovBalanceSheets.create_gov_balance_sheet()

      gov_balance_sheet
    end

    test "list_gov_balance_sheets/0 returns all gov_balance_sheets" do
      gov_balance_sheet = gov_balance_sheet_fixture()
      assert GovBalanceSheets.list_gov_balance_sheets() == [gov_balance_sheet]
    end

    test "get_gov_balance_sheet!/1 returns the gov_balance_sheet with given id" do
      gov_balance_sheet = gov_balance_sheet_fixture()
      assert GovBalanceSheets.get_gov_balance_sheet!(gov_balance_sheet.id) == gov_balance_sheet
    end

    test "create_gov_balance_sheet/1 with valid data creates a gov_balance_sheet" do
      assert {:ok, %GovBalanceSheet{} = gov_balance_sheet} = GovBalanceSheets.create_gov_balance_sheet(@valid_attrs)
      assert gov_balance_sheet.monetary_unit == "some monetary_unit"
    end

    test "create_gov_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GovBalanceSheets.create_gov_balance_sheet(@invalid_attrs)
    end

    test "update_gov_balance_sheet/2 with valid data updates the gov_balance_sheet" do
      gov_balance_sheet = gov_balance_sheet_fixture()
      assert {:ok, %GovBalanceSheet{} = gov_balance_sheet} = GovBalanceSheets.update_gov_balance_sheet(gov_balance_sheet, @update_attrs)
      assert gov_balance_sheet.monetary_unit == "some updated monetary_unit"
    end

    test "update_gov_balance_sheet/2 with invalid data returns error changeset" do
      gov_balance_sheet = gov_balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = GovBalanceSheets.update_gov_balance_sheet(gov_balance_sheet, @invalid_attrs)
      assert gov_balance_sheet == GovBalanceSheets.get_gov_balance_sheet!(gov_balance_sheet.id)
    end

    test "delete_gov_balance_sheet/1 deletes the gov_balance_sheet" do
      gov_balance_sheet = gov_balance_sheet_fixture()
      assert {:ok, %GovBalanceSheet{}} = GovBalanceSheets.delete_gov_balance_sheet(gov_balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> GovBalanceSheets.get_gov_balance_sheet!(gov_balance_sheet.id) end
    end

    test "change_gov_balance_sheet/1 returns a gov_balance_sheet changeset" do
      gov_balance_sheet = gov_balance_sheet_fixture()
      assert %Ecto.Changeset{} = GovBalanceSheets.change_gov_balance_sheet(gov_balance_sheet)
    end
  end
end
