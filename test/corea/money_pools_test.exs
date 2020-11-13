defmodule Corea.MoneyPoolsTest do
  use Corea.DataCase

  alias Corea.MoneyPools

  describe "money_pools" do
    alias Corea.MoneyPools.MoneyPool

    @valid_attrs %{t1: "120.5"}
    @update_attrs %{t1: "456.7"}
    @invalid_attrs %{t1: nil}

    def money_pool_fixture(attrs \\ %{}) do
      {:ok, money_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MoneyPools.create_money_pool()

      money_pool
    end

    test "list_money_pools/0 returns all money_pools" do
      money_pool = money_pool_fixture()
      assert MoneyPools.list_money_pools() == [money_pool]
    end

    test "get_money_pool!/1 returns the money_pool with given id" do
      money_pool = money_pool_fixture()
      assert MoneyPools.get_money_pool!(money_pool.id) == money_pool
    end

    test "create_money_pool/1 with valid data creates a money_pool" do
      assert {:ok, %MoneyPool{} = money_pool} = MoneyPools.create_money_pool(@valid_attrs)
      assert money_pool.t1 == Decimal.new("120.5")
    end

    test "create_money_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MoneyPools.create_money_pool(@invalid_attrs)
    end

    test "update_money_pool/2 with valid data updates the money_pool" do
      money_pool = money_pool_fixture()
      assert {:ok, %MoneyPool{} = money_pool} = MoneyPools.update_money_pool(money_pool, @update_attrs)
      assert money_pool.t1 == Decimal.new("456.7")
    end

    test "update_money_pool/2 with invalid data returns error changeset" do
      money_pool = money_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = MoneyPools.update_money_pool(money_pool, @invalid_attrs)
      assert money_pool == MoneyPools.get_money_pool!(money_pool.id)
    end

    test "delete_money_pool/1 deletes the money_pool" do
      money_pool = money_pool_fixture()
      assert {:ok, %MoneyPool{}} = MoneyPools.delete_money_pool(money_pool)
      assert_raise Ecto.NoResultsError, fn -> MoneyPools.get_money_pool!(money_pool.id) end
    end

    test "change_money_pool/1 returns a money_pool changeset" do
      money_pool = money_pool_fixture()
      assert %Ecto.Changeset{} = MoneyPools.change_money_pool(money_pool)
    end
  end
end
