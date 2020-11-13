defmodule CoreaWeb.PrescriptionLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Prescriptions

  @create_attrs %{doctor: "some doctor"}
  @update_attrs %{doctor: "some updated doctor"}
  @invalid_attrs %{doctor: nil}

  defp fixture(:prescription) do
    {:ok, prescription} = Prescriptions.create_prescription(@create_attrs)
    prescription
  end

  defp create_prescription(_) do
    prescription = fixture(:prescription)
    %{prescription: prescription}
  end

  describe "Index" do
    setup [:create_prescription]

    test "lists all prescriptions", %{conn: conn, prescription: prescription} do
      {:ok, _index_live, html} = live(conn, Routes.prescription_index_path(conn, :index))

      assert html =~ "Listing Prescriptions"
      assert html =~ prescription.doctor
    end

    test "saves new prescription", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.prescription_index_path(conn, :index))

      assert index_live |> element("a", "New Prescription") |> render_click() =~
               "New Prescription"

      assert_patch(index_live, Routes.prescription_index_path(conn, :new))

      assert index_live
             |> form("#prescription-form", prescription: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#prescription-form", prescription: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.prescription_index_path(conn, :index))

      assert html =~ "Prescription created successfully"
      assert html =~ "some doctor"
    end

    test "updates prescription in listing", %{conn: conn, prescription: prescription} do
      {:ok, index_live, _html} = live(conn, Routes.prescription_index_path(conn, :index))

      assert index_live |> element("#prescription-#{prescription.id} a", "Edit") |> render_click() =~
               "Edit Prescription"

      assert_patch(index_live, Routes.prescription_index_path(conn, :edit, prescription))

      assert index_live
             |> form("#prescription-form", prescription: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#prescription-form", prescription: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.prescription_index_path(conn, :index))

      assert html =~ "Prescription updated successfully"
      assert html =~ "some updated doctor"
    end

    test "deletes prescription in listing", %{conn: conn, prescription: prescription} do
      {:ok, index_live, _html} = live(conn, Routes.prescription_index_path(conn, :index))

      assert index_live |> element("#prescription-#{prescription.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#prescription-#{prescription.id}")
    end
  end

  describe "Show" do
    setup [:create_prescription]

    test "displays prescription", %{conn: conn, prescription: prescription} do
      {:ok, _show_live, html} = live(conn, Routes.prescription_show_path(conn, :show, prescription))

      assert html =~ "Show Prescription"
      assert html =~ prescription.doctor
    end

    test "updates prescription within modal", %{conn: conn, prescription: prescription} do
      {:ok, show_live, _html} = live(conn, Routes.prescription_show_path(conn, :show, prescription))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Prescription"

      assert_patch(show_live, Routes.prescription_show_path(conn, :edit, prescription))

      assert show_live
             |> form("#prescription-form", prescription: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#prescription-form", prescription: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.prescription_show_path(conn, :show, prescription))

      assert html =~ "Prescription updated successfully"
      assert html =~ "some updated doctor"
    end
  end
end
