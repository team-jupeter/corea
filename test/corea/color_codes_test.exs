defmodule Corea.ColorCodesTest do
  use Corea.DataCase

  alias Corea.ColorCodes

  describe "color_codes" do
    alias Corea.ColorCodes.ColorCode

    @valid_attrs %{char_1: 42}
    @update_attrs %{char_1: 43}
    @invalid_attrs %{char_1: nil}

    def color_code_fixture(attrs \\ %{}) do
      {:ok, color_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ColorCodes.create_color_code()

      color_code
    end

    test "list_color_codes/0 returns all color_codes" do
      color_code = color_code_fixture()
      assert ColorCodes.list_color_codes() == [color_code]
    end

    test "get_color_code!/1 returns the color_code with given id" do
      color_code = color_code_fixture()
      assert ColorCodes.get_color_code!(color_code.id) == color_code
    end

    test "create_color_code/1 with valid data creates a color_code" do
      assert {:ok, %ColorCode{} = color_code} = ColorCodes.create_color_code(@valid_attrs)
      assert color_code.char_1 == 42
    end

    test "create_color_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ColorCodes.create_color_code(@invalid_attrs)
    end

    test "update_color_code/2 with valid data updates the color_code" do
      color_code = color_code_fixture()
      assert {:ok, %ColorCode{} = color_code} = ColorCodes.update_color_code(color_code, @update_attrs)
      assert color_code.char_1 == 43
    end

    test "update_color_code/2 with invalid data returns error changeset" do
      color_code = color_code_fixture()
      assert {:error, %Ecto.Changeset{}} = ColorCodes.update_color_code(color_code, @invalid_attrs)
      assert color_code == ColorCodes.get_color_code!(color_code.id)
    end

    test "delete_color_code/1 deletes the color_code" do
      color_code = color_code_fixture()
      assert {:ok, %ColorCode{}} = ColorCodes.delete_color_code(color_code)
      assert_raise Ecto.NoResultsError, fn -> ColorCodes.get_color_code!(color_code.id) end
    end

    test "change_color_code/1 returns a color_code changeset" do
      color_code = color_code_fixture()
      assert %Ecto.Changeset{} = ColorCodes.change_color_code(color_code)
    end
  end
end
