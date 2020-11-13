defmodule CoreaWeb.MetabolicPanelLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.MetabolicPanels

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:metabolic_panel) do
    {:ok, metabolic_panel} = MetabolicPanels.create_metabolic_panel(@create_attrs)
    metabolic_panel
  end

  defp create_metabolic_panel(_) do
    metabolic_panel = fixture(:metabolic_panel)
    %{metabolic_panel: metabolic_panel}
  end

  describe "Index" do
    setup [:create_metabolic_panel]

    test "lists all metabolic_panels", %{conn: conn, metabolic_panel: metabolic_panel} do
      {:ok, _index_live, html} = live(conn, Routes.metabolic_panel_index_path(conn, :index))

      assert html =~ "Listing Metabolic panels"
      assert html =~ metabolic_panel.name
    end

    test "saves new metabolic_panel", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.metabolic_panel_index_path(conn, :index))

      assert index_live |> element("a", "New Metabolic panel") |> render_click() =~
               "New Metabolic panel"

      assert_patch(index_live, Routes.metabolic_panel_index_path(conn, :new))

      assert index_live
             |> form("#metabolic_panel-form", metabolic_panel: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#metabolic_panel-form", metabolic_panel: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.metabolic_panel_index_path(conn, :index))

      assert html =~ "Metabolic panel created successfully"
      assert html =~ "some name"
    end

    test "updates metabolic_panel in listing", %{conn: conn, metabolic_panel: metabolic_panel} do
      {:ok, index_live, _html} = live(conn, Routes.metabolic_panel_index_path(conn, :index))

      assert index_live |> element("#metabolic_panel-#{metabolic_panel.id} a", "Edit") |> render_click() =~
               "Edit Metabolic panel"

      assert_patch(index_live, Routes.metabolic_panel_index_path(conn, :edit, metabolic_panel))

      assert index_live
             |> form("#metabolic_panel-form", metabolic_panel: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#metabolic_panel-form", metabolic_panel: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.metabolic_panel_index_path(conn, :index))

      assert html =~ "Metabolic panel updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes metabolic_panel in listing", %{conn: conn, metabolic_panel: metabolic_panel} do
      {:ok, index_live, _html} = live(conn, Routes.metabolic_panel_index_path(conn, :index))

      assert index_live |> element("#metabolic_panel-#{metabolic_panel.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#metabolic_panel-#{metabolic_panel.id}")
    end
  end

  describe "Show" do
    setup [:create_metabolic_panel]

    test "displays metabolic_panel", %{conn: conn, metabolic_panel: metabolic_panel} do
      {:ok, _show_live, html} = live(conn, Routes.metabolic_panel_show_path(conn, :show, metabolic_panel))

      assert html =~ "Show Metabolic panel"
      assert html =~ metabolic_panel.name
    end

    test "updates metabolic_panel within modal", %{conn: conn, metabolic_panel: metabolic_panel} do
      {:ok, show_live, _html} = live(conn, Routes.metabolic_panel_show_path(conn, :show, metabolic_panel))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Metabolic panel"

      assert_patch(show_live, Routes.metabolic_panel_show_path(conn, :edit, metabolic_panel))

      assert show_live
             |> form("#metabolic_panel-form", metabolic_panel: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#metabolic_panel-form", metabolic_panel: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.metabolic_panel_show_path(conn, :show, metabolic_panel))

      assert html =~ "Metabolic panel updated successfully"
      assert html =~ "some updated name"
    end
  end
end
