defmodule Corea.GABAccounts do
  @moduledoc """
  The GABAccounts context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GABAccounts.GABAccount

  @doc """
  Returns the list of gab_accounts.

  ## Examples

      iex> list_gab_accounts()
      [%GABAccount{}, ...]

  """
  def list_gab_accounts do
    Repo.all(GABAccount)
  end

  @doc """
  Gets a single gab_account.

  Raises `Ecto.NoResultsError` if the Gab account does not exist.

  ## Examples

      iex> get_gab_account!(123)
      %GABAccount{}

      iex> get_gab_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gab_account!(id), do: Repo.get!(GABAccount, id)

  @doc """
  Creates a gab_account.

  ## Examples

      iex> create_gab_account(%{field: value})
      {:ok, %GABAccount{}}

      iex> create_gab_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gab_account(attrs \\ %{}) do
    %GABAccount{}
    |> GABAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gab_account.

  ## Examples

      iex> update_gab_account(gab_account, %{field: new_value})
      {:ok, %GABAccount{}}

      iex> update_gab_account(gab_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gab_account(%GABAccount{} = gab_account, attrs) do
    gab_account
    |> GABAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gab_account.

  ## Examples

      iex> delete_gab_account(gab_account)
      {:ok, %GABAccount{}}

      iex> delete_gab_account(gab_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gab_account(%GABAccount{} = gab_account) do
    Repo.delete(gab_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gab_account changes.

  ## Examples

      iex> change_gab_account(gab_account)
      %Ecto.Changeset{data: %GABAccount{}}

  """
  def change_gab_account(%GABAccount{} = gab_account, attrs \\ %{}) do
    GABAccount.changeset(gab_account, attrs)
  end
end
