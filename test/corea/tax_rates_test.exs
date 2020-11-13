defmodule Corea.TaxRatesTest do
  use Corea.DataCase

  alias Corea.TaxRates

  describe "tax_rates" do
    alias Corea.TaxRates.TaxRate

    @valid_attrs %{gpc_code: "some gpc_code"}
    @update_attrs %{gpc_code: "some updated gpc_code"}
    @invalid_attrs %{gpc_code: nil}

    def tax_rate_fixture(attrs \\ %{}) do
      {:ok, tax_rate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaxRates.create_tax_rate()

      tax_rate
    end

    test "list_tax_rates/0 returns all tax_rates" do
      tax_rate = tax_rate_fixture()
      assert TaxRates.list_tax_rates() == [tax_rate]
    end

    test "get_tax_rate!/1 returns the tax_rate with given id" do
      tax_rate = tax_rate_fixture()
      assert TaxRates.get_tax_rate!(tax_rate.id) == tax_rate
    end

    test "create_tax_rate/1 with valid data creates a tax_rate" do
      assert {:ok, %TaxRate{} = tax_rate} = TaxRates.create_tax_rate(@valid_attrs)
      assert tax_rate.gpc_code == "some gpc_code"
    end

    test "create_tax_rate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaxRates.create_tax_rate(@invalid_attrs)
    end

    test "update_tax_rate/2 with valid data updates the tax_rate" do
      tax_rate = tax_rate_fixture()
      assert {:ok, %TaxRate{} = tax_rate} = TaxRates.update_tax_rate(tax_rate, @update_attrs)
      assert tax_rate.gpc_code == "some updated gpc_code"
    end

    test "update_tax_rate/2 with invalid data returns error changeset" do
      tax_rate = tax_rate_fixture()
      assert {:error, %Ecto.Changeset{}} = TaxRates.update_tax_rate(tax_rate, @invalid_attrs)
      assert tax_rate == TaxRates.get_tax_rate!(tax_rate.id)
    end

    test "delete_tax_rate/1 deletes the tax_rate" do
      tax_rate = tax_rate_fixture()
      assert {:ok, %TaxRate{}} = TaxRates.delete_tax_rate(tax_rate)
      assert_raise Ecto.NoResultsError, fn -> TaxRates.get_tax_rate!(tax_rate.id) end
    end

    test "change_tax_rate/1 returns a tax_rate changeset" do
      tax_rate = tax_rate_fixture()
      assert %Ecto.Changeset{} = TaxRates.change_tax_rate(tax_rate)
    end
  end
end
