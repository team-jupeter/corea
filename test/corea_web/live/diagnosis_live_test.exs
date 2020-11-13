defmodule CoreaWeb.DiagnosisLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Diagnoses

  @create_attrs %{doctor: "some doctor"}
  @update_attrs %{doctor: "some updated doctor"}
  @invalid_attrs %{doctor: nil}

  defp fixture(:diagnosis) do
    {:ok, diagnosis} = Diagnoses.create_diagnosis(@create_attrs)
    diagnosis
  end

  defp create_diagnosis(_) do
    diagnosis = fixture(:diagnosis)
    %{diagnosis: diagnosis}
  end

  describe "Index" do
    setup [:create_diagnosis]

    test "lists all diagnoses", %{conn: conn, diagnosis: diagnosis} do
      {:ok, _index_live, html} = live(conn, Routes.diagnosis_index_path(conn, :index))

      assert html =~ "Listing Diagnoses"
      assert html =~ diagnosis.doctor
    end

    test "saves new diagnosis", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.diagnosis_index_path(conn, :index))

      assert index_live |> element("a", "New Diagnosis") |> render_click() =~
               "New Diagnosis"

      assert_patch(index_live, Routes.diagnosis_index_path(conn, :new))

      assert index_live
             |> form("#diagnosis-form", diagnosis: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#diagnosis-form", diagnosis: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.diagnosis_index_path(conn, :index))

      assert html =~ "Diagnosis created successfully"
      assert html =~ "some doctor"
    end

    test "updates diagnosis in listing", %{conn: conn, diagnosis: diagnosis} do
      {:ok, index_live, _html} = live(conn, Routes.diagnosis_index_path(conn, :index))

      assert index_live |> element("#diagnosis-#{diagnosis.id} a", "Edit") |> render_click() =~
               "Edit Diagnosis"

      assert_patch(index_live, Routes.diagnosis_index_path(conn, :edit, diagnosis))

      assert index_live
             |> form("#diagnosis-form", diagnosis: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#diagnosis-form", diagnosis: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.diagnosis_index_path(conn, :index))

      assert html =~ "Diagnosis updated successfully"
      assert html =~ "some updated doctor"
    end

    test "deletes diagnosis in listing", %{conn: conn, diagnosis: diagnosis} do
      {:ok, index_live, _html} = live(conn, Routes.diagnosis_index_path(conn, :index))

      assert index_live |> element("#diagnosis-#{diagnosis.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#diagnosis-#{diagnosis.id}")
    end
  end

  describe "Show" do
    setup [:create_diagnosis]

    test "displays diagnosis", %{conn: conn, diagnosis: diagnosis} do
      {:ok, _show_live, html} = live(conn, Routes.diagnosis_show_path(conn, :show, diagnosis))

      assert html =~ "Show Diagnosis"
      assert html =~ diagnosis.doctor
    end

    test "updates diagnosis within modal", %{conn: conn, diagnosis: diagnosis} do
      {:ok, show_live, _html} = live(conn, Routes.diagnosis_show_path(conn, :show, diagnosis))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Diagnosis"

      assert_patch(show_live, Routes.diagnosis_show_path(conn, :edit, diagnosis))

      assert show_live
             |> form("#diagnosis-form", diagnosis: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#diagnosis-form", diagnosis: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.diagnosis_show_path(conn, :show, diagnosis))

      assert html =~ "Diagnosis updated successfully"
      assert html =~ "some updated doctor"
    end
  end
end
