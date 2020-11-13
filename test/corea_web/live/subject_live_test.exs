defmodule CoreaWeb.SubjectLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Subjects

  @create_attrs %{category: "some category"}
  @update_attrs %{category: "some updated category"}
  @invalid_attrs %{category: nil}

  defp fixture(:subject) do
    {:ok, subject} = Subjects.create_subject(@create_attrs)
    subject
  end

  defp create_subject(_) do
    subject = fixture(:subject)
    %{subject: subject}
  end

  describe "Index" do
    setup [:create_subject]

    test "lists all subjects", %{conn: conn, subject: subject} do
      {:ok, _index_live, html} = live(conn, Routes.subject_index_path(conn, :index))

      assert html =~ "Listing Subjects"
      assert html =~ subject.category
    end

    test "saves new subject", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.subject_index_path(conn, :index))

      assert index_live |> element("a", "New Subject") |> render_click() =~
               "New Subject"

      assert_patch(index_live, Routes.subject_index_path(conn, :new))

      assert index_live
             |> form("#subject-form", subject: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#subject-form", subject: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.subject_index_path(conn, :index))

      assert html =~ "Subject created successfully"
      assert html =~ "some category"
    end

    test "updates subject in listing", %{conn: conn, subject: subject} do
      {:ok, index_live, _html} = live(conn, Routes.subject_index_path(conn, :index))

      assert index_live |> element("#subject-#{subject.id} a", "Edit") |> render_click() =~
               "Edit Subject"

      assert_patch(index_live, Routes.subject_index_path(conn, :edit, subject))

      assert index_live
             |> form("#subject-form", subject: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#subject-form", subject: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.subject_index_path(conn, :index))

      assert html =~ "Subject updated successfully"
      assert html =~ "some updated category"
    end

    test "deletes subject in listing", %{conn: conn, subject: subject} do
      {:ok, index_live, _html} = live(conn, Routes.subject_index_path(conn, :index))

      assert index_live |> element("#subject-#{subject.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#subject-#{subject.id}")
    end
  end

  describe "Show" do
    setup [:create_subject]

    test "displays subject", %{conn: conn, subject: subject} do
      {:ok, _show_live, html} = live(conn, Routes.subject_show_path(conn, :show, subject))

      assert html =~ "Show Subject"
      assert html =~ subject.category
    end

    test "updates subject within modal", %{conn: conn, subject: subject} do
      {:ok, show_live, _html} = live(conn, Routes.subject_show_path(conn, :show, subject))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Subject"

      assert_patch(show_live, Routes.subject_show_path(conn, :edit, subject))

      assert show_live
             |> form("#subject-form", subject: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#subject-form", subject: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.subject_show_path(conn, :show, subject))

      assert html =~ "Subject updated successfully"
      assert html =~ "some updated category"
    end
  end
end
