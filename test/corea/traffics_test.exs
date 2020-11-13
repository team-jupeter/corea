defmodule Corea.TrafficsTest do
  use Corea.DataCase

  alias Corea.Traffics

  describe "traffics" do
    alias Corea.Traffics.Traffic

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def traffic_fixture(attrs \\ %{}) do
      {:ok, traffic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Traffics.create_traffic()

      traffic
    end

    test "list_traffics/0 returns all traffics" do
      traffic = traffic_fixture()
      assert Traffics.list_traffics() == [traffic]
    end

    test "get_traffic!/1 returns the traffic with given id" do
      traffic = traffic_fixture()
      assert Traffics.get_traffic!(traffic.id) == traffic
    end

    test "create_traffic/1 with valid data creates a traffic" do
      assert {:ok, %Traffic{} = traffic} = Traffics.create_traffic(@valid_attrs)
      assert traffic.type == "some type"
    end

    test "create_traffic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Traffics.create_traffic(@invalid_attrs)
    end

    test "update_traffic/2 with valid data updates the traffic" do
      traffic = traffic_fixture()
      assert {:ok, %Traffic{} = traffic} = Traffics.update_traffic(traffic, @update_attrs)
      assert traffic.type == "some updated type"
    end

    test "update_traffic/2 with invalid data returns error changeset" do
      traffic = traffic_fixture()
      assert {:error, %Ecto.Changeset{}} = Traffics.update_traffic(traffic, @invalid_attrs)
      assert traffic == Traffics.get_traffic!(traffic.id)
    end

    test "delete_traffic/1 deletes the traffic" do
      traffic = traffic_fixture()
      assert {:ok, %Traffic{}} = Traffics.delete_traffic(traffic)
      assert_raise Ecto.NoResultsError, fn -> Traffics.get_traffic!(traffic.id) end
    end

    test "change_traffic/1 returns a traffic changeset" do
      traffic = traffic_fixture()
      assert %Ecto.Changeset{} = Traffics.change_traffic(traffic)
    end
  end
end
