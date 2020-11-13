defmodule Corea.PatentApplicationsTest do
  use Corea.DataCase

  alias Corea.PatentApplications

  describe "patent_applications" do
    alias Corea.PatentApplications.PatentApplication

    @valid_attrs %{applied_by: "some applied_by"}
    @update_attrs %{applied_by: "some updated applied_by"}
    @invalid_attrs %{applied_by: nil}

    def patent_application_fixture(attrs \\ %{}) do
      {:ok, patent_application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PatentApplications.create_patent_application()

      patent_application
    end

    test "list_patent_applications/0 returns all patent_applications" do
      patent_application = patent_application_fixture()
      assert PatentApplications.list_patent_applications() == [patent_application]
    end

    test "get_patent_application!/1 returns the patent_application with given id" do
      patent_application = patent_application_fixture()
      assert PatentApplications.get_patent_application!(patent_application.id) == patent_application
    end

    test "create_patent_application/1 with valid data creates a patent_application" do
      assert {:ok, %PatentApplication{} = patent_application} = PatentApplications.create_patent_application(@valid_attrs)
      assert patent_application.applied_by == "some applied_by"
    end

    test "create_patent_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PatentApplications.create_patent_application(@invalid_attrs)
    end

    test "update_patent_application/2 with valid data updates the patent_application" do
      patent_application = patent_application_fixture()
      assert {:ok, %PatentApplication{} = patent_application} = PatentApplications.update_patent_application(patent_application, @update_attrs)
      assert patent_application.applied_by == "some updated applied_by"
    end

    test "update_patent_application/2 with invalid data returns error changeset" do
      patent_application = patent_application_fixture()
      assert {:error, %Ecto.Changeset{}} = PatentApplications.update_patent_application(patent_application, @invalid_attrs)
      assert patent_application == PatentApplications.get_patent_application!(patent_application.id)
    end

    test "delete_patent_application/1 deletes the patent_application" do
      patent_application = patent_application_fixture()
      assert {:ok, %PatentApplication{}} = PatentApplications.delete_patent_application(patent_application)
      assert_raise Ecto.NoResultsError, fn -> PatentApplications.get_patent_application!(patent_application.id) end
    end

    test "change_patent_application/1 returns a patent_application changeset" do
      patent_application = patent_application_fixture()
      assert %Ecto.Changeset{} = PatentApplications.change_patent_application(patent_application)
    end
  end
end
