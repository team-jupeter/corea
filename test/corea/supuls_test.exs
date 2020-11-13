defmodule Corea.SupulsTest do
  use Corea.DataCase

  alias Corea.Supuls

  describe "supuls" do
    alias Corea.Supuls.Supul

    @valid_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", event_sender: "some event_sender", geographical_area: "some geographical_area", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", nation_name: "some nation_name", openhash_box: [], previous_hash: "some previous_hash", state_name: "some state_name", state_openhash_id: "7488a646-e31f-11e4-aace-600308960662", supul_code: "some supul_code", supul_name: "some supul_name", t1_balance: "120.5", txn_id: "7488a646-e31f-11e4-aace-600308960662", type: "some type"}
    @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", event_sender: "some updated event_sender", geographical_area: "some updated geographical_area", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", nation_name: "some updated nation_name", openhash_box: [], previous_hash: "some updated previous_hash", state_name: "some updated state_name", state_openhash_id: "7488a646-e31f-11e4-aace-600308960668", supul_code: "some updated supul_code", supul_name: "some updated supul_name", t1_balance: "456.7", txn_id: "7488a646-e31f-11e4-aace-600308960668", type: "some updated type"}
    @invalid_attrs %{auth_code: nil, current_hash: nil, event_sender: nil, geographical_area: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, nation_name: nil, openhash_box: nil, previous_hash: nil, state_name: nil, state_openhash_id: nil, supul_code: nil, supul_name: nil, t1_balance: nil, txn_id: nil, type: nil}

    def supul_fixture(attrs \\ %{}) do
      {:ok, supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Supuls.create_supul()

      supul
    end

    test "list_supuls/0 returns all supuls" do
      supul = supul_fixture()
      assert Supuls.list_supuls() == [supul]
    end

    test "get_supul!/1 returns the supul with given id" do
      supul = supul_fixture()
      assert Supuls.get_supul!(supul.id) == supul
    end

    test "create_supul/1 with valid data creates a supul" do
      assert {:ok, %Supul{} = supul} = Supuls.create_supul(@valid_attrs)
      assert supul.auth_code == "some auth_code"
      assert supul.current_hash == "some current_hash"
      assert supul.event_sender == "some event_sender"
      assert supul.geographical_area == "some geographical_area"
      assert supul.hash_chain == []
      assert supul.hash_count == 42
      assert supul.incoming_hash == "some incoming_hash"
      assert supul.name == "some name"
      assert supul.nation_name == "some nation_name"
      assert supul.openhash_box == []
      assert supul.previous_hash == "some previous_hash"
      assert supul.state_name == "some state_name"
      assert supul.state_openhash_id == "7488a646-e31f-11e4-aace-600308960662"
      assert supul.supul_code == "some supul_code"
      assert supul.supul_name == "some supul_name"
      assert supul.t1_balance == Decimal.new("120.5")
      assert supul.txn_id == "7488a646-e31f-11e4-aace-600308960662"
      assert supul.type == "some type"
    end

    test "create_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supuls.create_supul(@invalid_attrs)
    end

    test "update_supul/2 with valid data updates the supul" do
      supul = supul_fixture()
      assert {:ok, %Supul{} = supul} = Supuls.update_supul(supul, @update_attrs)
      assert supul.auth_code == "some updated auth_code"
      assert supul.current_hash == "some updated current_hash"
      assert supul.event_sender == "some updated event_sender"
      assert supul.geographical_area == "some updated geographical_area"
      assert supul.hash_chain == []
      assert supul.hash_count == 43
      assert supul.incoming_hash == "some updated incoming_hash"
      assert supul.name == "some updated name"
      assert supul.nation_name == "some updated nation_name"
      assert supul.openhash_box == []
      assert supul.previous_hash == "some updated previous_hash"
      assert supul.state_name == "some updated state_name"
      assert supul.state_openhash_id == "7488a646-e31f-11e4-aace-600308960668"
      assert supul.supul_code == "some updated supul_code"
      assert supul.supul_name == "some updated supul_name"
      assert supul.t1_balance == Decimal.new("456.7")
      assert supul.txn_id == "7488a646-e31f-11e4-aace-600308960668"
      assert supul.type == "some updated type"
    end

    test "update_supul/2 with invalid data returns error changeset" do
      supul = supul_fixture()
      assert {:error, %Ecto.Changeset{}} = Supuls.update_supul(supul, @invalid_attrs)
      assert supul == Supuls.get_supul!(supul.id)
    end

    test "delete_supul/1 deletes the supul" do
      supul = supul_fixture()
      assert {:ok, %Supul{}} = Supuls.delete_supul(supul)
      assert_raise Ecto.NoResultsError, fn -> Supuls.get_supul!(supul.id) end
    end

    test "change_supul/1 returns a supul changeset" do
      supul = supul_fixture()
      assert %Ecto.Changeset{} = Supuls.change_supul(supul)
    end
  end
end
