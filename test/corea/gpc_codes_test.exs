defmodule Corea.GPCCodesTest do
  use Corea.DataCase

  alias Corea.GPCCodes

  describe "gpc_codes" do
    alias Corea.GPCCodes.GPCCode

    @valid_attrs %{code: "some code", name: "some name", standard: "some standard"}
    @update_attrs %{code: "some updated code", name: "some updated name", standard: "some updated standard"}
    @invalid_attrs %{code: nil, name: nil, standard: nil}

    def gpc_code_fixture(attrs \\ %{}) do
      {:ok, gpc_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GPCCodes.create_gpc_code()

      gpc_code
    end

    test "list_gpc_codes/0 returns all gpc_codes" do
      gpc_code = gpc_code_fixture()
      assert GPCCodes.list_gpc_codes() == [gpc_code]
    end

    test "get_gpc_code!/1 returns the gpc_code with given id" do
      gpc_code = gpc_code_fixture()
      assert GPCCodes.get_gpc_code!(gpc_code.id) == gpc_code
    end

    test "create_gpc_code/1 with valid data creates a gpc_code" do
      assert {:ok, %GPCCode{} = gpc_code} = GPCCodes.create_gpc_code(@valid_attrs)
      assert gpc_code.code == "some code"
      assert gpc_code.name == "some name"
      assert gpc_code.standard == "some standard"
    end

    test "create_gpc_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GPCCodes.create_gpc_code(@invalid_attrs)
    end

    test "update_gpc_code/2 with valid data updates the gpc_code" do
      gpc_code = gpc_code_fixture()
      assert {:ok, %GPCCode{} = gpc_code} = GPCCodes.update_gpc_code(gpc_code, @update_attrs)
      assert gpc_code.code == "some updated code"
      assert gpc_code.name == "some updated name"
      assert gpc_code.standard == "some updated standard"
    end

    test "update_gpc_code/2 with invalid data returns error changeset" do
      gpc_code = gpc_code_fixture()
      assert {:error, %Ecto.Changeset{}} = GPCCodes.update_gpc_code(gpc_code, @invalid_attrs)
      assert gpc_code == GPCCodes.get_gpc_code!(gpc_code.id)
    end

    test "delete_gpc_code/1 deletes the gpc_code" do
      gpc_code = gpc_code_fixture()
      assert {:ok, %GPCCode{}} = GPCCodes.delete_gpc_code(gpc_code)
      assert_raise Ecto.NoResultsError, fn -> GPCCodes.get_gpc_code!(gpc_code.id) end
    end

    test "change_gpc_code/1 returns a gpc_code changeset" do
      gpc_code = gpc_code_fixture()
      assert %Ecto.Changeset{} = GPCCodes.change_gpc_code(gpc_code)
    end
  end
end
