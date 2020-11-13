defmodule CoreaWeb.PoliceLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Polices

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:police) do
    {:ok, police} = Polices.create_police(@create_attrs)
    police
  end

  defp create_police(_) do
    police = fixture(:police)
    %{police: police}
  end

  describe "Index" do
    setup [:create_police]

    test "lists all polices", %{conn: conn, police: police} do
      {:ok, _index_live, html} = live(conn, Routes.police_index_path(conn, :index))

      assert html =~ "Listing Polices"
      assert html =~ police.name
    end

    test "saves new police", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.police_index_path(conn, :index))

      assert index_live |> element("a", "New Police") |> render_click() =~
               "New Police"

      assert_patch(index_live, Routes.police_index_path(conn, :new))

      assert index_live
             |> form("#police-form", police: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#police-form", police: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.police_index_path(conn, :index))

      assert html =~ "Police created successfully"
      assert html =~ "some name"
    end

    test "updates police in listing", %{conn: conn, police: police} do
      {:ok, index_live, _html} = live(conn, Routes.police_index_path(conn, :index))

      assert index_live |> element("#police-#{police.id} a", "Edit") |> render_click() =~
               "Edit Police"

      assert_patch(index_live, Routes.police_index_path(conn, :edit, police))

      assert index_live
             |> form("#police-form", police: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#police-form", police: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.police_index_path(conn, :index))

      assert html =~ "Police updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes police in listing", %{conn: conn, police: police} do
      {:ok, index_live, _html} = live(conn, Routes.police_index_path(conn, :index))

      assert index_live |> element("#police-#{police.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#police-#{police.id}")
    end
  end

  describe "Show" do
    setup [:create_police]

    test "displays police", %{conn: conn, police: police} do
      {:ok, _show_live, html} = live(conn, Routes.police_show_path(conn, :show, police))

      assert html =~ "Show Police"
      assert html =~ police.name
    end

    test "updates police within modal", %{conn: conn, police: police} do
      {:ok, show_live, _html} = live(conn, Routes.police_show_path(conn, :show, police))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Police"

      assert_patch(show_live, Routes.police_show_path(conn, :edit, police))

      assert show_live
             |> form("#police-form", police: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#police-form", police: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.police_show_path(conn, :show, police))

      assert html =~ "Police updated successfully"
      assert html =~ "some updated name"
    end
  end
end
