defmodule Corea.EquityStatementsTest do
  use Corea.DataCase

  alias Corea.EquityStatements

  describe "equity_statements" do
    alias Corea.EquityStatements.EquityStatement

    @valid_attrs %{monetary_unit: "some monetary_unit"}
    @update_attrs %{monetary_unit: "some updated monetary_unit"}
    @invalid_attrs %{monetary_unit: nil}

    def equity_statement_fixture(attrs \\ %{}) do
      {:ok, equity_statement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EquityStatements.create_equity_statement()

      equity_statement
    end

    test "list_equity_statements/0 returns all equity_statements" do
      equity_statement = equity_statement_fixture()
      assert EquityStatements.list_equity_statements() == [equity_statement]
    end

    test "get_equity_statement!/1 returns the equity_statement with given id" do
      equity_statement = equity_statement_fixture()
      assert EquityStatements.get_equity_statement!(equity_statement.id) == equity_statement
    end

    test "create_equity_statement/1 with valid data creates a equity_statement" do
      assert {:ok, %EquityStatement{} = equity_statement} = EquityStatements.create_equity_statement(@valid_attrs)
      assert equity_statement.monetary_unit == "some monetary_unit"
    end

    test "create_equity_statement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EquityStatements.create_equity_statement(@invalid_attrs)
    end

    test "update_equity_statement/2 with valid data updates the equity_statement" do
      equity_statement = equity_statement_fixture()
      assert {:ok, %EquityStatement{} = equity_statement} = EquityStatements.update_equity_statement(equity_statement, @update_attrs)
      assert equity_statement.monetary_unit == "some updated monetary_unit"
    end

    test "update_equity_statement/2 with invalid data returns error changeset" do
      equity_statement = equity_statement_fixture()
      assert {:error, %Ecto.Changeset{}} = EquityStatements.update_equity_statement(equity_statement, @invalid_attrs)
      assert equity_statement == EquityStatements.get_equity_statement!(equity_statement.id)
    end

    test "delete_equity_statement/1 deletes the equity_statement" do
      equity_statement = equity_statement_fixture()
      assert {:ok, %EquityStatement{}} = EquityStatements.delete_equity_statement(equity_statement)
      assert_raise Ecto.NoResultsError, fn -> EquityStatements.get_equity_statement!(equity_statement.id) end
    end

    test "change_equity_statement/1 returns a equity_statement changeset" do
      equity_statement = equity_statement_fixture()
      assert %Ecto.Changeset{} = EquityStatements.change_equity_statement(equity_statement)
    end
  end
end
