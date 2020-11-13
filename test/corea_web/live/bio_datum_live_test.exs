defmodule CoreaWeb.BioDatumLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.BioData

  @create_attrs %{dna: "some dna"}
  @update_attrs %{dna: "some updated dna"}
  @invalid_attrs %{dna: nil}

  defp fixture(:bio_datum) do
    {:ok, bio_datum} = BioData.create_bio_datum(@create_attrs)
    bio_datum
  end

  defp create_bio_datum(_) do
    bio_datum = fixture(:bio_datum)
    %{bio_datum: bio_datum}
  end

  describe "Index" do
    setup [:create_bio_datum]

    test "lists all bio_data", %{conn: conn, bio_datum: bio_datum} do
      {:ok, _index_live, html} = live(conn, Routes.bio_datum_index_path(conn, :index))

      assert html =~ "Listing Bio data"
      assert html =~ bio_datum.dna
    end

    test "saves new bio_datum", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bio_datum_index_path(conn, :index))

      assert index_live |> element("a", "New Bio datum") |> render_click() =~
               "New Bio datum"

      assert_patch(index_live, Routes.bio_datum_index_path(conn, :new))

      assert index_live
             |> form("#bio_datum-form", bio_datum: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bio_datum-form", bio_datum: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bio_datum_index_path(conn, :index))

      assert html =~ "Bio datum created successfully"
      assert html =~ "some dna"
    end

    test "updates bio_datum in listing", %{conn: conn, bio_datum: bio_datum} do
      {:ok, index_live, _html} = live(conn, Routes.bio_datum_index_path(conn, :index))

      assert index_live |> element("#bio_datum-#{bio_datum.id} a", "Edit") |> render_click() =~
               "Edit Bio datum"

      assert_patch(index_live, Routes.bio_datum_index_path(conn, :edit, bio_datum))

      assert index_live
             |> form("#bio_datum-form", bio_datum: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bio_datum-form", bio_datum: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bio_datum_index_path(conn, :index))

      assert html =~ "Bio datum updated successfully"
      assert html =~ "some updated dna"
    end

    test "deletes bio_datum in listing", %{conn: conn, bio_datum: bio_datum} do
      {:ok, index_live, _html} = live(conn, Routes.bio_datum_index_path(conn, :index))

      assert index_live |> element("#bio_datum-#{bio_datum.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bio_datum-#{bio_datum.id}")
    end
  end

  describe "Show" do
    setup [:create_bio_datum]

    test "displays bio_datum", %{conn: conn, bio_datum: bio_datum} do
      {:ok, _show_live, html} = live(conn, Routes.bio_datum_show_path(conn, :show, bio_datum))

      assert html =~ "Show Bio datum"
      assert html =~ bio_datum.dna
    end

    test "updates bio_datum within modal", %{conn: conn, bio_datum: bio_datum} do
      {:ok, show_live, _html} = live(conn, Routes.bio_datum_show_path(conn, :show, bio_datum))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bio datum"

      assert_patch(show_live, Routes.bio_datum_show_path(conn, :edit, bio_datum))

      assert show_live
             |> form("#bio_datum-form", bio_datum: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bio_datum-form", bio_datum: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bio_datum_show_path(conn, :show, bio_datum))

      assert html =~ "Bio datum updated successfully"
      assert html =~ "some updated dna"
    end
  end
end
