defmodule Corea.TerminalsTest do
  use Corea.DataCase

  alias Corea.Terminals

  describe "terminals" do
    alias Corea.Terminals.Terminal

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def terminal_fixture(attrs \\ %{}) do
      {:ok, terminal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Terminals.create_terminal()

      terminal
    end

    test "list_terminals/0 returns all terminals" do
      terminal = terminal_fixture()
      assert Terminals.list_terminals() == [terminal]
    end

    test "get_terminal!/1 returns the terminal with given id" do
      terminal = terminal_fixture()
      assert Terminals.get_terminal!(terminal.id) == terminal
    end

    test "create_terminal/1 with valid data creates a terminal" do
      assert {:ok, %Terminal{} = terminal} = Terminals.create_terminal(@valid_attrs)
      assert terminal.type == "some type"
    end

    test "create_terminal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Terminals.create_terminal(@invalid_attrs)
    end

    test "update_terminal/2 with valid data updates the terminal" do
      terminal = terminal_fixture()
      assert {:ok, %Terminal{} = terminal} = Terminals.update_terminal(terminal, @update_attrs)
      assert terminal.type == "some updated type"
    end

    test "update_terminal/2 with invalid data returns error changeset" do
      terminal = terminal_fixture()
      assert {:error, %Ecto.Changeset{}} = Terminals.update_terminal(terminal, @invalid_attrs)
      assert terminal == Terminals.get_terminal!(terminal.id)
    end

    test "delete_terminal/1 deletes the terminal" do
      terminal = terminal_fixture()
      assert {:ok, %Terminal{}} = Terminals.delete_terminal(terminal)
      assert_raise Ecto.NoResultsError, fn -> Terminals.get_terminal!(terminal.id) end
    end

    test "change_terminal/1 returns a terminal changeset" do
      terminal = terminal_fixture()
      assert %Ecto.Changeset{} = Terminals.change_terminal(terminal)
    end
  end
end
