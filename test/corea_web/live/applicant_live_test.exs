defmodule CoreaWeb.ApplicantLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Applicants

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:applicant) do
    {:ok, applicant} = Applicants.create_applicant(@create_attrs)
    applicant
  end

  defp create_applicant(_) do
    applicant = fixture(:applicant)
    %{applicant: applicant}
  end

  describe "Index" do
    setup [:create_applicant]

    test "lists all applicants", %{conn: conn, applicant: applicant} do
      {:ok, _index_live, html} = live(conn, Routes.applicant_index_path(conn, :index))

      assert html =~ "Listing Applicants"
      assert html =~ applicant.name
    end

    test "saves new applicant", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.applicant_index_path(conn, :index))

      assert index_live |> element("a", "New Applicant") |> render_click() =~
               "New Applicant"

      assert_patch(index_live, Routes.applicant_index_path(conn, :new))

      assert index_live
             |> form("#applicant-form", applicant: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#applicant-form", applicant: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.applicant_index_path(conn, :index))

      assert html =~ "Applicant created successfully"
      assert html =~ "some name"
    end

    test "updates applicant in listing", %{conn: conn, applicant: applicant} do
      {:ok, index_live, _html} = live(conn, Routes.applicant_index_path(conn, :index))

      assert index_live |> element("#applicant-#{applicant.id} a", "Edit") |> render_click() =~
               "Edit Applicant"

      assert_patch(index_live, Routes.applicant_index_path(conn, :edit, applicant))

      assert index_live
             |> form("#applicant-form", applicant: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#applicant-form", applicant: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.applicant_index_path(conn, :index))

      assert html =~ "Applicant updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes applicant in listing", %{conn: conn, applicant: applicant} do
      {:ok, index_live, _html} = live(conn, Routes.applicant_index_path(conn, :index))

      assert index_live |> element("#applicant-#{applicant.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#applicant-#{applicant.id}")
    end
  end

  describe "Show" do
    setup [:create_applicant]

    test "displays applicant", %{conn: conn, applicant: applicant} do
      {:ok, _show_live, html} = live(conn, Routes.applicant_show_path(conn, :show, applicant))

      assert html =~ "Show Applicant"
      assert html =~ applicant.name
    end

    test "updates applicant within modal", %{conn: conn, applicant: applicant} do
      {:ok, show_live, _html} = live(conn, Routes.applicant_show_path(conn, :show, applicant))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Applicant"

      assert_patch(show_live, Routes.applicant_show_path(conn, :edit, applicant))

      assert show_live
             |> form("#applicant-form", applicant: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#applicant-form", applicant: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.applicant_show_path(conn, :show, applicant))

      assert html =~ "Applicant updated successfully"
      assert html =~ "some updated name"
    end
  end
end
