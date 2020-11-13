defmodule Corea.OpenhashesTest do
  use Corea.DataCase

  alias Corea.Openhashes

  describe "openhashes" do
    alias Corea.Openhashes.Openhash

    @valid_attrs %{input_email: "some input_email"}
    @update_attrs %{input_email: "some updated input_email"}
    @invalid_attrs %{input_email: nil}

    def openhash_fixture(attrs \\ %{}) do
      {:ok, openhash} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Openhashes.create_openhash()

      openhash
    end

    test "list_openhashes/0 returns all openhashes" do
      openhash = openhash_fixture()
      assert Openhashes.list_openhashes() == [openhash]
    end

    test "get_openhash!/1 returns the openhash with given id" do
      openhash = openhash_fixture()
      assert Openhashes.get_openhash!(openhash.id) == openhash
    end

    test "create_openhash/1 with valid data creates a openhash" do
      assert {:ok, %Openhash{} = openhash} = Openhashes.create_openhash(@valid_attrs)
      assert openhash.input_email == "some input_email"
    end

    test "create_openhash/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Openhashes.create_openhash(@invalid_attrs)
    end

    test "update_openhash/2 with valid data updates the openhash" do
      openhash = openhash_fixture()
      assert {:ok, %Openhash{} = openhash} = Openhashes.update_openhash(openhash, @update_attrs)
      assert openhash.input_email == "some updated input_email"
    end

    test "update_openhash/2 with invalid data returns error changeset" do
      openhash = openhash_fixture()
      assert {:error, %Ecto.Changeset{}} = Openhashes.update_openhash(openhash, @invalid_attrs)
      assert openhash == Openhashes.get_openhash!(openhash.id)
    end

    test "delete_openhash/1 deletes the openhash" do
      openhash = openhash_fixture()
      assert {:ok, %Openhash{}} = Openhashes.delete_openhash(openhash)
      assert_raise Ecto.NoResultsError, fn -> Openhashes.get_openhash!(openhash.id) end
    end

    test "change_openhash/1 returns a openhash changeset" do
      openhash = openhash_fixture()
      assert %Ecto.Changeset{} = Openhashes.change_openhash(openhash)
    end
  end
end
