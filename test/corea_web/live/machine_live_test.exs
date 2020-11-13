defmodule CoreaWeb.MachineLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Machines

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:machine) do
    {:ok, machine} = Machines.create_machine(@create_attrs)
    machine
  end

  defp create_machine(_) do
    machine = fixture(:machine)
    %{machine: machine}
  end

  describe "Index" do
    setup [:create_machine]

    test "lists all machines", %{conn: conn, machine: machine} do
      {:ok, _index_live, html} = live(conn, Routes.machine_index_path(conn, :index))

      assert html =~ "Listing Machines"
      assert html =~ machine.name
    end

    test "saves new machine", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.machine_index_path(conn, :index))

      assert index_live |> element("a", "New Machine") |> render_click() =~
               "New Machine"

      assert_patch(index_live, Routes.machine_index_path(conn, :new))

      assert index_live
             |> form("#machine-form", machine: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#machine-form", machine: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.machine_index_path(conn, :index))

      assert html =~ "Machine created successfully"
      assert html =~ "some name"
    end

    test "updates machine in listing", %{conn: conn, machine: machine} do
      {:ok, index_live, _html} = live(conn, Routes.machine_index_path(conn, :index))

      assert index_live |> element("#machine-#{machine.id} a", "Edit") |> render_click() =~
               "Edit Machine"

      assert_patch(index_live, Routes.machine_index_path(conn, :edit, machine))

      assert index_live
             |> form("#machine-form", machine: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#machine-form", machine: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.machine_index_path(conn, :index))

      assert html =~ "Machine updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes machine in listing", %{conn: conn, machine: machine} do
      {:ok, index_live, _html} = live(conn, Routes.machine_index_path(conn, :index))

      assert index_live |> element("#machine-#{machine.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#machine-#{machine.id}")
    end
  end

  describe "Show" do
    setup [:create_machine]

    test "displays machine", %{conn: conn, machine: machine} do
      {:ok, _show_live, html} = live(conn, Routes.machine_show_path(conn, :show, machine))

      assert html =~ "Show Machine"
      assert html =~ machine.name
    end

    test "updates machine within modal", %{conn: conn, machine: machine} do
      {:ok, show_live, _html} = live(conn, Routes.machine_show_path(conn, :show, machine))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Machine"

      assert_patch(show_live, Routes.machine_show_path(conn, :edit, machine))

      assert show_live
             |> form("#machine-form", machine: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#machine-form", machine: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.machine_show_path(conn, :show, machine))

      assert html =~ "Machine updated successfully"
      assert html =~ "some updated name"
    end
  end
end
