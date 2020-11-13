defmodule Corea.BioDataTest do
  use Corea.DataCase

  alias Corea.BioData

  describe "bio_data" do
    alias Corea.BioData.BioDatum

    @valid_attrs %{dna: "some dna"}
    @update_attrs %{dna: "some updated dna"}
    @invalid_attrs %{dna: nil}

    def bio_datum_fixture(attrs \\ %{}) do
      {:ok, bio_datum} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BioData.create_bio_datum()

      bio_datum
    end

    test "list_bio_data/0 returns all bio_data" do
      bio_datum = bio_datum_fixture()
      assert BioData.list_bio_data() == [bio_datum]
    end

    test "get_bio_datum!/1 returns the bio_datum with given id" do
      bio_datum = bio_datum_fixture()
      assert BioData.get_bio_datum!(bio_datum.id) == bio_datum
    end

    test "create_bio_datum/1 with valid data creates a bio_datum" do
      assert {:ok, %BioDatum{} = bio_datum} = BioData.create_bio_datum(@valid_attrs)
      assert bio_datum.dna == "some dna"
    end

    test "create_bio_datum/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BioData.create_bio_datum(@invalid_attrs)
    end

    test "update_bio_datum/2 with valid data updates the bio_datum" do
      bio_datum = bio_datum_fixture()
      assert {:ok, %BioDatum{} = bio_datum} = BioData.update_bio_datum(bio_datum, @update_attrs)
      assert bio_datum.dna == "some updated dna"
    end

    test "update_bio_datum/2 with invalid data returns error changeset" do
      bio_datum = bio_datum_fixture()
      assert {:error, %Ecto.Changeset{}} = BioData.update_bio_datum(bio_datum, @invalid_attrs)
      assert bio_datum == BioData.get_bio_datum!(bio_datum.id)
    end

    test "delete_bio_datum/1 deletes the bio_datum" do
      bio_datum = bio_datum_fixture()
      assert {:ok, %BioDatum{}} = BioData.delete_bio_datum(bio_datum)
      assert_raise Ecto.NoResultsError, fn -> BioData.get_bio_datum!(bio_datum.id) end
    end

    test "change_bio_datum/1 returns a bio_datum changeset" do
      bio_datum = bio_datum_fixture()
      assert %Ecto.Changeset{} = BioData.change_bio_datum(bio_datum)
    end
  end
end
