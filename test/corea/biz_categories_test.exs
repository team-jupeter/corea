defmodule Corea.BizCategoriesTest do
  use Corea.DataCase

  alias Corea.BizCategories

  describe "biz_categories" do
    alias Corea.BizCategories.BizCategory

    @valid_attrs %{code: "some code", name: "some name", standard: "some standard"}
    @update_attrs %{code: "some updated code", name: "some updated name", standard: "some updated standard"}
    @invalid_attrs %{code: nil, name: nil, standard: nil}

    def biz_category_fixture(attrs \\ %{}) do
      {:ok, biz_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BizCategories.create_biz_category()

      biz_category
    end

    test "list_biz_categories/0 returns all biz_categories" do
      biz_category = biz_category_fixture()
      assert BizCategories.list_biz_categories() == [biz_category]
    end

    test "get_biz_category!/1 returns the biz_category with given id" do
      biz_category = biz_category_fixture()
      assert BizCategories.get_biz_category!(biz_category.id) == biz_category
    end

    test "create_biz_category/1 with valid data creates a biz_category" do
      assert {:ok, %BizCategory{} = biz_category} = BizCategories.create_biz_category(@valid_attrs)
      assert biz_category.code == "some code"
      assert biz_category.name == "some name"
      assert biz_category.standard == "some standard"
    end

    test "create_biz_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BizCategories.create_biz_category(@invalid_attrs)
    end

    test "update_biz_category/2 with valid data updates the biz_category" do
      biz_category = biz_category_fixture()
      assert {:ok, %BizCategory{} = biz_category} = BizCategories.update_biz_category(biz_category, @update_attrs)
      assert biz_category.code == "some updated code"
      assert biz_category.name == "some updated name"
      assert biz_category.standard == "some updated standard"
    end

    test "update_biz_category/2 with invalid data returns error changeset" do
      biz_category = biz_category_fixture()
      assert {:error, %Ecto.Changeset{}} = BizCategories.update_biz_category(biz_category, @invalid_attrs)
      assert biz_category == BizCategories.get_biz_category!(biz_category.id)
    end

    test "delete_biz_category/1 deletes the biz_category" do
      biz_category = biz_category_fixture()
      assert {:ok, %BizCategory{}} = BizCategories.delete_biz_category(biz_category)
      assert_raise Ecto.NoResultsError, fn -> BizCategories.get_biz_category!(biz_category.id) end
    end

    test "change_biz_category/1 returns a biz_category changeset" do
      biz_category = biz_category_fixture()
      assert %Ecto.Changeset{} = BizCategories.change_biz_category(biz_category)
    end
  end
end
