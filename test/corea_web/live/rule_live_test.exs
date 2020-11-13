defmodule CoreaWeb.RuleLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Rules

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:rule) do
    {:ok, rule} = Rules.create_rule(@create_attrs)
    rule
  end

  defp create_rule(_) do
    rule = fixture(:rule)
    %{rule: rule}
  end

  describe "Index" do
    setup [:create_rule]

    test "lists all rules", %{conn: conn, rule: rule} do
      {:ok, _index_live, html} = live(conn, Routes.rule_index_path(conn, :index))

      assert html =~ "Listing Rules"
      assert html =~ rule.title
    end

    test "saves new rule", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rule_index_path(conn, :index))

      assert index_live |> element("a", "New Rule") |> render_click() =~
               "New Rule"

      assert_patch(index_live, Routes.rule_index_path(conn, :new))

      assert index_live
             |> form("#rule-form", rule: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rule-form", rule: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rule_index_path(conn, :index))

      assert html =~ "Rule created successfully"
      assert html =~ "some title"
    end

    test "updates rule in listing", %{conn: conn, rule: rule} do
      {:ok, index_live, _html} = live(conn, Routes.rule_index_path(conn, :index))

      assert index_live |> element("#rule-#{rule.id} a", "Edit") |> render_click() =~
               "Edit Rule"

      assert_patch(index_live, Routes.rule_index_path(conn, :edit, rule))

      assert index_live
             |> form("#rule-form", rule: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rule-form", rule: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rule_index_path(conn, :index))

      assert html =~ "Rule updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes rule in listing", %{conn: conn, rule: rule} do
      {:ok, index_live, _html} = live(conn, Routes.rule_index_path(conn, :index))

      assert index_live |> element("#rule-#{rule.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rule-#{rule.id}")
    end
  end

  describe "Show" do
    setup [:create_rule]

    test "displays rule", %{conn: conn, rule: rule} do
      {:ok, _show_live, html} = live(conn, Routes.rule_show_path(conn, :show, rule))

      assert html =~ "Show Rule"
      assert html =~ rule.title
    end

    test "updates rule within modal", %{conn: conn, rule: rule} do
      {:ok, show_live, _html} = live(conn, Routes.rule_show_path(conn, :show, rule))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rule"

      assert_patch(show_live, Routes.rule_show_path(conn, :edit, rule))

      assert show_live
             |> form("#rule-form", rule: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rule-form", rule: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rule_show_path(conn, :show, rule))

      assert html =~ "Rule updated successfully"
      assert html =~ "some updated title"
    end
  end
end
