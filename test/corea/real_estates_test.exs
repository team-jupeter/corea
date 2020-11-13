defmodule Corea.RealEstatesTest do
  use Corea.DataCase

  alias Corea.RealEstates

  describe "real_estates" do
    alias Corea.RealEstates.RealEstate

    @valid_attrs %{category: "some category"}
    @update_attrs %{category: "some updated category"}
    @invalid_attrs %{category: nil}

    def real_estate_fixture(attrs \\ %{}) do
      {:ok, real_estate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RealEstates.create_real_estate()

      real_estate
    end

    test "list_real_estates/0 returns all real_estates" do
      real_estate = real_estate_fixture()
      assert RealEstates.list_real_estates() == [real_estate]
    end

    test "get_real_estate!/1 returns the real_estate with given id" do
      real_estate = real_estate_fixture()
      assert RealEstates.get_real_estate!(real_estate.id) == real_estate
    end

    test "create_real_estate/1 with valid data creates a real_estate" do
      assert {:ok, %RealEstate{} = real_estate} = RealEstates.create_real_estate(@valid_attrs)
      assert real_estate.category == "some category"
    end

    test "create_real_estate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RealEstates.create_real_estate(@invalid_attrs)
    end

    test "update_real_estate/2 with valid data updates the real_estate" do
      real_estate = real_estate_fixture()
      assert {:ok, %RealEstate{} = real_estate} = RealEstates.update_real_estate(real_estate, @update_attrs)
      assert real_estate.category == "some updated category"
    end

    test "update_real_estate/2 with invalid data returns error changeset" do
      real_estate = real_estate_fixture()
      assert {:error, %Ecto.Changeset{}} = RealEstates.update_real_estate(real_estate, @invalid_attrs)
      assert real_estate == RealEstates.get_real_estate!(real_estate.id)
    end

    test "delete_real_estate/1 deletes the real_estate" do
      real_estate = real_estate_fixture()
      assert {:ok, %RealEstate{}} = RealEstates.delete_real_estate(real_estate)
      assert_raise Ecto.NoResultsError, fn -> RealEstates.get_real_estate!(real_estate.id) end
    end

    test "change_real_estate/1 returns a real_estate changeset" do
      real_estate = real_estate_fixture()
      assert %Ecto.Changeset{} = RealEstates.change_real_estate(real_estate)
    end
  end
end
