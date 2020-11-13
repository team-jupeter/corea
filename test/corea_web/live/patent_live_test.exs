defmodule CoreaWeb.PatentLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Patents

  @create_attrs %{issued_by: "some issued_by"}
  @update_attrs %{issued_by: "some updated issued_by"}
  @invalid_attrs %{issued_by: nil}

  defp fixture(:patent) do
    {:ok, patent} = Patents.create_patent(@create_attrs)
    patent
  end

  defp create_patent(_) do
    patent = fixture(:patent)
    %{patent: patent}
  end

  describe "Index" do
    setup [:create_patent]

    test "lists all patents", %{conn: conn, patent: patent} do
      {:ok, _index_live, html} = live(conn, Routes.patent_index_path(conn, :index))

      assert html =~ "Listing Patents"
      assert html =~ patent.issued_by
    end

    test "saves new patent", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.patent_index_path(conn, :index))

      assert index_live |> element("a", "New Patent") |> render_click() =~
               "New Patent"

      assert_patch(index_live, Routes.patent_index_path(conn, :new))

      assert index_live
             |> form("#patent-form", patent: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#patent-form", patent: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patent_index_path(conn, :index))

      assert html =~ "Patent created successfully"
      assert html =~ "some issued_by"
    end

    test "updates patent in listing", %{conn: conn, patent: patent} do
      {:ok, index_live, _html} = live(conn, Routes.patent_index_path(conn, :index))

      assert index_live |> element("#patent-#{patent.id} a", "Edit") |> render_click() =~
               "Edit Patent"

      assert_patch(index_live, Routes.patent_index_path(conn, :edit, patent))

      assert index_live
             |> form("#patent-form", patent: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#patent-form", patent: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patent_index_path(conn, :index))

      assert html =~ "Patent updated successfully"
      assert html =~ "some updated issued_by"
    end

    test "deletes patent in listing", %{conn: conn, patent: patent} do
      {:ok, index_live, _html} = live(conn, Routes.patent_index_path(conn, :index))

      assert index_live |> element("#patent-#{patent.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#patent-#{patent.id}")
    end
  end

  describe "Show" do
    setup [:create_patent]

    test "displays patent", %{conn: conn, patent: patent} do
      {:ok, _show_live, html} = live(conn, Routes.patent_show_path(conn, :show, patent))

      assert html =~ "Show Patent"
      assert html =~ patent.issued_by
    end

    test "updates patent within modal", %{conn: conn, patent: patent} do
      {:ok, show_live, _html} = live(conn, Routes.patent_show_path(conn, :show, patent))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Patent"

      assert_patch(show_live, Routes.patent_show_path(conn, :edit, patent))

      assert show_live
             |> form("#patent-form", patent: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#patent-form", patent: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patent_show_path(conn, :show, patent))

      assert html =~ "Patent updated successfully"
      assert html =~ "some updated issued_by"
    end
  end
end
