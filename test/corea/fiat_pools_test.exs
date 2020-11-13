defmodule Corea.FiatPoolsTest do
  use Corea.DataCase

  alias Corea.FiatPools

  describe "fiat_pools" do
    alias Corea.FiatPools.FiatPool

    @valid_attrs %{aed: "120.5"}
    @update_attrs %{aed: "456.7"}
    @invalid_attrs %{aed: nil}

    def fiat_pool_fixture(attrs \\ %{}) do
      {:ok, fiat_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FiatPools.create_fiat_pool()

      fiat_pool
    end

    test "list_fiat_pools/0 returns all fiat_pools" do
      fiat_pool = fiat_pool_fixture()
      assert FiatPools.list_fiat_pools() == [fiat_pool]
    end

    test "get_fiat_pool!/1 returns the fiat_pool with given id" do
      fiat_pool = fiat_pool_fixture()
      assert FiatPools.get_fiat_pool!(fiat_pool.id) == fiat_pool
    end

    test "create_fiat_pool/1 with valid data creates a fiat_pool" do
      assert {:ok, %FiatPool{} = fiat_pool} = FiatPools.create_fiat_pool(@valid_attrs)
      assert fiat_pool.aed == Decimal.new("120.5")
    end

    test "create_fiat_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FiatPools.create_fiat_pool(@invalid_attrs)
    end

    test "update_fiat_pool/2 with valid data updates the fiat_pool" do
      fiat_pool = fiat_pool_fixture()
      assert {:ok, %FiatPool{} = fiat_pool} = FiatPools.update_fiat_pool(fiat_pool, @update_attrs)
      assert fiat_pool.aed == Decimal.new("456.7")
    end

    test "update_fiat_pool/2 with invalid data returns error changeset" do
      fiat_pool = fiat_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = FiatPools.update_fiat_pool(fiat_pool, @invalid_attrs)
      assert fiat_pool == FiatPools.get_fiat_pool!(fiat_pool.id)
    end

    test "delete_fiat_pool/1 deletes the fiat_pool" do
      fiat_pool = fiat_pool_fixture()
      assert {:ok, %FiatPool{}} = FiatPools.delete_fiat_pool(fiat_pool)
      assert_raise Ecto.NoResultsError, fn -> FiatPools.get_fiat_pool!(fiat_pool.id) end
    end

    test "change_fiat_pool/1 returns a fiat_pool changeset" do
      fiat_pool = fiat_pool_fixture()
      assert %Ecto.Changeset{} = FiatPools.change_fiat_pool(fiat_pool)
    end
  end
end
