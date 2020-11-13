defmodule Corea.GlobalSupulsTest do
  use Corea.DataCase

  alias Corea.GlobalSupuls

  describe "global_supuls" do
    alias Corea.GlobalSupuls.GlobalSupul

    @valid_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", openhash_box: [], t1_balance: "120.5", type: "some type"}
    @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", openhash_box: [], t1_balance: "456.7", type: "some updated type"}
    @invalid_attrs %{auth_code: nil, current_hash: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, openhash_box: nil, t1_balance: nil, type: nil}

    def global_supul_fixture(attrs \\ %{}) do
      {:ok, global_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GlobalSupuls.create_global_supul()

      global_supul
    end

    test "list_global_supuls/0 returns all global_supuls" do
      global_supul = global_supul_fixture()
      assert GlobalSupuls.list_global_supuls() == [global_supul]
    end

    test "get_global_supul!/1 returns the global_supul with given id" do
      global_supul = global_supul_fixture()
      assert GlobalSupuls.get_global_supul!(global_supul.id) == global_supul
    end

    test "create_global_supul/1 with valid data creates a global_supul" do
      assert {:ok, %GlobalSupul{} = global_supul} = GlobalSupuls.create_global_supul(@valid_attrs)
      assert global_supul.auth_code == "some auth_code"
      assert global_supul.current_hash == "some current_hash"
      assert global_supul.hash_chain == []
      assert global_supul.hash_count == 42
      assert global_supul.incoming_hash == "some incoming_hash"
      assert global_supul.name == "some name"
      assert global_supul.openhash_box == []
      assert global_supul.t1_balance == Decimal.new("120.5")
      assert global_supul.type == "some type"
    end

    test "create_global_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GlobalSupuls.create_global_supul(@invalid_attrs)
    end

    test "update_global_supul/2 with valid data updates the global_supul" do
      global_supul = global_supul_fixture()
      assert {:ok, %GlobalSupul{} = global_supul} = GlobalSupuls.update_global_supul(global_supul, @update_attrs)
      assert global_supul.auth_code == "some updated auth_code"
      assert global_supul.current_hash == "some updated current_hash"
      assert global_supul.hash_chain == []
      assert global_supul.hash_count == 43
      assert global_supul.incoming_hash == "some updated incoming_hash"
      assert global_supul.name == "some updated name"
      assert global_supul.openhash_box == []
      assert global_supul.t1_balance == Decimal.new("456.7")
      assert global_supul.type == "some updated type"
    end

    test "update_global_supul/2 with invalid data returns error changeset" do
      global_supul = global_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = GlobalSupuls.update_global_supul(global_supul, @invalid_attrs)
      assert global_supul == GlobalSupuls.get_global_supul!(global_supul.id)
    end

    test "delete_global_supul/1 deletes the global_supul" do
      global_supul = global_supul_fixture()
      assert {:ok, %GlobalSupul{}} = GlobalSupuls.delete_global_supul(global_supul)
      assert_raise Ecto.NoResultsError, fn -> GlobalSupuls.get_global_supul!(global_supul.id) end
    end

    test "change_global_supul/1 returns a global_supul changeset" do
      global_supul = global_supul_fixture()
      assert %Ecto.Changeset{} = GlobalSupuls.change_global_supul(global_supul)
    end
  end
end
