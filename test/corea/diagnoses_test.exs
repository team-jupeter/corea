defmodule Corea.DiagnosesTest do
  use Corea.DataCase

  alias Corea.Diagnoses

  describe "diagnoses" do
    alias Corea.Diagnoses.Diagnosis

    @valid_attrs %{doctor: "some doctor"}
    @update_attrs %{doctor: "some updated doctor"}
    @invalid_attrs %{doctor: nil}

    def diagnosis_fixture(attrs \\ %{}) do
      {:ok, diagnosis} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diagnoses.create_diagnosis()

      diagnosis
    end

    test "list_diagnoses/0 returns all diagnoses" do
      diagnosis = diagnosis_fixture()
      assert Diagnoses.list_diagnoses() == [diagnosis]
    end

    test "get_diagnosis!/1 returns the diagnosis with given id" do
      diagnosis = diagnosis_fixture()
      assert Diagnoses.get_diagnosis!(diagnosis.id) == diagnosis
    end

    test "create_diagnosis/1 with valid data creates a diagnosis" do
      assert {:ok, %Diagnosis{} = diagnosis} = Diagnoses.create_diagnosis(@valid_attrs)
      assert diagnosis.doctor == "some doctor"
    end

    test "create_diagnosis/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diagnoses.create_diagnosis(@invalid_attrs)
    end

    test "update_diagnosis/2 with valid data updates the diagnosis" do
      diagnosis = diagnosis_fixture()
      assert {:ok, %Diagnosis{} = diagnosis} = Diagnoses.update_diagnosis(diagnosis, @update_attrs)
      assert diagnosis.doctor == "some updated doctor"
    end

    test "update_diagnosis/2 with invalid data returns error changeset" do
      diagnosis = diagnosis_fixture()
      assert {:error, %Ecto.Changeset{}} = Diagnoses.update_diagnosis(diagnosis, @invalid_attrs)
      assert diagnosis == Diagnoses.get_diagnosis!(diagnosis.id)
    end

    test "delete_diagnosis/1 deletes the diagnosis" do
      diagnosis = diagnosis_fixture()
      assert {:ok, %Diagnosis{}} = Diagnoses.delete_diagnosis(diagnosis)
      assert_raise Ecto.NoResultsError, fn -> Diagnoses.get_diagnosis!(diagnosis.id) end
    end

    test "change_diagnosis/1 returns a diagnosis changeset" do
      diagnosis = diagnosis_fixture()
      assert %Ecto.Changeset{} = Diagnoses.change_diagnosis(diagnosis)
    end
  end
end
