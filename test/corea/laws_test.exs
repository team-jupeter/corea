defmodule Corea.LawsTest do
  use Corea.DataCase

  alias Corea.Laws

  describe "laws" do
    alias Corea.Laws.Law

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def law_fixture(attrs \\ %{}) do
      {:ok, law} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Laws.create_law()

      law
    end

    test "list_laws/0 returns all laws" do
      law = law_fixture()
      assert Laws.list_laws() == [law]
    end

    test "get_law!/1 returns the law with given id" do
      law = law_fixture()
      assert Laws.get_law!(law.id) == law
    end

    test "create_law/1 with valid data creates a law" do
      assert {:ok, %Law{} = law} = Laws.create_law(@valid_attrs)
      assert law.type == "some type"
    end

    test "create_law/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Laws.create_law(@invalid_attrs)
    end

    test "update_law/2 with valid data updates the law" do
      law = law_fixture()
      assert {:ok, %Law{} = law} = Laws.update_law(law, @update_attrs)
      assert law.type == "some updated type"
    end

    test "update_law/2 with invalid data returns error changeset" do
      law = law_fixture()
      assert {:error, %Ecto.Changeset{}} = Laws.update_law(law, @invalid_attrs)
      assert law == Laws.get_law!(law.id)
    end

    test "delete_law/1 deletes the law" do
      law = law_fixture()
      assert {:ok, %Law{}} = Laws.delete_law(law)
      assert_raise Ecto.NoResultsError, fn -> Laws.get_law!(law.id) end
    end

    test "change_law/1 returns a law changeset" do
      law = law_fixture()
      assert %Ecto.Changeset{} = Laws.change_law(law)
    end
  end
end
