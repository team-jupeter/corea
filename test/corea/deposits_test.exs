defmodule Corea.DepositsTest do
  use Corea.DataCase

  alias Corea.Deposits

  describe "deposits" do
    alias Corea.Deposits.Deposit

    @valid_attrs %{typel: "some typel"}
    @update_attrs %{typel: "some updated typel"}
    @invalid_attrs %{typel: nil}

    def deposit_fixture(attrs \\ %{}) do
      {:ok, deposit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deposits.create_deposit()

      deposit
    end

    test "list_deposits/0 returns all deposits" do
      deposit = deposit_fixture()
      assert Deposits.list_deposits() == [deposit]
    end

    test "get_deposit!/1 returns the deposit with given id" do
      deposit = deposit_fixture()
      assert Deposits.get_deposit!(deposit.id) == deposit
    end

    test "create_deposit/1 with valid data creates a deposit" do
      assert {:ok, %Deposit{} = deposit} = Deposits.create_deposit(@valid_attrs)
      assert deposit.typel == "some typel"
    end

    test "create_deposit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deposits.create_deposit(@invalid_attrs)
    end

    test "update_deposit/2 with valid data updates the deposit" do
      deposit = deposit_fixture()
      assert {:ok, %Deposit{} = deposit} = Deposits.update_deposit(deposit, @update_attrs)
      assert deposit.typel == "some updated typel"
    end

    test "update_deposit/2 with invalid data returns error changeset" do
      deposit = deposit_fixture()
      assert {:error, %Ecto.Changeset{}} = Deposits.update_deposit(deposit, @invalid_attrs)
      assert deposit == Deposits.get_deposit!(deposit.id)
    end

    test "delete_deposit/1 deletes the deposit" do
      deposit = deposit_fixture()
      assert {:ok, %Deposit{}} = Deposits.delete_deposit(deposit)
      assert_raise Ecto.NoResultsError, fn -> Deposits.get_deposit!(deposit.id) end
    end

    test "change_deposit/1 returns a deposit changeset" do
      deposit = deposit_fixture()
      assert %Ecto.Changeset{} = Deposits.change_deposit(deposit)
    end
  end
end
