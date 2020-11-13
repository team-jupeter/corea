defmodule Corea.GopangsTest do
  use Corea.DataCase

  alias Corea.Gopangs

  describe "gopangs" do
    alias Corea.Gopangs.Gopang

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def gopang_fixture(attrs \\ %{}) do
      {:ok, gopang} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gopangs.create_gopang()

      gopang
    end

    test "list_gopangs/0 returns all gopangs" do
      gopang = gopang_fixture()
      assert Gopangs.list_gopangs() == [gopang]
    end

    test "get_gopang!/1 returns the gopang with given id" do
      gopang = gopang_fixture()
      assert Gopangs.get_gopang!(gopang.id) == gopang
    end

    test "create_gopang/1 with valid data creates a gopang" do
      assert {:ok, %Gopang{} = gopang} = Gopangs.create_gopang(@valid_attrs)
      assert gopang.name == "some name"
    end

    test "create_gopang/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gopangs.create_gopang(@invalid_attrs)
    end

    test "update_gopang/2 with valid data updates the gopang" do
      gopang = gopang_fixture()
      assert {:ok, %Gopang{} = gopang} = Gopangs.update_gopang(gopang, @update_attrs)
      assert gopang.name == "some updated name"
    end

    test "update_gopang/2 with invalid data returns error changeset" do
      gopang = gopang_fixture()
      assert {:error, %Ecto.Changeset{}} = Gopangs.update_gopang(gopang, @invalid_attrs)
      assert gopang == Gopangs.get_gopang!(gopang.id)
    end

    test "delete_gopang/1 deletes the gopang" do
      gopang = gopang_fixture()
      assert {:ok, %Gopang{}} = Gopangs.delete_gopang(gopang)
      assert_raise Ecto.NoResultsError, fn -> Gopangs.get_gopang!(gopang.id) end
    end

    test "change_gopang/1 returns a gopang changeset" do
      gopang = gopang_fixture()
      assert %Ecto.Changeset{} = Gopangs.change_gopang(gopang)
    end
  end
end
