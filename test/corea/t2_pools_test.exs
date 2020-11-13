defmodule Corea.T2PoolsTest do
  use Corea.DataCase

  alias Corea.T2Pools

  describe "t2_pools" do
    alias Corea.T2Pools.T2Pool

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def t2_pool_fixture(attrs \\ %{}) do
      {:ok, t2_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T2Pools.create_t2_pool()

      t2_pool
    end

    test "list_t2_pools/0 returns all t2_pools" do
      t2_pool = t2_pool_fixture()
      assert T2Pools.list_t2_pools() == [t2_pool]
    end

    test "get_t2_pool!/1 returns the t2_pool with given id" do
      t2_pool = t2_pool_fixture()
      assert T2Pools.get_t2_pool!(t2_pool.id) == t2_pool
    end

    test "create_t2_pool/1 with valid data creates a t2_pool" do
      assert {:ok, %T2Pool{} = t2_pool} = T2Pools.create_t2_pool(@valid_attrs)
      assert t2_pool.name == "some name"
    end

    test "create_t2_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T2Pools.create_t2_pool(@invalid_attrs)
    end

    test "update_t2_pool/2 with valid data updates the t2_pool" do
      t2_pool = t2_pool_fixture()
      assert {:ok, %T2Pool{} = t2_pool} = T2Pools.update_t2_pool(t2_pool, @update_attrs)
      assert t2_pool.name == "some updated name"
    end

    test "update_t2_pool/2 with invalid data returns error changeset" do
      t2_pool = t2_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T2Pools.update_t2_pool(t2_pool, @invalid_attrs)
      assert t2_pool == T2Pools.get_t2_pool!(t2_pool.id)
    end

    test "delete_t2_pool/1 deletes the t2_pool" do
      t2_pool = t2_pool_fixture()
      assert {:ok, %T2Pool{}} = T2Pools.delete_t2_pool(t2_pool)
      assert_raise Ecto.NoResultsError, fn -> T2Pools.get_t2_pool!(t2_pool.id) end
    end

    test "change_t2_pool/1 returns a t2_pool changeset" do
      t2_pool = t2_pool_fixture()
      assert %Ecto.Changeset{} = T2Pools.change_t2_pool(t2_pool)
    end
  end
end
