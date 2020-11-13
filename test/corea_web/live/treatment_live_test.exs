defmodule CoreaWeb.TreatmentLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Treatments

  @create_attrs %{doctor: "some doctor"}
  @update_attrs %{doctor: "some updated doctor"}
  @invalid_attrs %{doctor: nil}

  defp fixture(:treatment) do
    {:ok, treatment} = Treatments.create_treatment(@create_attrs)
    treatment
  end

  defp create_treatment(_) do
    treatment = fixture(:treatment)
    %{treatment: treatment}
  end

  describe "Index" do
    setup [:create_treatment]

    test "lists all treatments", %{conn: conn, treatment: treatment} do
      {:ok, _index_live, html} = live(conn, Routes.treatment_index_path(conn, :index))

      assert html =~ "Listing Treatments"
      assert html =~ treatment.doctor
    end

    test "saves new treatment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.treatment_index_path(conn, :index))

      assert index_live |> element("a", "New Treatment") |> render_click() =~
               "New Treatment"

      assert_patch(index_live, Routes.treatment_index_path(conn, :new))

      assert index_live
             |> form("#treatment-form", treatment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#treatment-form", treatment: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.treatment_index_path(conn, :index))

      assert html =~ "Treatment created successfully"
      assert html =~ "some doctor"
    end

    test "updates treatment in listing", %{conn: conn, treatment: treatment} do
      {:ok, index_live, _html} = live(conn, Routes.treatment_index_path(conn, :index))

      assert index_live |> element("#treatment-#{treatment.id} a", "Edit") |> render_click() =~
               "Edit Treatment"

      assert_patch(index_live, Routes.treatment_index_path(conn, :edit, treatment))

      assert index_live
             |> form("#treatment-form", treatment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#treatment-form", treatment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.treatment_index_path(conn, :index))

      assert html =~ "Treatment updated successfully"
      assert html =~ "some updated doctor"
    end

    test "deletes treatment in listing", %{conn: conn, treatment: treatment} do
      {:ok, index_live, _html} = live(conn, Routes.treatment_index_path(conn, :index))

      assert index_live |> element("#treatment-#{treatment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#treatment-#{treatment.id}")
    end
  end

  describe "Show" do
    setup [:create_treatment]

    test "displays treatment", %{conn: conn, treatment: treatment} do
      {:ok, _show_live, html} = live(conn, Routes.treatment_show_path(conn, :show, treatment))

      assert html =~ "Show Treatment"
      assert html =~ treatment.doctor
    end

    test "updates treatment within modal", %{conn: conn, treatment: treatment} do
      {:ok, show_live, _html} = live(conn, Routes.treatment_show_path(conn, :show, treatment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Treatment"

      assert_patch(show_live, Routes.treatment_show_path(conn, :edit, treatment))

      assert show_live
             |> form("#treatment-form", treatment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#treatment-form", treatment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.treatment_show_path(conn, :show, treatment))

      assert html =~ "Treatment updated successfully"
      assert html =~ "some updated doctor"
    end
  end
end
