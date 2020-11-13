defmodule CoreaWeb.DiseaseControlLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.DiseaseControls

  @create_attrs %{nationality: "some nationality"}
  @update_attrs %{nationality: "some updated nationality"}
  @invalid_attrs %{nationality: nil}

  defp fixture(:disease_control) do
    {:ok, disease_control} = DiseaseControls.create_disease_control(@create_attrs)
    disease_control
  end

  defp create_disease_control(_) do
    disease_control = fixture(:disease_control)
    %{disease_control: disease_control}
  end

  describe "Index" do
    setup [:create_disease_control]

    test "lists all disease_controls", %{conn: conn, disease_control: disease_control} do
      {:ok, _index_live, html} = live(conn, Routes.disease_control_index_path(conn, :index))

      assert html =~ "Listing Disease controls"
      assert html =~ disease_control.nationality
    end

    test "saves new disease_control", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.disease_control_index_path(conn, :index))

      assert index_live |> element("a", "New Disease control") |> render_click() =~
               "New Disease control"

      assert_patch(index_live, Routes.disease_control_index_path(conn, :new))

      assert index_live
             |> form("#disease_control-form", disease_control: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#disease_control-form", disease_control: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disease_control_index_path(conn, :index))

      assert html =~ "Disease control created successfully"
      assert html =~ "some nationality"
    end

    test "updates disease_control in listing", %{conn: conn, disease_control: disease_control} do
      {:ok, index_live, _html} = live(conn, Routes.disease_control_index_path(conn, :index))

      assert index_live |> element("#disease_control-#{disease_control.id} a", "Edit") |> render_click() =~
               "Edit Disease control"

      assert_patch(index_live, Routes.disease_control_index_path(conn, :edit, disease_control))

      assert index_live
             |> form("#disease_control-form", disease_control: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#disease_control-form", disease_control: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disease_control_index_path(conn, :index))

      assert html =~ "Disease control updated successfully"
      assert html =~ "some updated nationality"
    end

    test "deletes disease_control in listing", %{conn: conn, disease_control: disease_control} do
      {:ok, index_live, _html} = live(conn, Routes.disease_control_index_path(conn, :index))

      assert index_live |> element("#disease_control-#{disease_control.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#disease_control-#{disease_control.id}")
    end
  end

  describe "Show" do
    setup [:create_disease_control]

    test "displays disease_control", %{conn: conn, disease_control: disease_control} do
      {:ok, _show_live, html} = live(conn, Routes.disease_control_show_path(conn, :show, disease_control))

      assert html =~ "Show Disease control"
      assert html =~ disease_control.nationality
    end

    test "updates disease_control within modal", %{conn: conn, disease_control: disease_control} do
      {:ok, show_live, _html} = live(conn, Routes.disease_control_show_path(conn, :show, disease_control))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Disease control"

      assert_patch(show_live, Routes.disease_control_show_path(conn, :edit, disease_control))

      assert show_live
             |> form("#disease_control-form", disease_control: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#disease_control-form", disease_control: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.disease_control_show_path(conn, :show, disease_control))

      assert html =~ "Disease control updated successfully"
      assert html =~ "some updated nationality"
    end
  end
end
