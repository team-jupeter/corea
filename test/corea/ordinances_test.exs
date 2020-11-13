defmodule Corea.OrdinancesTest do
  use Corea.DataCase

  alias Corea.Ordinances

  describe "ordinances" do
    alias Corea.Ordinances.Ordinance

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def ordinance_fixture(attrs \\ %{}) do
      {:ok, ordinance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ordinances.create_ordinance()

      ordinance
    end

    test "list_ordinances/0 returns all ordinances" do
      ordinance = ordinance_fixture()
      assert Ordinances.list_ordinances() == [ordinance]
    end

    test "get_ordinance!/1 returns the ordinance with given id" do
      ordinance = ordinance_fixture()
      assert Ordinances.get_ordinance!(ordinance.id) == ordinance
    end

    test "create_ordinance/1 with valid data creates a ordinance" do
      assert {:ok, %Ordinance{} = ordinance} = Ordinances.create_ordinance(@valid_attrs)
      assert ordinance.title == "some title"
    end

    test "create_ordinance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ordinances.create_ordinance(@invalid_attrs)
    end

    test "update_ordinance/2 with valid data updates the ordinance" do
      ordinance = ordinance_fixture()
      assert {:ok, %Ordinance{} = ordinance} = Ordinances.update_ordinance(ordinance, @update_attrs)
      assert ordinance.title == "some updated title"
    end

    test "update_ordinance/2 with invalid data returns error changeset" do
      ordinance = ordinance_fixture()
      assert {:error, %Ecto.Changeset{}} = Ordinances.update_ordinance(ordinance, @invalid_attrs)
      assert ordinance == Ordinances.get_ordinance!(ordinance.id)
    end

    test "delete_ordinance/1 deletes the ordinance" do
      ordinance = ordinance_fixture()
      assert {:ok, %Ordinance{}} = Ordinances.delete_ordinance(ordinance)
      assert_raise Ecto.NoResultsError, fn -> Ordinances.get_ordinance!(ordinance.id) end
    end

    test "change_ordinance/1 returns a ordinance changeset" do
      ordinance = ordinance_fixture()
      assert %Ecto.Changeset{} = Ordinances.change_ordinance(ordinance)
    end
  end
end
