defmodule CoreaWeb.PatentApplicationLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.PatentApplications

  @create_attrs %{applied_by: "some applied_by"}
  @update_attrs %{applied_by: "some updated applied_by"}
  @invalid_attrs %{applied_by: nil}

  defp fixture(:patent_application) do
    {:ok, patent_application} = PatentApplications.create_patent_application(@create_attrs)
    patent_application
  end

  defp create_patent_application(_) do
    patent_application = fixture(:patent_application)
    %{patent_application: patent_application}
  end

  describe "Index" do
    setup [:create_patent_application]

    test "lists all patent_applications", %{conn: conn, patent_application: patent_application} do
      {:ok, _index_live, html} = live(conn, Routes.patent_application_index_path(conn, :index))

      assert html =~ "Listing Patent applications"
      assert html =~ patent_application.applied_by
    end

    test "saves new patent_application", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.patent_application_index_path(conn, :index))

      assert index_live |> element("a", "New Patent application") |> render_click() =~
               "New Patent application"

      assert_patch(index_live, Routes.patent_application_index_path(conn, :new))

      assert index_live
             |> form("#patent_application-form", patent_application: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#patent_application-form", patent_application: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patent_application_index_path(conn, :index))

      assert html =~ "Patent application created successfully"
      assert html =~ "some applied_by"
    end

    test "updates patent_application in listing", %{conn: conn, patent_application: patent_application} do
      {:ok, index_live, _html} = live(conn, Routes.patent_application_index_path(conn, :index))

      assert index_live |> element("#patent_application-#{patent_application.id} a", "Edit") |> render_click() =~
               "Edit Patent application"

      assert_patch(index_live, Routes.patent_application_index_path(conn, :edit, patent_application))

      assert index_live
             |> form("#patent_application-form", patent_application: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#patent_application-form", patent_application: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patent_application_index_path(conn, :index))

      assert html =~ "Patent application updated successfully"
      assert html =~ "some updated applied_by"
    end

    test "deletes patent_application in listing", %{conn: conn, patent_application: patent_application} do
      {:ok, index_live, _html} = live(conn, Routes.patent_application_index_path(conn, :index))

      assert index_live |> element("#patent_application-#{patent_application.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#patent_application-#{patent_application.id}")
    end
  end

  describe "Show" do
    setup [:create_patent_application]

    test "displays patent_application", %{conn: conn, patent_application: patent_application} do
      {:ok, _show_live, html} = live(conn, Routes.patent_application_show_path(conn, :show, patent_application))

      assert html =~ "Show Patent application"
      assert html =~ patent_application.applied_by
    end

    test "updates patent_application within modal", %{conn: conn, patent_application: patent_application} do
      {:ok, show_live, _html} = live(conn, Routes.patent_application_show_path(conn, :show, patent_application))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Patent application"

      assert_patch(show_live, Routes.patent_application_show_path(conn, :edit, patent_application))

      assert show_live
             |> form("#patent_application-form", patent_application: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#patent_application-form", patent_application: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patent_application_show_path(conn, :show, patent_application))

      assert html =~ "Patent application updated successfully"
      assert html =~ "some updated applied_by"
    end
  end
end
