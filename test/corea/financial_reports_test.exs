defmodule Corea.FinancialReportsTest do
  use Corea.DataCase

  alias Corea.FinancialReports

  describe "financial_reports" do
    alias Corea.FinancialReports.FinancialReport

    @valid_attrs %{entity_name: "some entity_name"}
    @update_attrs %{entity_name: "some updated entity_name"}
    @invalid_attrs %{entity_name: nil}

    def financial_report_fixture(attrs \\ %{}) do
      {:ok, financial_report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FinancialReports.create_financial_report()

      financial_report
    end

    test "list_financial_reports/0 returns all financial_reports" do
      financial_report = financial_report_fixture()
      assert FinancialReports.list_financial_reports() == [financial_report]
    end

    test "get_financial_report!/1 returns the financial_report with given id" do
      financial_report = financial_report_fixture()
      assert FinancialReports.get_financial_report!(financial_report.id) == financial_report
    end

    test "create_financial_report/1 with valid data creates a financial_report" do
      assert {:ok, %FinancialReport{} = financial_report} = FinancialReports.create_financial_report(@valid_attrs)
      assert financial_report.entity_name == "some entity_name"
    end

    test "create_financial_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FinancialReports.create_financial_report(@invalid_attrs)
    end

    test "update_financial_report/2 with valid data updates the financial_report" do
      financial_report = financial_report_fixture()
      assert {:ok, %FinancialReport{} = financial_report} = FinancialReports.update_financial_report(financial_report, @update_attrs)
      assert financial_report.entity_name == "some updated entity_name"
    end

    test "update_financial_report/2 with invalid data returns error changeset" do
      financial_report = financial_report_fixture()
      assert {:error, %Ecto.Changeset{}} = FinancialReports.update_financial_report(financial_report, @invalid_attrs)
      assert financial_report == FinancialReports.get_financial_report!(financial_report.id)
    end

    test "delete_financial_report/1 deletes the financial_report" do
      financial_report = financial_report_fixture()
      assert {:ok, %FinancialReport{}} = FinancialReports.delete_financial_report(financial_report)
      assert_raise Ecto.NoResultsError, fn -> FinancialReports.get_financial_report!(financial_report.id) end
    end

    test "change_financial_report/1 returns a financial_report changeset" do
      financial_report = financial_report_fixture()
      assert %Ecto.Changeset{} = FinancialReports.change_financial_report(financial_report)
    end
  end
end
