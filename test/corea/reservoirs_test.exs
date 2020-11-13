defmodule Corea.ReservoirsTest do
  use Corea.DataCase

  alias Corea.Reservoirs

  describe "reservoirs" do
    alias Corea.Reservoirs.Reservoir

    @valid_attrs %{abc_t1: "120.5"}
    @update_attrs %{abc_t1: "456.7"}
    @invalid_attrs %{abc_t1: nil}

    def reservoir_fixture(attrs \\ %{}) do
      {:ok, reservoir} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reservoirs.create_reservoir()

      reservoir
    end

    test "list_reservoirs/0 returns all reservoirs" do
      reservoir = reservoir_fixture()
      assert Reservoirs.list_reservoirs() == [reservoir]
    end

    test "get_reservoir!/1 returns the reservoir with given id" do
      reservoir = reservoir_fixture()
      assert Reservoirs.get_reservoir!(reservoir.id) == reservoir
    end

    test "create_reservoir/1 with valid data creates a reservoir" do
      assert {:ok, %Reservoir{} = reservoir} = Reservoirs.create_reservoir(@valid_attrs)
      assert reservoir.abc_t1 == Decimal.new("120.5")
    end

    test "create_reservoir/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservoirs.create_reservoir(@invalid_attrs)
    end

    test "update_reservoir/2 with valid data updates the reservoir" do
      reservoir = reservoir_fixture()
      assert {:ok, %Reservoir{} = reservoir} = Reservoirs.update_reservoir(reservoir, @update_attrs)
      assert reservoir.abc_t1 == Decimal.new("456.7")
    end

    test "update_reservoir/2 with invalid data returns error changeset" do
      reservoir = reservoir_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservoirs.update_reservoir(reservoir, @invalid_attrs)
      assert reservoir == Reservoirs.get_reservoir!(reservoir.id)
    end

    test "delete_reservoir/1 deletes the reservoir" do
      reservoir = reservoir_fixture()
      assert {:ok, %Reservoir{}} = Reservoirs.delete_reservoir(reservoir)
      assert_raise Ecto.NoResultsError, fn -> Reservoirs.get_reservoir!(reservoir.id) end
    end

    test "change_reservoir/1 returns a reservoir changeset" do
      reservoir = reservoir_fixture()
      assert %Ecto.Changeset{} = Reservoirs.change_reservoir(reservoir)
    end
  end
end
