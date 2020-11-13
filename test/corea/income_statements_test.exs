defmodule Corea.IncomeStatementsTest do
  use Corea.DataCase

  alias Corea.IncomeStatements

  describe "income_statements" do
    alias Corea.IncomeStatements.IncomeStatement

    @valid_attrs %{entity_name: "some entity_name"}
    @update_attrs %{entity_name: "some updated entity_name"}
    @invalid_attrs %{entity_name: nil}

    def income_statement_fixture(attrs \\ %{}) do
      {:ok, income_statement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> IncomeStatements.create_income_statement()

      income_statement
    end

    test "list_income_statements/0 returns all income_statements" do
      income_statement = income_statement_fixture()
      assert IncomeStatements.list_income_statements() == [income_statement]
    end

    test "get_income_statement!/1 returns the income_statement with given id" do
      income_statement = income_statement_fixture()
      assert IncomeStatements.get_income_statement!(income_statement.id) == income_statement
    end

    test "create_income_statement/1 with valid data creates a income_statement" do
      assert {:ok, %IncomeStatement{} = income_statement} = IncomeStatements.create_income_statement(@valid_attrs)
      assert income_statement.entity_name == "some entity_name"
    end

    test "create_income_statement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = IncomeStatements.create_income_statement(@invalid_attrs)
    end

    test "update_income_statement/2 with valid data updates the income_statement" do
      income_statement = income_statement_fixture()
      assert {:ok, %IncomeStatement{} = income_statement} = IncomeStatements.update_income_statement(income_statement, @update_attrs)
      assert income_statement.entity_name == "some updated entity_name"
    end

    test "update_income_statement/2 with invalid data returns error changeset" do
      income_statement = income_statement_fixture()
      assert {:error, %Ecto.Changeset{}} = IncomeStatements.update_income_statement(income_statement, @invalid_attrs)
      assert income_statement == IncomeStatements.get_income_statement!(income_statement.id)
    end

    test "delete_income_statement/1 deletes the income_statement" do
      income_statement = income_statement_fixture()
      assert {:ok, %IncomeStatement{}} = IncomeStatements.delete_income_statement(income_statement)
      assert_raise Ecto.NoResultsError, fn -> IncomeStatements.get_income_statement!(income_statement.id) end
    end

    test "change_income_statement/1 returns a income_statement changeset" do
      income_statement = income_statement_fixture()
      assert %Ecto.Changeset{} = IncomeStatements.change_income_statement(income_statement)
    end
  end
end
