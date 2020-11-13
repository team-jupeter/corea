defmodule Corea.CFStatementsTest do
  use Corea.DataCase

  alias Corea.CFStatements

  describe "cf_statements" do
    alias Corea.CFStatements.CFStatement

    @valid_attrs %{entity_name: "some entity_name"}
    @update_attrs %{entity_name: "some updated entity_name"}
    @invalid_attrs %{entity_name: nil}

    def cf_statement_fixture(attrs \\ %{}) do
      {:ok, cf_statement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CFStatements.create_cf_statement()

      cf_statement
    end

    test "list_cf_statements/0 returns all cf_statements" do
      cf_statement = cf_statement_fixture()
      assert CFStatements.list_cf_statements() == [cf_statement]
    end

    test "get_cf_statement!/1 returns the cf_statement with given id" do
      cf_statement = cf_statement_fixture()
      assert CFStatements.get_cf_statement!(cf_statement.id) == cf_statement
    end

    test "create_cf_statement/1 with valid data creates a cf_statement" do
      assert {:ok, %CFStatement{} = cf_statement} = CFStatements.create_cf_statement(@valid_attrs)
      assert cf_statement.entity_name == "some entity_name"
    end

    test "create_cf_statement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CFStatements.create_cf_statement(@invalid_attrs)
    end

    test "update_cf_statement/2 with valid data updates the cf_statement" do
      cf_statement = cf_statement_fixture()
      assert {:ok, %CFStatement{} = cf_statement} = CFStatements.update_cf_statement(cf_statement, @update_attrs)
      assert cf_statement.entity_name == "some updated entity_name"
    end

    test "update_cf_statement/2 with invalid data returns error changeset" do
      cf_statement = cf_statement_fixture()
      assert {:error, %Ecto.Changeset{}} = CFStatements.update_cf_statement(cf_statement, @invalid_attrs)
      assert cf_statement == CFStatements.get_cf_statement!(cf_statement.id)
    end

    test "delete_cf_statement/1 deletes the cf_statement" do
      cf_statement = cf_statement_fixture()
      assert {:ok, %CFStatement{}} = CFStatements.delete_cf_statement(cf_statement)
      assert_raise Ecto.NoResultsError, fn -> CFStatements.get_cf_statement!(cf_statement.id) end
    end

    test "change_cf_statement/1 returns a cf_statement changeset" do
      cf_statement = cf_statement_fixture()
      assert %Ecto.Changeset{} = CFStatements.change_cf_statement(cf_statement)
    end
  end
end
