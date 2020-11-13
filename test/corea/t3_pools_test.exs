defmodule Corea.T3PoolsTest do
  use Corea.DataCase

  alias Corea.T3Pools

  describe "t3_pools" do
    alias Corea.T3Pools.T3Pool

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def t3_pool_fixture(attrs \\ %{}) do
      {:ok, t3_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T3Pools.create_t3_pool()

      t3_pool
    end

    test "list_t3_pools/0 returns all t3_pools" do
      t3_pool = t3_pool_fixture()
      assert T3Pools.list_t3_pools() == [t3_pool]
    end

    test "get_t3_pool!/1 returns the t3_pool with given id" do
      t3_pool = t3_pool_fixture()
      assert T3Pools.get_t3_pool!(t3_pool.id) == t3_pool
    end

    test "create_t3_pool/1 with valid data creates a t3_pool" do
      assert {:ok, %T3Pool{} = t3_pool} = T3Pools.create_t3_pool(@valid_attrs)
      assert t3_pool.name == "some name"
    end

    test "create_t3_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T3Pools.create_t3_pool(@invalid_attrs)
    end

    test "update_t3_pool/2 with valid data updates the t3_pool" do
      t3_pool = t3_pool_fixture()
      assert {:ok, %T3Pool{} = t3_pool} = T3Pools.update_t3_pool(t3_pool, @update_attrs)
      assert t3_pool.name == "some updated name"
    end

    test "update_t3_pool/2 with invalid data returns error changeset" do
      t3_pool = t3_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T3Pools.update_t3_pool(t3_pool, @invalid_attrs)
      assert t3_pool == T3Pools.get_t3_pool!(t3_pool.id)
    end

    test "delete_t3_pool/1 deletes the t3_pool" do
      t3_pool = t3_pool_fixture()
      assert {:ok, %T3Pool{}} = T3Pools.delete_t3_pool(t3_pool)
      assert_raise Ecto.NoResultsError, fn -> T3Pools.get_t3_pool!(t3_pool.id) end
    end

    test "change_t3_pool/1 returns a t3_pool changeset" do
      t3_pool = t3_pool_fixture()
      assert %Ecto.Changeset{} = T3Pools.change_t3_pool(t3_pool)
    end
  end
end
