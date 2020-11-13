defmodule Corea.InvoiceItemsTest do
  use Corea.DataCase

  alias Corea.InvoiceItems

  describe "invoice_items" do
    alias Corea.InvoiceItems.InvoiceItem

    @valid_attrs %{item_name: "some item_name"}
    @update_attrs %{item_name: "some updated item_name"}
    @invalid_attrs %{item_name: nil}

    def invoice_item_fixture(attrs \\ %{}) do
      {:ok, invoice_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> InvoiceItems.create_invoice_item()

      invoice_item
    end

    test "list_invoice_items/0 returns all invoice_items" do
      invoice_item = invoice_item_fixture()
      assert InvoiceItems.list_invoice_items() == [invoice_item]
    end

    test "get_invoice_item!/1 returns the invoice_item with given id" do
      invoice_item = invoice_item_fixture()
      assert InvoiceItems.get_invoice_item!(invoice_item.id) == invoice_item
    end

    test "create_invoice_item/1 with valid data creates a invoice_item" do
      assert {:ok, %InvoiceItem{} = invoice_item} = InvoiceItems.create_invoice_item(@valid_attrs)
      assert invoice_item.item_name == "some item_name"
    end

    test "create_invoice_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = InvoiceItems.create_invoice_item(@invalid_attrs)
    end

    test "update_invoice_item/2 with valid data updates the invoice_item" do
      invoice_item = invoice_item_fixture()
      assert {:ok, %InvoiceItem{} = invoice_item} = InvoiceItems.update_invoice_item(invoice_item, @update_attrs)
      assert invoice_item.item_name == "some updated item_name"
    end

    test "update_invoice_item/2 with invalid data returns error changeset" do
      invoice_item = invoice_item_fixture()
      assert {:error, %Ecto.Changeset{}} = InvoiceItems.update_invoice_item(invoice_item, @invalid_attrs)
      assert invoice_item == InvoiceItems.get_invoice_item!(invoice_item.id)
    end

    test "delete_invoice_item/1 deletes the invoice_item" do
      invoice_item = invoice_item_fixture()
      assert {:ok, %InvoiceItem{}} = InvoiceItems.delete_invoice_item(invoice_item)
      assert_raise Ecto.NoResultsError, fn -> InvoiceItems.get_invoice_item!(invoice_item.id) end
    end

    test "change_invoice_item/1 returns a invoice_item changeset" do
      invoice_item = invoice_item_fixture()
      assert %Ecto.Changeset{} = InvoiceItems.change_invoice_item(invoice_item)
    end
  end
end
