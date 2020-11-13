defmodule CoreaWeb.EntityLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Entities

  @create_attrs %{name: "some name", type: "some type"}
  @update_attrs %{name: "some updated name", type: "some updated type"}
  @invalid_attrs %{name: nil, type: nil}

  defp fixture(:entity) do
    {:ok, entity} = Entities.create_entity(@create_attrs)
    entity
  end

  defp create_entity(_) do
    entity = fixture(:entity)
    %{entity: entity}
  end

  describe "Index" do
    setup [:create_entity]

    test "lists all entities", %{conn: conn, entity: entity} do
      {:ok, _index_live, html} = live(conn, Routes.entity_index_path(conn, :index))

      assert html =~ "Listing Entities"
      assert html =~ entity.name
    end

    test "saves new entity", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.entity_index_path(conn, :index))

      assert index_live |> element("a", "New Entity") |> render_click() =~
               "New Entity"

      assert_patch(index_live, Routes.entity_index_path(conn, :new))

      assert index_live
             |> form("#entity-form", entity: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#entity-form", entity: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.entity_index_path(conn, :index))

      assert html =~ "Entity created successfully"
      assert html =~ "some name"
    end

    test "updates entity in listing", %{conn: conn, entity: entity} do
      {:ok, index_live, _html} = live(conn, Routes.entity_index_path(conn, :index))

      assert index_live |> element("#entity-#{entity.id} a", "Edit") |> render_click() =~
               "Edit Entity"

      assert_patch(index_live, Routes.entity_index_path(conn, :edit, entity))

      assert index_live
             |> form("#entity-form", entity: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#entity-form", entity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.entity_index_path(conn, :index))

      assert html =~ "Entity updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes entity in listing", %{conn: conn, entity: entity} do
      {:ok, index_live, _html} = live(conn, Routes.entity_index_path(conn, :index))

      assert index_live |> element("#entity-#{entity.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#entity-#{entity.id}")
    end
  end

  describe "Show" do
    setup [:create_entity]

    test "displays entity", %{conn: conn, entity: entity} do
      {:ok, _show_live, html} = live(conn, Routes.entity_show_path(conn, :show, entity))

      assert html =~ "Show Entity"
      assert html =~ entity.name
    end

    test "updates entity within modal", %{conn: conn, entity: entity} do
      {:ok, show_live, _html} = live(conn, Routes.entity_show_path(conn, :show, entity))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Entity"

      assert_patch(show_live, Routes.entity_show_path(conn, :edit, entity))

      assert show_live
             |> form("#entity-form", entity: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#entity-form", entity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.entity_show_path(conn, :show, entity))

      assert html =~ "Entity updated successfully"
      assert html =~ "some updated name"
    end
  end
end
