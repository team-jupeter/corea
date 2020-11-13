defmodule Corea.T2sTest do
  use Corea.DataCase

  alias Corea.T2s

  describe "t2s" do
    alias Corea.T2s.T2

    @valid_attrs %{input_name: "some input_name"}
    @update_attrs %{input_name: "some updated input_name"}
    @invalid_attrs %{input_name: nil}

    def t2_fixture(attrs \\ %{}) do
      {:ok, t2} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T2s.create_t2()

      t2
    end

    test "list_t2s/0 returns all t2s" do
      t2 = t2_fixture()
      assert T2s.list_t2s() == [t2]
    end

    test "get_t2!/1 returns the t2 with given id" do
      t2 = t2_fixture()
      assert T2s.get_t2!(t2.id) == t2
    end

    test "create_t2/1 with valid data creates a t2" do
      assert {:ok, %T2{} = t2} = T2s.create_t2(@valid_attrs)
      assert t2.input_name == "some input_name"
    end

    test "create_t2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T2s.create_t2(@invalid_attrs)
    end

    test "update_t2/2 with valid data updates the t2" do
      t2 = t2_fixture()
      assert {:ok, %T2{} = t2} = T2s.update_t2(t2, @update_attrs)
      assert t2.input_name == "some updated input_name"
    end

    test "update_t2/2 with invalid data returns error changeset" do
      t2 = t2_fixture()
      assert {:error, %Ecto.Changeset{}} = T2s.update_t2(t2, @invalid_attrs)
      assert t2 == T2s.get_t2!(t2.id)
    end

    test "delete_t2/1 deletes the t2" do
      t2 = t2_fixture()
      assert {:ok, %T2{}} = T2s.delete_t2(t2)
      assert_raise Ecto.NoResultsError, fn -> T2s.get_t2!(t2.id) end
    end

    test "change_t2/1 returns a t2 changeset" do
      t2 = t2_fixture()
      assert %Ecto.Changeset{} = T2s.change_t2(t2)
    end
  end
end
