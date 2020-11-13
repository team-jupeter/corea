defmodule Corea.T1PoolsTest do
  use Corea.DataCase

  alias Corea.T1Pools

  describe "t1_pools" do
    alias Corea.T1Pools.T1Pool

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def t1_pool_fixture(attrs \\ %{}) do
      {:ok, t1_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T1Pools.create_t1_pool()

      t1_pool
    end

    test "list_t1_pools/0 returns all t1_pools" do
      t1_pool = t1_pool_fixture()
      assert T1Pools.list_t1_pools() == [t1_pool]
    end

    test "get_t1_pool!/1 returns the t1_pool with given id" do
      t1_pool = t1_pool_fixture()
      assert T1Pools.get_t1_pool!(t1_pool.id) == t1_pool
    end

    test "create_t1_pool/1 with valid data creates a t1_pool" do
      assert {:ok, %T1Pool{} = t1_pool} = T1Pools.create_t1_pool(@valid_attrs)
      assert t1_pool.name == "some name"
    end

    test "create_t1_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T1Pools.create_t1_pool(@invalid_attrs)
    end

    test "update_t1_pool/2 with valid data updates the t1_pool" do
      t1_pool = t1_pool_fixture()
      assert {:ok, %T1Pool{} = t1_pool} = T1Pools.update_t1_pool(t1_pool, @update_attrs)
      assert t1_pool.name == "some updated name"
    end

    test "update_t1_pool/2 with invalid data returns error changeset" do
      t1_pool = t1_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T1Pools.update_t1_pool(t1_pool, @invalid_attrs)
      assert t1_pool == T1Pools.get_t1_pool!(t1_pool.id)
    end

    test "delete_t1_pool/1 deletes the t1_pool" do
      t1_pool = t1_pool_fixture()
      assert {:ok, %T1Pool{}} = T1Pools.delete_t1_pool(t1_pool)
      assert_raise Ecto.NoResultsError, fn -> T1Pools.get_t1_pool!(t1_pool.id) end
    end

    test "change_t1_pool/1 returns a t1_pool changeset" do
      t1_pool = t1_pool_fixture()
      assert %Ecto.Changeset{} = T1Pools.change_t1_pool(t1_pool)
    end
  end
end
