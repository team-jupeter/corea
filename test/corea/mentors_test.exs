defmodule Corea.MentorsTest do
  use Corea.DataCase

  alias Corea.Mentors

  describe "mentors" do
    alias Corea.Mentors.Mentor

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def mentor_fixture(attrs \\ %{}) do
      {:ok, mentor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mentors.create_mentor()

      mentor
    end

    test "list_mentors/0 returns all mentors" do
      mentor = mentor_fixture()
      assert Mentors.list_mentors() == [mentor]
    end

    test "get_mentor!/1 returns the mentor with given id" do
      mentor = mentor_fixture()
      assert Mentors.get_mentor!(mentor.id) == mentor
    end

    test "create_mentor/1 with valid data creates a mentor" do
      assert {:ok, %Mentor{} = mentor} = Mentors.create_mentor(@valid_attrs)
      assert mentor.name == "some name"
    end

    test "create_mentor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mentors.create_mentor(@invalid_attrs)
    end

    test "update_mentor/2 with valid data updates the mentor" do
      mentor = mentor_fixture()
      assert {:ok, %Mentor{} = mentor} = Mentors.update_mentor(mentor, @update_attrs)
      assert mentor.name == "some updated name"
    end

    test "update_mentor/2 with invalid data returns error changeset" do
      mentor = mentor_fixture()
      assert {:error, %Ecto.Changeset{}} = Mentors.update_mentor(mentor, @invalid_attrs)
      assert mentor == Mentors.get_mentor!(mentor.id)
    end

    test "delete_mentor/1 deletes the mentor" do
      mentor = mentor_fixture()
      assert {:ok, %Mentor{}} = Mentors.delete_mentor(mentor)
      assert_raise Ecto.NoResultsError, fn -> Mentors.get_mentor!(mentor.id) end
    end

    test "change_mentor/1 returns a mentor changeset" do
      mentor = mentor_fixture()
      assert %Ecto.Changeset{} = Mentors.change_mentor(mentor)
    end
  end
end
