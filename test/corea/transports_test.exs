defmodule Corea.TransportsTest do
  use Corea.DataCase

  alias Corea.Transports

  describe "transports" do
    alias Corea.Transports.Transport

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def transport_fixture(attrs \\ %{}) do
      {:ok, transport} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transports.create_transport()

      transport
    end

    test "list_transports/0 returns all transports" do
      transport = transport_fixture()
      assert Transports.list_transports() == [transport]
    end

    test "get_transport!/1 returns the transport with given id" do
      transport = transport_fixture()
      assert Transports.get_transport!(transport.id) == transport
    end

    test "create_transport/1 with valid data creates a transport" do
      assert {:ok, %Transport{} = transport} = Transports.create_transport(@valid_attrs)
      assert transport.type == "some type"
    end

    test "create_transport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transports.create_transport(@invalid_attrs)
    end

    test "update_transport/2 with valid data updates the transport" do
      transport = transport_fixture()
      assert {:ok, %Transport{} = transport} = Transports.update_transport(transport, @update_attrs)
      assert transport.type == "some updated type"
    end

    test "update_transport/2 with invalid data returns error changeset" do
      transport = transport_fixture()
      assert {:error, %Ecto.Changeset{}} = Transports.update_transport(transport, @invalid_attrs)
      assert transport == Transports.get_transport!(transport.id)
    end

    test "delete_transport/1 deletes the transport" do
      transport = transport_fixture()
      assert {:ok, %Transport{}} = Transports.delete_transport(transport)
      assert_raise Ecto.NoResultsError, fn -> Transports.get_transport!(transport.id) end
    end

    test "change_transport/1 returns a transport changeset" do
      transport = transport_fixture()
      assert %Ecto.Changeset{} = Transports.change_transport(transport)
    end
  end
end
