defmodule Corea.T1sTest do
  use Corea.DataCase

  alias Corea.T1s

  describe "t1s" do
    alias Corea.T1s.T1

    @valid_attrs %{input_name: "some input_name"}
    @update_attrs %{input_name: "some updated input_name"}
    @invalid_attrs %{input_name: nil}

    def t1_fixture(attrs \\ %{}) do
      {:ok, t1} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T1s.create_t1()

      t1
    end

    test "list_t1s/0 returns all t1s" do
      t1 = t1_fixture()
      assert T1s.list_t1s() == [t1]
    end

    test "get_t1!/1 returns the t1 with given id" do
      t1 = t1_fixture()
      assert T1s.get_t1!(t1.id) == t1
    end

    test "create_t1/1 with valid data creates a t1" do
      assert {:ok, %T1{} = t1} = T1s.create_t1(@valid_attrs)
      assert t1.input_name == "some input_name"
    end

    test "create_t1/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T1s.create_t1(@invalid_attrs)
    end

    test "update_t1/2 with valid data updates the t1" do
      t1 = t1_fixture()
      assert {:ok, %T1{} = t1} = T1s.update_t1(t1, @update_attrs)
      assert t1.input_name == "some updated input_name"
    end

    test "update_t1/2 with invalid data returns error changeset" do
      t1 = t1_fixture()
      assert {:error, %Ecto.Changeset{}} = T1s.update_t1(t1, @invalid_attrs)
      assert t1 == T1s.get_t1!(t1.id)
    end

    test "delete_t1/1 deletes the t1" do
      t1 = t1_fixture()
      assert {:ok, %T1{}} = T1s.delete_t1(t1)
      assert_raise Ecto.NoResultsError, fn -> T1s.get_t1!(t1.id) end
    end

    test "change_t1/1 returns a t1 changeset" do
      t1 = t1_fixture()
      assert %Ecto.Changeset{} = T1s.change_t1(t1)
    end
  end
end
