defmodule Corea.ProductAnnotationsTest do
  use Corea.DataCase

  alias Corea.ProductAnnotations

  describe "product_annotations" do
    alias Corea.ProductAnnotations.ProductAnnotation

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def product_annotation_fixture(attrs \\ %{}) do
      {:ok, product_annotation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProductAnnotations.create_product_annotation()

      product_annotation
    end

    test "list_product_annotations/0 returns all product_annotations" do
      product_annotation = product_annotation_fixture()
      assert ProductAnnotations.list_product_annotations() == [product_annotation]
    end

    test "get_product_annotation!/1 returns the product_annotation with given id" do
      product_annotation = product_annotation_fixture()
      assert ProductAnnotations.get_product_annotation!(product_annotation.id) == product_annotation
    end

    test "create_product_annotation/1 with valid data creates a product_annotation" do
      assert {:ok, %ProductAnnotation{} = product_annotation} = ProductAnnotations.create_product_annotation(@valid_attrs)
      assert product_annotation.body == "some body"
    end

    test "create_product_annotation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductAnnotations.create_product_annotation(@invalid_attrs)
    end

    test "update_product_annotation/2 with valid data updates the product_annotation" do
      product_annotation = product_annotation_fixture()
      assert {:ok, %ProductAnnotation{} = product_annotation} = ProductAnnotations.update_product_annotation(product_annotation, @update_attrs)
      assert product_annotation.body == "some updated body"
    end

    test "update_product_annotation/2 with invalid data returns error changeset" do
      product_annotation = product_annotation_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductAnnotations.update_product_annotation(product_annotation, @invalid_attrs)
      assert product_annotation == ProductAnnotations.get_product_annotation!(product_annotation.id)
    end

    test "delete_product_annotation/1 deletes the product_annotation" do
      product_annotation = product_annotation_fixture()
      assert {:ok, %ProductAnnotation{}} = ProductAnnotations.delete_product_annotation(product_annotation)
      assert_raise Ecto.NoResultsError, fn -> ProductAnnotations.get_product_annotation!(product_annotation.id) end
    end

    test "change_product_annotation/1 returns a product_annotation changeset" do
      product_annotation = product_annotation_fixture()
      assert %Ecto.Changeset{} = ProductAnnotations.change_product_annotation(product_annotation)
    end
  end
end
