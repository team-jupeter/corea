defmodule CoreaWeb.MentorLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Mentors

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:mentor) do
    {:ok, mentor} = Mentors.create_mentor(@create_attrs)
    mentor
  end

  defp create_mentor(_) do
    mentor = fixture(:mentor)
    %{mentor: mentor}
  end

  describe "Index" do
    setup [:create_mentor]

    test "lists all mentors", %{conn: conn, mentor: mentor} do
      {:ok, _index_live, html} = live(conn, Routes.mentor_index_path(conn, :index))

      assert html =~ "Listing Mentors"
      assert html =~ mentor.name
    end

    test "saves new mentor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.mentor_index_path(conn, :index))

      assert index_live |> element("a", "New Mentor") |> render_click() =~
               "New Mentor"

      assert_patch(index_live, Routes.mentor_index_path(conn, :new))

      assert index_live
             |> form("#mentor-form", mentor: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mentor-form", mentor: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mentor_index_path(conn, :index))

      assert html =~ "Mentor created successfully"
      assert html =~ "some name"
    end

    test "updates mentor in listing", %{conn: conn, mentor: mentor} do
      {:ok, index_live, _html} = live(conn, Routes.mentor_index_path(conn, :index))

      assert index_live |> element("#mentor-#{mentor.id} a", "Edit") |> render_click() =~
               "Edit Mentor"

      assert_patch(index_live, Routes.mentor_index_path(conn, :edit, mentor))

      assert index_live
             |> form("#mentor-form", mentor: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mentor-form", mentor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mentor_index_path(conn, :index))

      assert html =~ "Mentor updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes mentor in listing", %{conn: conn, mentor: mentor} do
      {:ok, index_live, _html} = live(conn, Routes.mentor_index_path(conn, :index))

      assert index_live |> element("#mentor-#{mentor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mentor-#{mentor.id}")
    end
  end

  describe "Show" do
    setup [:create_mentor]

    test "displays mentor", %{conn: conn, mentor: mentor} do
      {:ok, _show_live, html} = live(conn, Routes.mentor_show_path(conn, :show, mentor))

      assert html =~ "Show Mentor"
      assert html =~ mentor.name
    end

    test "updates mentor within modal", %{conn: conn, mentor: mentor} do
      {:ok, show_live, _html} = live(conn, Routes.mentor_show_path(conn, :show, mentor))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mentor"

      assert_patch(show_live, Routes.mentor_show_path(conn, :edit, mentor))

      assert show_live
             |> form("#mentor-form", mentor: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#mentor-form", mentor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mentor_show_path(conn, :show, mentor))

      assert html =~ "Mentor updated successfully"
      assert html =~ "some updated name"
    end
  end
end
