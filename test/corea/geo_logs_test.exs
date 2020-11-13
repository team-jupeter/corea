defmodule Corea.GeoLogsTest do
  use Corea.DataCase

  alias Corea.GeoLogs

  describe "geo_logs" do
    alias Corea.GeoLogs.GeoLog

    @valid_attrs %{latitude: "some latitude"}
    @update_attrs %{latitude: "some updated latitude"}
    @invalid_attrs %{latitude: nil}

    def geo_log_fixture(attrs \\ %{}) do
      {:ok, geo_log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GeoLogs.create_geo_log()

      geo_log
    end

    test "list_geo_logs/0 returns all geo_logs" do
      geo_log = geo_log_fixture()
      assert GeoLogs.list_geo_logs() == [geo_log]
    end

    test "get_geo_log!/1 returns the geo_log with given id" do
      geo_log = geo_log_fixture()
      assert GeoLogs.get_geo_log!(geo_log.id) == geo_log
    end

    test "create_geo_log/1 with valid data creates a geo_log" do
      assert {:ok, %GeoLog{} = geo_log} = GeoLogs.create_geo_log(@valid_attrs)
      assert geo_log.latitude == "some latitude"
    end

    test "create_geo_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GeoLogs.create_geo_log(@invalid_attrs)
    end

    test "update_geo_log/2 with valid data updates the geo_log" do
      geo_log = geo_log_fixture()
      assert {:ok, %GeoLog{} = geo_log} = GeoLogs.update_geo_log(geo_log, @update_attrs)
      assert geo_log.latitude == "some updated latitude"
    end

    test "update_geo_log/2 with invalid data returns error changeset" do
      geo_log = geo_log_fixture()
      assert {:error, %Ecto.Changeset{}} = GeoLogs.update_geo_log(geo_log, @invalid_attrs)
      assert geo_log == GeoLogs.get_geo_log!(geo_log.id)
    end

    test "delete_geo_log/1 deletes the geo_log" do
      geo_log = geo_log_fixture()
      assert {:ok, %GeoLog{}} = GeoLogs.delete_geo_log(geo_log)
      assert_raise Ecto.NoResultsError, fn -> GeoLogs.get_geo_log!(geo_log.id) end
    end

    test "change_geo_log/1 returns a geo_log changeset" do
      geo_log = geo_log_fixture()
      assert %Ecto.Changeset{} = GeoLogs.change_geo_log(geo_log)
    end
  end
end
