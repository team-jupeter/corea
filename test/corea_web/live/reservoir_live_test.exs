defmodule CoreaWeb.ReservoirLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Reservoirs

  @create_attrs %{abc_t1: "120.5"}
  @update_attrs %{abc_t1: "456.7"}
  @invalid_attrs %{abc_t1: nil}

  defp fixture(:reservoir) do
    {:ok, reservoir} = Reservoirs.create_reservoir(@create_attrs)
    reservoir
  end

  defp create_reservoir(_) do
    reservoir = fixture(:reservoir)
    %{reservoir: reservoir}
  end

  describe "Index" do
    setup [:create_reservoir]

    test "lists all reservoirs", %{conn: conn, reservoir: reservoir} do
      {:ok, _index_live, html} = live(conn, Routes.reservoir_index_path(conn, :index))

      assert html =~ "Listing Reservoirs"
    end

    test "saves new reservoir", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.reservoir_index_path(conn, :index))

      assert index_live |> element("a", "New Reservoir") |> render_click() =~
               "New Reservoir"

      assert_patch(index_live, Routes.reservoir_index_path(conn, :new))

      assert index_live
             |> form("#reservoir-form", reservoir: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#reservoir-form", reservoir: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.reservoir_index_path(conn, :index))

      assert html =~ "Reservoir created successfully"
    end

    test "updates reservoir in listing", %{conn: conn, reservoir: reservoir} do
      {:ok, index_live, _html} = live(conn, Routes.reservoir_index_path(conn, :index))

      assert index_live |> element("#reservoir-#{reservoir.id} a", "Edit") |> render_click() =~
               "Edit Reservoir"

      assert_patch(index_live, Routes.reservoir_index_path(conn, :edit, reservoir))

      assert index_live
             |> form("#reservoir-form", reservoir: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#reservoir-form", reservoir: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.reservoir_index_path(conn, :index))

      assert html =~ "Reservoir updated successfully"
    end

    test "deletes reservoir in listing", %{conn: conn, reservoir: reservoir} do
      {:ok, index_live, _html} = live(conn, Routes.reservoir_index_path(conn, :index))

      assert index_live |> element("#reservoir-#{reservoir.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#reservoir-#{reservoir.id}")
    end
  end

  describe "Show" do
    setup [:create_reservoir]

    test "displays reservoir", %{conn: conn, reservoir: reservoir} do
      {:ok, _show_live, html} = live(conn, Routes.reservoir_show_path(conn, :show, reservoir))

      assert html =~ "Show Reservoir"
    end

    test "updates reservoir within modal", %{conn: conn, reservoir: reservoir} do
      {:ok, show_live, _html} = live(conn, Routes.reservoir_show_path(conn, :show, reservoir))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Reservoir"

      assert_patch(show_live, Routes.reservoir_show_path(conn, :edit, reservoir))

      assert show_live
             |> form("#reservoir-form", reservoir: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#reservoir-form", reservoir: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.reservoir_show_path(conn, :show, reservoir))

      assert html =~ "Reservoir updated successfully"
    end
  end
end
