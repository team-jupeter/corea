defmodule Corea.T4PoolsTest do
  use Corea.DataCase

  alias Corea.T4Pools

  describe "t4_pools" do
    alias Corea.T4Pools.T4Pool

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def t4_pool_fixture(attrs \\ %{}) do
      {:ok, t4_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T4Pools.create_t4_pool()

      t4_pool
    end

    test "list_t4_pools/0 returns all t4_pools" do
      t4_pool = t4_pool_fixture()
      assert T4Pools.list_t4_pools() == [t4_pool]
    end

    test "get_t4_pool!/1 returns the t4_pool with given id" do
      t4_pool = t4_pool_fixture()
      assert T4Pools.get_t4_pool!(t4_pool.id) == t4_pool
    end

    test "create_t4_pool/1 with valid data creates a t4_pool" do
      assert {:ok, %T4Pool{} = t4_pool} = T4Pools.create_t4_pool(@valid_attrs)
      assert t4_pool.name == "some name"
    end

    test "create_t4_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T4Pools.create_t4_pool(@invalid_attrs)
    end

    test "update_t4_pool/2 with valid data updates the t4_pool" do
      t4_pool = t4_pool_fixture()
      assert {:ok, %T4Pool{} = t4_pool} = T4Pools.update_t4_pool(t4_pool, @update_attrs)
      assert t4_pool.name == "some updated name"
    end

    test "update_t4_pool/2 with invalid data returns error changeset" do
      t4_pool = t4_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T4Pools.update_t4_pool(t4_pool, @invalid_attrs)
      assert t4_pool == T4Pools.get_t4_pool!(t4_pool.id)
    end

    test "delete_t4_pool/1 deletes the t4_pool" do
      t4_pool = t4_pool_fixture()
      assert {:ok, %T4Pool{}} = T4Pools.delete_t4_pool(t4_pool)
      assert_raise Ecto.NoResultsError, fn -> T4Pools.get_t4_pool!(t4_pool.id) end
    end

    test "change_t4_pool/1 returns a t4_pool changeset" do
      t4_pool = t4_pool_fixture()
      assert %Ecto.Changeset{} = T4Pools.change_t4_pool(t4_pool)
    end
  end
end
