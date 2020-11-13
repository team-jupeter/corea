defmodule Corea.ConstitutionsTest do
  use Corea.DataCase

  alias Corea.Constitutions

  describe "constitutions" do
    alias Corea.Constitutions.Constitution

    @valid_attrs %{content: "some content", content_hash: "some content_hash", empowered_on: ~N[2010-04-17 14:00:00], nationality: "some nationality", sighed_by: []}
    @update_attrs %{content: "some updated content", content_hash: "some updated content_hash", empowered_on: ~N[2011-05-18 15:01:01], nationality: "some updated nationality", sighed_by: []}
    @invalid_attrs %{content: nil, content_hash: nil, empowered_on: nil, nationality: nil, sighed_by: nil}

    def constitution_fixture(attrs \\ %{}) do
      {:ok, constitution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Constitutions.create_constitution()

      constitution
    end

    test "list_constitutions/0 returns all constitutions" do
      constitution = constitution_fixture()
      assert Constitutions.list_constitutions() == [constitution]
    end

    test "get_constitution!/1 returns the constitution with given id" do
      constitution = constitution_fixture()
      assert Constitutions.get_constitution!(constitution.id) == constitution
    end

    test "create_constitution/1 with valid data creates a constitution" do
      assert {:ok, %Constitution{} = constitution} = Constitutions.create_constitution(@valid_attrs)
      assert constitution.content == "some content"
      assert constitution.content_hash == "some content_hash"
      assert constitution.empowered_on == ~N[2010-04-17 14:00:00]
      assert constitution.nationality == "some nationality"
      assert constitution.sighed_by == []
    end

    test "create_constitution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Constitutions.create_constitution(@invalid_attrs)
    end

    test "update_constitution/2 with valid data updates the constitution" do
      constitution = constitution_fixture()
      assert {:ok, %Constitution{} = constitution} = Constitutions.update_constitution(constitution, @update_attrs)
      assert constitution.content == "some updated content"
      assert constitution.content_hash == "some updated content_hash"
      assert constitution.empowered_on == ~N[2011-05-18 15:01:01]
      assert constitution.nationality == "some updated nationality"
      assert constitution.sighed_by == []
    end

    test "update_constitution/2 with invalid data returns error changeset" do
      constitution = constitution_fixture()
      assert {:error, %Ecto.Changeset{}} = Constitutions.update_constitution(constitution, @invalid_attrs)
      assert constitution == Constitutions.get_constitution!(constitution.id)
    end

    test "delete_constitution/1 deletes the constitution" do
      constitution = constitution_fixture()
      assert {:ok, %Constitution{}} = Constitutions.delete_constitution(constitution)
      assert_raise Ecto.NoResultsError, fn -> Constitutions.get_constitution!(constitution.id) end
    end

    test "change_constitution/1 returns a constitution changeset" do
      constitution = constitution_fixture()
      assert %Ecto.Changeset{} = Constitutions.change_constitution(constitution)
    end
  end
end
