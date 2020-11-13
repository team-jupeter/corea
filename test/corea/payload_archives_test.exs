defmodule Corea.PayloadArchivesTest do
  use Corea.DataCase

  alias Corea.PayloadArchives

  describe "payload_archives" do
    alias Corea.PayloadArchives.PayloadArchive

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def payload_archive_fixture(attrs \\ %{}) do
      {:ok, payload_archive} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PayloadArchives.create_payload_archive()

      payload_archive
    end

    test "list_payload_archives/0 returns all payload_archives" do
      payload_archive = payload_archive_fixture()
      assert PayloadArchives.list_payload_archives() == [payload_archive]
    end

    test "get_payload_archive!/1 returns the payload_archive with given id" do
      payload_archive = payload_archive_fixture()
      assert PayloadArchives.get_payload_archive!(payload_archive.id) == payload_archive
    end

    test "create_payload_archive/1 with valid data creates a payload_archive" do
      assert {:ok, %PayloadArchive{} = payload_archive} = PayloadArchives.create_payload_archive(@valid_attrs)
      assert payload_archive.title == "some title"
    end

    test "create_payload_archive/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PayloadArchives.create_payload_archive(@invalid_attrs)
    end

    test "update_payload_archive/2 with valid data updates the payload_archive" do
      payload_archive = payload_archive_fixture()
      assert {:ok, %PayloadArchive{} = payload_archive} = PayloadArchives.update_payload_archive(payload_archive, @update_attrs)
      assert payload_archive.title == "some updated title"
    end

    test "update_payload_archive/2 with invalid data returns error changeset" do
      payload_archive = payload_archive_fixture()
      assert {:error, %Ecto.Changeset{}} = PayloadArchives.update_payload_archive(payload_archive, @invalid_attrs)
      assert payload_archive == PayloadArchives.get_payload_archive!(payload_archive.id)
    end

    test "delete_payload_archive/1 deletes the payload_archive" do
      payload_archive = payload_archive_fixture()
      assert {:ok, %PayloadArchive{}} = PayloadArchives.delete_payload_archive(payload_archive)
      assert_raise Ecto.NoResultsError, fn -> PayloadArchives.get_payload_archive!(payload_archive.id) end
    end

    test "change_payload_archive/1 returns a payload_archive changeset" do
      payload_archive = payload_archive_fixture()
      assert %Ecto.Changeset{} = PayloadArchives.change_payload_archive(payload_archive)
    end
  end
end
