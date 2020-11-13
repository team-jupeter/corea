defmodule Corea.InitiativesTest do
  use Corea.DataCase

  alias Corea.Initiatives

  describe "initiatives" do
    alias Corea.Initiatives.Initiative

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def initiative_fixture(attrs \\ %{}) do
      {:ok, initiative} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Initiatives.create_initiative()

      initiative
    end

    test "list_initiatives/0 returns all initiatives" do
      initiative = initiative_fixture()
      assert Initiatives.list_initiatives() == [initiative]
    end

    test "get_initiative!/1 returns the initiative with given id" do
      initiative = initiative_fixture()
      assert Initiatives.get_initiative!(initiative.id) == initiative
    end

    test "create_initiative/1 with valid data creates a initiative" do
      assert {:ok, %Initiative{} = initiative} = Initiatives.create_initiative(@valid_attrs)
      assert initiative.title == "some title"
    end

    test "create_initiative/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Initiatives.create_initiative(@invalid_attrs)
    end

    test "update_initiative/2 with valid data updates the initiative" do
      initiative = initiative_fixture()
      assert {:ok, %Initiative{} = initiative} = Initiatives.update_initiative(initiative, @update_attrs)
      assert initiative.title == "some updated title"
    end

    test "update_initiative/2 with invalid data returns error changeset" do
      initiative = initiative_fixture()
      assert {:error, %Ecto.Changeset{}} = Initiatives.update_initiative(initiative, @invalid_attrs)
      assert initiative == Initiatives.get_initiative!(initiative.id)
    end

    test "delete_initiative/1 deletes the initiative" do
      initiative = initiative_fixture()
      assert {:ok, %Initiative{}} = Initiatives.delete_initiative(initiative)
      assert_raise Ecto.NoResultsError, fn -> Initiatives.get_initiative!(initiative.id) end
    end

    test "change_initiative/1 returns a initiative changeset" do
      initiative = initiative_fixture()
      assert %Ecto.Changeset{} = Initiatives.change_initiative(initiative)
    end
  end
end
