defmodule Corea.DiseaseControlsTest do
  use Corea.DataCase

  alias Corea.DiseaseControls

  describe "disease_controls" do
    alias Corea.DiseaseControls.DiseaseControl

    @valid_attrs %{nationality: "some nationality"}
    @update_attrs %{nationality: "some updated nationality"}
    @invalid_attrs %{nationality: nil}

    def disease_control_fixture(attrs \\ %{}) do
      {:ok, disease_control} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DiseaseControls.create_disease_control()

      disease_control
    end

    test "list_disease_controls/0 returns all disease_controls" do
      disease_control = disease_control_fixture()
      assert DiseaseControls.list_disease_controls() == [disease_control]
    end

    test "get_disease_control!/1 returns the disease_control with given id" do
      disease_control = disease_control_fixture()
      assert DiseaseControls.get_disease_control!(disease_control.id) == disease_control
    end

    test "create_disease_control/1 with valid data creates a disease_control" do
      assert {:ok, %DiseaseControl{} = disease_control} = DiseaseControls.create_disease_control(@valid_attrs)
      assert disease_control.nationality == "some nationality"
    end

    test "create_disease_control/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DiseaseControls.create_disease_control(@invalid_attrs)
    end

    test "update_disease_control/2 with valid data updates the disease_control" do
      disease_control = disease_control_fixture()
      assert {:ok, %DiseaseControl{} = disease_control} = DiseaseControls.update_disease_control(disease_control, @update_attrs)
      assert disease_control.nationality == "some updated nationality"
    end

    test "update_disease_control/2 with invalid data returns error changeset" do
      disease_control = disease_control_fixture()
      assert {:error, %Ecto.Changeset{}} = DiseaseControls.update_disease_control(disease_control, @invalid_attrs)
      assert disease_control == DiseaseControls.get_disease_control!(disease_control.id)
    end

    test "delete_disease_control/1 deletes the disease_control" do
      disease_control = disease_control_fixture()
      assert {:ok, %DiseaseControl{}} = DiseaseControls.delete_disease_control(disease_control)
      assert_raise Ecto.NoResultsError, fn -> DiseaseControls.get_disease_control!(disease_control.id) end
    end

    test "change_disease_control/1 returns a disease_control changeset" do
      disease_control = disease_control_fixture()
      assert %Ecto.Changeset{} = DiseaseControls.change_disease_control(disease_control)
    end
  end
end
