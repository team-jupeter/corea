defmodule CoreaWeb.TerminalLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Terminals

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  defp fixture(:terminal) do
    {:ok, terminal} = Terminals.create_terminal(@create_attrs)
    terminal
  end

  defp create_terminal(_) do
    terminal = fixture(:terminal)
    %{terminal: terminal}
  end

  describe "Index" do
    setup [:create_terminal]

    test "lists all terminals", %{conn: conn, terminal: terminal} do
      {:ok, _index_live, html} = live(conn, Routes.terminal_index_path(conn, :index))

      assert html =~ "Listing Terminals"
      assert html =~ terminal.type
    end

    test "saves new terminal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.terminal_index_path(conn, :index))

      assert index_live |> element("a", "New Terminal") |> render_click() =~
               "New Terminal"

      assert_patch(index_live, Routes.terminal_index_path(conn, :new))

      assert index_live
             |> form("#terminal-form", terminal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#terminal-form", terminal: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.terminal_index_path(conn, :index))

      assert html =~ "Terminal created successfully"
      assert html =~ "some type"
    end

    test "updates terminal in listing", %{conn: conn, terminal: terminal} do
      {:ok, index_live, _html} = live(conn, Routes.terminal_index_path(conn, :index))

      assert index_live |> element("#terminal-#{terminal.id} a", "Edit") |> render_click() =~
               "Edit Terminal"

      assert_patch(index_live, Routes.terminal_index_path(conn, :edit, terminal))

      assert index_live
             |> form("#terminal-form", terminal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#terminal-form", terminal: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.terminal_index_path(conn, :index))

      assert html =~ "Terminal updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes terminal in listing", %{conn: conn, terminal: terminal} do
      {:ok, index_live, _html} = live(conn, Routes.terminal_index_path(conn, :index))

      assert index_live |> element("#terminal-#{terminal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#terminal-#{terminal.id}")
    end
  end

  describe "Show" do
    setup [:create_terminal]

    test "displays terminal", %{conn: conn, terminal: terminal} do
      {:ok, _show_live, html} = live(conn, Routes.terminal_show_path(conn, :show, terminal))

      assert html =~ "Show Terminal"
      assert html =~ terminal.type
    end

    test "updates terminal within modal", %{conn: conn, terminal: terminal} do
      {:ok, show_live, _html} = live(conn, Routes.terminal_show_path(conn, :show, terminal))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Terminal"

      assert_patch(show_live, Routes.terminal_show_path(conn, :edit, terminal))

      assert show_live
             |> form("#terminal-form", terminal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#terminal-form", terminal: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.terminal_show_path(conn, :show, terminal))

      assert html =~ "Terminal updated successfully"
      assert html =~ "some updated type"
    end
  end
end
