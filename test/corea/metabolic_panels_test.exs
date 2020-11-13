defmodule Corea.MetabolicPanelsTest do
  use Corea.DataCase

  alias Corea.MetabolicPanels

  describe "metabolic_panels" do
    alias Corea.MetabolicPanels.MetabolicPanel

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def metabolic_panel_fixture(attrs \\ %{}) do
      {:ok, metabolic_panel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MetabolicPanels.create_metabolic_panel()

      metabolic_panel
    end

    test "list_metabolic_panels/0 returns all metabolic_panels" do
      metabolic_panel = metabolic_panel_fixture()
      assert MetabolicPanels.list_metabolic_panels() == [metabolic_panel]
    end

    test "get_metabolic_panel!/1 returns the metabolic_panel with given id" do
      metabolic_panel = metabolic_panel_fixture()
      assert MetabolicPanels.get_metabolic_panel!(metabolic_panel.id) == metabolic_panel
    end

    test "create_metabolic_panel/1 with valid data creates a metabolic_panel" do
      assert {:ok, %MetabolicPanel{} = metabolic_panel} = MetabolicPanels.create_metabolic_panel(@valid_attrs)
      assert metabolic_panel.name == "some name"
    end

    test "create_metabolic_panel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MetabolicPanels.create_metabolic_panel(@invalid_attrs)
    end

    test "update_metabolic_panel/2 with valid data updates the metabolic_panel" do
      metabolic_panel = metabolic_panel_fixture()
      assert {:ok, %MetabolicPanel{} = metabolic_panel} = MetabolicPanels.update_metabolic_panel(metabolic_panel, @update_attrs)
      assert metabolic_panel.name == "some updated name"
    end

    test "update_metabolic_panel/2 with invalid data returns error changeset" do
      metabolic_panel = metabolic_panel_fixture()
      assert {:error, %Ecto.Changeset{}} = MetabolicPanels.update_metabolic_panel(metabolic_panel, @invalid_attrs)
      assert metabolic_panel == MetabolicPanels.get_metabolic_panel!(metabolic_panel.id)
    end

    test "delete_metabolic_panel/1 deletes the metabolic_panel" do
      metabolic_panel = metabolic_panel_fixture()
      assert {:ok, %MetabolicPanel{}} = MetabolicPanels.delete_metabolic_panel(metabolic_panel)
      assert_raise Ecto.NoResultsError, fn -> MetabolicPanels.get_metabolic_panel!(metabolic_panel.id) end
    end

    test "change_metabolic_panel/1 returns a metabolic_panel changeset" do
      metabolic_panel = metabolic_panel_fixture()
      assert %Ecto.Changeset{} = MetabolicPanels.change_metabolic_panel(metabolic_panel)
    end
  end
end
