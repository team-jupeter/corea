defmodule Corea.DocumentsTest do
  use Corea.DataCase

  alias Corea.Documents

  describe "documents" do
    alias Corea.Documents.Document

    @valid_attrs %{presented_by: "some presented_by"}
    @update_attrs %{presented_by: "some updated presented_by"}
    @invalid_attrs %{presented_by: nil}

    def document_fixture(attrs \\ %{}) do
      {:ok, document} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Documents.create_document()

      document
    end

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Documents.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Documents.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      assert {:ok, %Document{} = document} = Documents.create_document(@valid_attrs)
      assert document.presented_by == "some presented_by"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Documents.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      assert {:ok, %Document{} = document} = Documents.update_document(document, @update_attrs)
      assert document.presented_by == "some updated presented_by"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Documents.update_document(document, @invalid_attrs)
      assert document == Documents.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Documents.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Documents.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Documents.change_document(document)
    end
  end
end
