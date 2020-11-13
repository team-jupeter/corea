defmodule Corea.T5sTest do
  use Corea.DataCase

  alias Corea.T5s

  describe "t5s" do
    alias Corea.T5s.T5

    @valid_attrs %{input_name: "some input_name"}
    @update_attrs %{input_name: "some updated input_name"}
    @invalid_attrs %{input_name: nil}

    def t5_fixture(attrs \\ %{}) do
      {:ok, t5} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T5s.create_t5()

      t5
    end

    test "list_t5s/0 returns all t5s" do
      t5 = t5_fixture()
      assert T5s.list_t5s() == [t5]
    end

    test "get_t5!/1 returns the t5 with given id" do
      t5 = t5_fixture()
      assert T5s.get_t5!(t5.id) == t5
    end

    test "create_t5/1 with valid data creates a t5" do
      assert {:ok, %T5{} = t5} = T5s.create_t5(@valid_attrs)
      assert t5.input_name == "some input_name"
    end

    test "create_t5/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T5s.create_t5(@invalid_attrs)
    end

    test "update_t5/2 with valid data updates the t5" do
      t5 = t5_fixture()
      assert {:ok, %T5{} = t5} = T5s.update_t5(t5, @update_attrs)
      assert t5.input_name == "some updated input_name"
    end

    test "update_t5/2 with invalid data returns error changeset" do
      t5 = t5_fixture()
      assert {:error, %Ecto.Changeset{}} = T5s.update_t5(t5, @invalid_attrs)
      assert t5 == T5s.get_t5!(t5.id)
    end

    test "delete_t5/1 deletes the t5" do
      t5 = t5_fixture()
      assert {:ok, %T5{}} = T5s.delete_t5(t5)
      assert_raise Ecto.NoResultsError, fn -> T5s.get_t5!(t5.id) end
    end

    test "change_t5/1 returns a t5 changeset" do
      t5 = t5_fixture()
      assert %Ecto.Changeset{} = T5s.change_t5(t5)
    end
  end
end
