defmodule Corea.TreatmentsTest do
  use Corea.DataCase

  alias Corea.Treatments

  describe "treatments" do
    alias Corea.Treatments.Treatment

    @valid_attrs %{doctor: "some doctor"}
    @update_attrs %{doctor: "some updated doctor"}
    @invalid_attrs %{doctor: nil}

    def treatment_fixture(attrs \\ %{}) do
      {:ok, treatment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Treatments.create_treatment()

      treatment
    end

    test "list_treatments/0 returns all treatments" do
      treatment = treatment_fixture()
      assert Treatments.list_treatments() == [treatment]
    end

    test "get_treatment!/1 returns the treatment with given id" do
      treatment = treatment_fixture()
      assert Treatments.get_treatment!(treatment.id) == treatment
    end

    test "create_treatment/1 with valid data creates a treatment" do
      assert {:ok, %Treatment{} = treatment} = Treatments.create_treatment(@valid_attrs)
      assert treatment.doctor == "some doctor"
    end

    test "create_treatment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Treatments.create_treatment(@invalid_attrs)
    end

    test "update_treatment/2 with valid data updates the treatment" do
      treatment = treatment_fixture()
      assert {:ok, %Treatment{} = treatment} = Treatments.update_treatment(treatment, @update_attrs)
      assert treatment.doctor == "some updated doctor"
    end

    test "update_treatment/2 with invalid data returns error changeset" do
      treatment = treatment_fixture()
      assert {:error, %Ecto.Changeset{}} = Treatments.update_treatment(treatment, @invalid_attrs)
      assert treatment == Treatments.get_treatment!(treatment.id)
    end

    test "delete_treatment/1 deletes the treatment" do
      treatment = treatment_fixture()
      assert {:ok, %Treatment{}} = Treatments.delete_treatment(treatment)
      assert_raise Ecto.NoResultsError, fn -> Treatments.get_treatment!(treatment.id) end
    end

    test "change_treatment/1 returns a treatment changeset" do
      treatment = treatment_fixture()
      assert %Ecto.Changeset{} = Treatments.change_treatment(treatment)
    end
  end
end
