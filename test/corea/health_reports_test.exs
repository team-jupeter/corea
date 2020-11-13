defmodule Corea.HealthReportsTest do
  use Corea.DataCase

  alias Corea.HealthReports

  describe "health_reports" do
    alias Corea.HealthReports.HealthReport

    @valid_attrs %{dna: "120.5"}
    @update_attrs %{dna: "456.7"}
    @invalid_attrs %{dna: nil}

    def health_report_fixture(attrs \\ %{}) do
      {:ok, health_report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HealthReports.create_health_report()

      health_report
    end

    test "list_health_reports/0 returns all health_reports" do
      health_report = health_report_fixture()
      assert HealthReports.list_health_reports() == [health_report]
    end

    test "get_health_report!/1 returns the health_report with given id" do
      health_report = health_report_fixture()
      assert HealthReports.get_health_report!(health_report.id) == health_report
    end

    test "create_health_report/1 with valid data creates a health_report" do
      assert {:ok, %HealthReport{} = health_report} = HealthReports.create_health_report(@valid_attrs)
      assert health_report.dna == Decimal.new("120.5")
    end

    test "create_health_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HealthReports.create_health_report(@invalid_attrs)
    end

    test "update_health_report/2 with valid data updates the health_report" do
      health_report = health_report_fixture()
      assert {:ok, %HealthReport{} = health_report} = HealthReports.update_health_report(health_report, @update_attrs)
      assert health_report.dna == Decimal.new("456.7")
    end

    test "update_health_report/2 with invalid data returns error changeset" do
      health_report = health_report_fixture()
      assert {:error, %Ecto.Changeset{}} = HealthReports.update_health_report(health_report, @invalid_attrs)
      assert health_report == HealthReports.get_health_report!(health_report.id)
    end

    test "delete_health_report/1 deletes the health_report" do
      health_report = health_report_fixture()
      assert {:ok, %HealthReport{}} = HealthReports.delete_health_report(health_report)
      assert_raise Ecto.NoResultsError, fn -> HealthReports.get_health_report!(health_report.id) end
    end

    test "change_health_report/1 returns a health_report changeset" do
      health_report = health_report_fixture()
      assert %Ecto.Changeset{} = HealthReports.change_health_report(health_report)
    end
  end
end
