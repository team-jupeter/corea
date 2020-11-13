defmodule Corea.GovBalanceSheets do
  @moduledoc """
  The GovBalanceSheets context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GovBalanceSheets.GovBalanceSheet

  @doc """
  Returns the list of gov_balance_sheets.

  ## Examples

      iex> list_gov_balance_sheets()
      [%GovBalanceSheet{}, ...]

  """
  def list_gov_balance_sheets do
    Repo.all(GovBalanceSheet)
  end

  @doc """
  Gets a single gov_balance_sheet.

  Raises `Ecto.NoResultsError` if the Gov balance sheet does not exist.

  ## Examples

      iex> get_gov_balance_sheet!(123)
      %GovBalanceSheet{}

      iex> get_gov_balance_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gov_balance_sheet!(id), do: Repo.get!(GovBalanceSheet, id)

  @doc """
  Creates a gov_balance_sheet.

  ## Examples

      iex> create_gov_balance_sheet(%{field: value})
      {:ok, %GovBalanceSheet{}}

      iex> create_gov_balance_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gov_balance_sheet(attrs \\ %{}) do
    %GovBalanceSheet{}
    |> GovBalanceSheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gov_balance_sheet.

  ## Examples

      iex> update_gov_balance_sheet(gov_balance_sheet, %{field: new_value})
      {:ok, %GovBalanceSheet{}}

      iex> update_gov_balance_sheet(gov_balance_sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gov_balance_sheet(%GovBalanceSheet{} = gov_balance_sheet, attrs) do
    gov_balance_sheet
    |> GovBalanceSheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gov_balance_sheet.

  ## Examples

      iex> delete_gov_balance_sheet(gov_balance_sheet)
      {:ok, %GovBalanceSheet{}}

      iex> delete_gov_balance_sheet(gov_balance_sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gov_balance_sheet(%GovBalanceSheet{} = gov_balance_sheet) do
    Repo.delete(gov_balance_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gov_balance_sheet changes.

  ## Examples

      iex> change_gov_balance_sheet(gov_balance_sheet)
      %Ecto.Changeset{data: %GovBalanceSheet{}}

  """
  def change_gov_balance_sheet(%GovBalanceSheet{} = gov_balance_sheet, attrs \\ %{}) do
    GovBalanceSheet.changeset(gov_balance_sheet, attrs)
  end
end
