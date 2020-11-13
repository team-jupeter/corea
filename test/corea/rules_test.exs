defmodule Corea.RulesTest do
  use Corea.DataCase

  alias Corea.Rules

  describe "rules" do
    alias Corea.Rules.Rule

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def rule_fixture(attrs \\ %{}) do
      {:ok, rule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rules.create_rule()

      rule
    end

    test "list_rules/0 returns all rules" do
      rule = rule_fixture()
      assert Rules.list_rules() == [rule]
    end

    test "get_rule!/1 returns the rule with given id" do
      rule = rule_fixture()
      assert Rules.get_rule!(rule.id) == rule
    end

    test "create_rule/1 with valid data creates a rule" do
      assert {:ok, %Rule{} = rule} = Rules.create_rule(@valid_attrs)
      assert rule.title == "some title"
    end

    test "create_rule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rules.create_rule(@invalid_attrs)
    end

    test "update_rule/2 with valid data updates the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{} = rule} = Rules.update_rule(rule, @update_attrs)
      assert rule.title == "some updated title"
    end

    test "update_rule/2 with invalid data returns error changeset" do
      rule = rule_fixture()
      assert {:error, %Ecto.Changeset{}} = Rules.update_rule(rule, @invalid_attrs)
      assert rule == Rules.get_rule!(rule.id)
    end

    test "delete_rule/1 deletes the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{}} = Rules.delete_rule(rule)
      assert_raise Ecto.NoResultsError, fn -> Rules.get_rule!(rule.id) end
    end

    test "change_rule/1 returns a rule changeset" do
      rule = rule_fixture()
      assert %Ecto.Changeset{} = Rules.change_rule(rule)
    end
  end
end
