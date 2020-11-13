defmodule CoreaWeb.LabLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Labs

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:lab) do
    {:ok, lab} = Labs.create_lab(@create_attrs)
    lab
  end

  defp create_lab(_) do
    lab = fixture(:lab)
    %{lab: lab}
  end

  describe "Index" do
    setup [:create_lab]

    test "lists all labs", %{conn: conn, lab: lab} do
      {:ok, _index_live, html} = live(conn, Routes.lab_index_path(conn, :index))

      assert html =~ "Listing Labs"
      assert html =~ lab.name
    end

    test "saves new lab", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.lab_index_path(conn, :index))

      assert index_live |> element("a", "New Lab") |> render_click() =~
               "New Lab"

      assert_patch(index_live, Routes.lab_index_path(conn, :new))

      assert index_live
             |> form("#lab-form", lab: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#lab-form", lab: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lab_index_path(conn, :index))

      assert html =~ "Lab created successfully"
      assert html =~ "some name"
    end

    test "updates lab in listing", %{conn: conn, lab: lab} do
      {:ok, index_live, _html} = live(conn, Routes.lab_index_path(conn, :index))

      assert index_live |> element("#lab-#{lab.id} a", "Edit") |> render_click() =~
               "Edit Lab"

      assert_patch(index_live, Routes.lab_index_path(conn, :edit, lab))

      assert index_live
             |> form("#lab-form", lab: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#lab-form", lab: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lab_index_path(conn, :index))

      assert html =~ "Lab updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes lab in listing", %{conn: conn, lab: lab} do
      {:ok, index_live, _html} = live(conn, Routes.lab_index_path(conn, :index))

      assert index_live |> element("#lab-#{lab.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#lab-#{lab.id}")
    end
  end

  describe "Show" do
    setup [:create_lab]

    test "displays lab", %{conn: conn, lab: lab} do
      {:ok, _show_live, html} = live(conn, Routes.lab_show_path(conn, :show, lab))

      assert html =~ "Show Lab"
      assert html =~ lab.name
    end

    test "updates lab within modal", %{conn: conn, lab: lab} do
      {:ok, show_live, _html} = live(conn, Routes.lab_show_path(conn, :show, lab))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Lab"

      assert_patch(show_live, Routes.lab_show_path(conn, :edit, lab))

      assert show_live
             |> form("#lab-form", lab: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#lab-form", lab: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lab_show_path(conn, :show, lab))

      assert html =~ "Lab updated successfully"
      assert html =~ "some updated name"
    end
  end
end
