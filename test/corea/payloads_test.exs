defmodule Corea.PayloadsTest do
  use Corea.DataCase

  alias Corea.Payloads

  describe "payloads" do
    alias Corea.Payloads.Payload

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def payload_fixture(attrs \\ %{}) do
      {:ok, payload} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Payloads.create_payload()

      payload
    end

    test "list_payloads/0 returns all payloads" do
      payload = payload_fixture()
      assert Payloads.list_payloads() == [payload]
    end

    test "get_payload!/1 returns the payload with given id" do
      payload = payload_fixture()
      assert Payloads.get_payload!(payload.id) == payload
    end

    test "create_payload/1 with valid data creates a payload" do
      assert {:ok, %Payload{} = payload} = Payloads.create_payload(@valid_attrs)
      assert payload.title == "some title"
    end

    test "create_payload/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payloads.create_payload(@invalid_attrs)
    end

    test "update_payload/2 with valid data updates the payload" do
      payload = payload_fixture()
      assert {:ok, %Payload{} = payload} = Payloads.update_payload(payload, @update_attrs)
      assert payload.title == "some updated title"
    end

    test "update_payload/2 with invalid data returns error changeset" do
      payload = payload_fixture()
      assert {:error, %Ecto.Changeset{}} = Payloads.update_payload(payload, @invalid_attrs)
      assert payload == Payloads.get_payload!(payload.id)
    end

    test "delete_payload/1 deletes the payload" do
      payload = payload_fixture()
      assert {:ok, %Payload{}} = Payloads.delete_payload(payload)
      assert_raise Ecto.NoResultsError, fn -> Payloads.get_payload!(payload.id) end
    end

    test "change_payload/1 returns a payload changeset" do
      payload = payload_fixture()
      assert %Ecto.Changeset{} = Payloads.change_payload(payload)
    end
  end
end
