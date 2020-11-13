defmodule CoreaWeb.InitiativeLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Initiatives

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:initiative) do
    {:ok, initiative} = Initiatives.create_initiative(@create_attrs)
    initiative
  end

  defp create_initiative(_) do
    initiative = fixture(:initiative)
    %{initiative: initiative}
  end

  describe "Index" do
    setup [:create_initiative]

    test "lists all initiatives", %{conn: conn, initiative: initiative} do
      {:ok, _index_live, html} = live(conn, Routes.initiative_index_path(conn, :index))

      assert html =~ "Listing Initiatives"
      assert html =~ initiative.title
    end

    test "saves new initiative", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.initiative_index_path(conn, :index))

      assert index_live |> element("a", "New Initiative") |> render_click() =~
               "New Initiative"

      assert_patch(index_live, Routes.initiative_index_path(conn, :new))

      assert index_live
             |> form("#initiative-form", initiative: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#initiative-form", initiative: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.initiative_index_path(conn, :index))

      assert html =~ "Initiative created successfully"
      assert html =~ "some title"
    end

    test "updates initiative in listing", %{conn: conn, initiative: initiative} do
      {:ok, index_live, _html} = live(conn, Routes.initiative_index_path(conn, :index))

      assert index_live |> element("#initiative-#{initiative.id} a", "Edit") |> render_click() =~
               "Edit Initiative"

      assert_patch(index_live, Routes.initiative_index_path(conn, :edit, initiative))

      assert index_live
             |> form("#initiative-form", initiative: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#initiative-form", initiative: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.initiative_index_path(conn, :index))

      assert html =~ "Initiative updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes initiative in listing", %{conn: conn, initiative: initiative} do
      {:ok, index_live, _html} = live(conn, Routes.initiative_index_path(conn, :index))

      assert index_live |> element("#initiative-#{initiative.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#initiative-#{initiative.id}")
    end
  end

  describe "Show" do
    setup [:create_initiative]

    test "displays initiative", %{conn: conn, initiative: initiative} do
      {:ok, _show_live, html} = live(conn, Routes.initiative_show_path(conn, :show, initiative))

      assert html =~ "Show Initiative"
      assert html =~ initiative.title
    end

    test "updates initiative within modal", %{conn: conn, initiative: initiative} do
      {:ok, show_live, _html} = live(conn, Routes.initiative_show_path(conn, :show, initiative))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Initiative"

      assert_patch(show_live, Routes.initiative_show_path(conn, :edit, initiative))

      assert show_live
             |> form("#initiative-form", initiative: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#initiative-form", initiative: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.initiative_show_path(conn, :show, initiative))

      assert html =~ "Initiative updated successfully"
      assert html =~ "some updated title"
    end
  end
end
