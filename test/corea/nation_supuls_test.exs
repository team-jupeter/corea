defmodule Corea.NationSupulsTest do
  use Corea.DataCase

  alias Corea.NationSupuls

  describe "nation_supuls" do
    alias Corea.NationSupuls.NationSupul

    @valid_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", global_openhash_id: "7488a646-e31f-11e4-aace-600308960662", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", nation_name: "some nation_name", nation_supul_code: "some nation_supul_code", openhash_box: [], previous_hash: "some previous_hash", sender: "7488a646-e31f-11e4-aace-600308960662", t1_balance: "120.5", type: "some type"}
    @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", global_openhash_id: "7488a646-e31f-11e4-aace-600308960668", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", nation_name: "some updated nation_name", nation_supul_code: "some updated nation_supul_code", openhash_box: [], previous_hash: "some updated previous_hash", sender: "7488a646-e31f-11e4-aace-600308960668", t1_balance: "456.7", type: "some updated type"}
    @invalid_attrs %{auth_code: nil, current_hash: nil, global_openhash_id: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, nation_name: nil, nation_supul_code: nil, openhash_box: nil, previous_hash: nil, sender: nil, t1_balance: nil, type: nil}

    def nation_supul_fixture(attrs \\ %{}) do
      {:ok, nation_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> NationSupuls.create_nation_supul()

      nation_supul
    end

    test "list_nation_supuls/0 returns all nation_supuls" do
      nation_supul = nation_supul_fixture()
      assert NationSupuls.list_nation_supuls() == [nation_supul]
    end

    test "get_nation_supul!/1 returns the nation_supul with given id" do
      nation_supul = nation_supul_fixture()
      assert NationSupuls.get_nation_supul!(nation_supul.id) == nation_supul
    end

    test "create_nation_supul/1 with valid data creates a nation_supul" do
      assert {:ok, %NationSupul{} = nation_supul} = NationSupuls.create_nation_supul(@valid_attrs)
      assert nation_supul.auth_code == "some auth_code"
      assert nation_supul.current_hash == "some current_hash"
      assert nation_supul.global_openhash_id == "7488a646-e31f-11e4-aace-600308960662"
      assert nation_supul.hash_chain == []
      assert nation_supul.hash_count == 42
      assert nation_supul.incoming_hash == "some incoming_hash"
      assert nation_supul.name == "some name"
      assert nation_supul.nation_name == "some nation_name"
      assert nation_supul.nation_supul_code == "some nation_supul_code"
      assert nation_supul.openhash_box == []
      assert nation_supul.previous_hash == "some previous_hash"
      assert nation_supul.sender == "7488a646-e31f-11e4-aace-600308960662"
      assert nation_supul.t1_balance == Decimal.new("120.5")
      assert nation_supul.type == "some type"
    end

    test "create_nation_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NationSupuls.create_nation_supul(@invalid_attrs)
    end

    test "update_nation_supul/2 with valid data updates the nation_supul" do
      nation_supul = nation_supul_fixture()
      assert {:ok, %NationSupul{} = nation_supul} = NationSupuls.update_nation_supul(nation_supul, @update_attrs)
      assert nation_supul.auth_code == "some updated auth_code"
      assert nation_supul.current_hash == "some updated current_hash"
      assert nation_supul.global_openhash_id == "7488a646-e31f-11e4-aace-600308960668"
      assert nation_supul.hash_chain == []
      assert nation_supul.hash_count == 43
      assert nation_supul.incoming_hash == "some updated incoming_hash"
      assert nation_supul.name == "some updated name"
      assert nation_supul.nation_name == "some updated nation_name"
      assert nation_supul.nation_supul_code == "some updated nation_supul_code"
      assert nation_supul.openhash_box == []
      assert nation_supul.previous_hash == "some updated previous_hash"
      assert nation_supul.sender == "7488a646-e31f-11e4-aace-600308960668"
      assert nation_supul.t1_balance == Decimal.new("456.7")
      assert nation_supul.type == "some updated type"
    end

    test "update_nation_supul/2 with invalid data returns error changeset" do
      nation_supul = nation_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = NationSupuls.update_nation_supul(nation_supul, @invalid_attrs)
      assert nation_supul == NationSupuls.get_nation_supul!(nation_supul.id)
    end

    test "delete_nation_supul/1 deletes the nation_supul" do
      nation_supul = nation_supul_fixture()
      assert {:ok, %NationSupul{}} = NationSupuls.delete_nation_supul(nation_supul)
      assert_raise Ecto.NoResultsError, fn -> NationSupuls.get_nation_supul!(nation_supul.id) end
    end

    test "change_nation_supul/1 returns a nation_supul changeset" do
      nation_supul = nation_supul_fixture()
      assert %Ecto.Changeset{} = NationSupuls.change_nation_supul(nation_supul)
    end
  end
end
