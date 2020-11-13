defmodule Corea.StateSupulsTest do
  use Corea.DataCase

  alias Corea.StateSupuls

  describe "state_supuls" do
    alias Corea.StateSupuls.StateSupul

    @valid_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", openhash_box: [], t1_balance: "120.5", type: "some type"}
    @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", openhash_box: [], t1_balance: "456.7", type: "some updated type"}
    @invalid_attrs %{auth_code: nil, current_hash: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, openhash_box: nil, t1_balance: nil, type: nil}

    def state_supul_fixture(attrs \\ %{}) do
      {:ok, state_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StateSupuls.create_state_supul()

      state_supul
    end

    test "list_state_supuls/0 returns all state_supuls" do
      state_supul = state_supul_fixture()
      assert StateSupuls.list_state_supuls() == [state_supul]
    end

    test "get_state_supul!/1 returns the state_supul with given id" do
      state_supul = state_supul_fixture()
      assert StateSupuls.get_state_supul!(state_supul.id) == state_supul
    end

    test "create_state_supul/1 with valid data creates a state_supul" do
      assert {:ok, %StateSupul{} = state_supul} = StateSupuls.create_state_supul(@valid_attrs)
      assert state_supul.auth_code == "some auth_code"
      assert state_supul.current_hash == "some current_hash"
      assert state_supul.hash_chain == []
      assert state_supul.hash_count == 42
      assert state_supul.incoming_hash == "some incoming_hash"
      assert state_supul.name == "some name"
      assert state_supul.openhash_box == []
      assert state_supul.t1_balance == Decimal.new("120.5")
      assert state_supul.type == "some type"
    end

    test "create_state_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StateSupuls.create_state_supul(@invalid_attrs)
    end

    test "update_state_supul/2 with valid data updates the state_supul" do
      state_supul = state_supul_fixture()
      assert {:ok, %StateSupul{} = state_supul} = StateSupuls.update_state_supul(state_supul, @update_attrs)
      assert state_supul.auth_code == "some updated auth_code"
      assert state_supul.current_hash == "some updated current_hash"
      assert state_supul.hash_chain == []
      assert state_supul.hash_count == 43
      assert state_supul.incoming_hash == "some updated incoming_hash"
      assert state_supul.name == "some updated name"
      assert state_supul.openhash_box == []
      assert state_supul.t1_balance == Decimal.new("456.7")
      assert state_supul.type == "some updated type"
    end

    test "update_state_supul/2 with invalid data returns error changeset" do
      state_supul = state_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = StateSupuls.update_state_supul(state_supul, @invalid_attrs)
      assert state_supul == StateSupuls.get_state_supul!(state_supul.id)
    end

    test "delete_state_supul/1 deletes the state_supul" do
      state_supul = state_supul_fixture()
      assert {:ok, %StateSupul{}} = StateSupuls.delete_state_supul(state_supul)
      assert_raise Ecto.NoResultsError, fn -> StateSupuls.get_state_supul!(state_supul.id) end
    end

    test "change_state_supul/1 returns a state_supul changeset" do
      state_supul = state_supul_fixture()
      assert %Ecto.Changeset{} = StateSupuls.change_state_supul(state_supul)
    end
  end
end
