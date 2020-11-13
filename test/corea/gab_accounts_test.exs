defmodule Corea.GABAccountsTest do
  use Corea.DataCase

  alias Corea.GABAccounts

  describe "gab_accounts" do
    alias Corea.GABAccounts.GABAccount

    @valid_attrs %{entity_name: "some entity_name"}
    @update_attrs %{entity_name: "some updated entity_name"}
    @invalid_attrs %{entity_name: nil}

    def gab_account_fixture(attrs \\ %{}) do
      {:ok, gab_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GABAccounts.create_gab_account()

      gab_account
    end

    test "list_gab_accounts/0 returns all gab_accounts" do
      gab_account = gab_account_fixture()
      assert GABAccounts.list_gab_accounts() == [gab_account]
    end

    test "get_gab_account!/1 returns the gab_account with given id" do
      gab_account = gab_account_fixture()
      assert GABAccounts.get_gab_account!(gab_account.id) == gab_account
    end

    test "create_gab_account/1 with valid data creates a gab_account" do
      assert {:ok, %GABAccount{} = gab_account} = GABAccounts.create_gab_account(@valid_attrs)
      assert gab_account.entity_name == "some entity_name"
    end

    test "create_gab_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GABAccounts.create_gab_account(@invalid_attrs)
    end

    test "update_gab_account/2 with valid data updates the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GABAccount{} = gab_account} = GABAccounts.update_gab_account(gab_account, @update_attrs)
      assert gab_account.entity_name == "some updated entity_name"
    end

    test "update_gab_account/2 with invalid data returns error changeset" do
      gab_account = gab_account_fixture()
      assert {:error, %Ecto.Changeset{}} = GABAccounts.update_gab_account(gab_account, @invalid_attrs)
      assert gab_account == GABAccounts.get_gab_account!(gab_account.id)
    end

    test "delete_gab_account/1 deletes the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GABAccount{}} = GABAccounts.delete_gab_account(gab_account)
      assert_raise Ecto.NoResultsError, fn -> GABAccounts.get_gab_account!(gab_account.id) end
    end

    test "change_gab_account/1 returns a gab_account changeset" do
      gab_account = gab_account_fixture()
      assert %Ecto.Changeset{} = GABAccounts.change_gab_account(gab_account)
    end
  end
end
