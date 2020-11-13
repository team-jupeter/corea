defmodule Corea.T4sTest do
  use Corea.DataCase

  alias Corea.T4s

  describe "t4s" do
    alias Corea.T4s.T4

    @valid_attrs %{input_name: "some input_name"}
    @update_attrs %{input_name: "some updated input_name"}
    @invalid_attrs %{input_name: nil}

    def t4_fixture(attrs \\ %{}) do
      {:ok, t4} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T4s.create_t4()

      t4
    end

    test "list_t4s/0 returns all t4s" do
      t4 = t4_fixture()
      assert T4s.list_t4s() == [t4]
    end

    test "get_t4!/1 returns the t4 with given id" do
      t4 = t4_fixture()
      assert T4s.get_t4!(t4.id) == t4
    end

    test "create_t4/1 with valid data creates a t4" do
      assert {:ok, %T4{} = t4} = T4s.create_t4(@valid_attrs)
      assert t4.input_name == "some input_name"
    end

    test "create_t4/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T4s.create_t4(@invalid_attrs)
    end

    test "update_t4/2 with valid data updates the t4" do
      t4 = t4_fixture()
      assert {:ok, %T4{} = t4} = T4s.update_t4(t4, @update_attrs)
      assert t4.input_name == "some updated input_name"
    end

    test "update_t4/2 with invalid data returns error changeset" do
      t4 = t4_fixture()
      assert {:error, %Ecto.Changeset{}} = T4s.update_t4(t4, @invalid_attrs)
      assert t4 == T4s.get_t4!(t4.id)
    end

    test "delete_t4/1 deletes the t4" do
      t4 = t4_fixture()
      assert {:ok, %T4{}} = T4s.delete_t4(t4)
      assert_raise Ecto.NoResultsError, fn -> T4s.get_t4!(t4.id) end
    end

    test "change_t4/1 returns a t4 changeset" do
      t4 = t4_fixture()
      assert %Ecto.Changeset{} = T4s.change_t4(t4)
    end
  end
end
