defmodule Corea.Deposits do
  @moduledoc """
  The Deposits context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Deposits.Deposit

  @doc """
  Returns the list of deposits.

  ## Examples

      iex> list_deposits()
      [%Deposit{}, ...]

  """
  def list_deposits do
    Repo.all(Deposit)
  end

  @doc """
  Gets a single deposit.

  Raises `Ecto.NoResultsError` if the Deposit does not exist.

  ## Examples

      iex> get_deposit!(123)
      %Deposit{}

      iex> get_deposit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deposit!(id), do: Repo.get!(Deposit, id)

  @doc """
  Creates a deposit.

  ## Examples

      iex> create_deposit(%{field: value})
      {:ok, %Deposit{}}

      iex> create_deposit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deposit(attrs \\ %{}) do
    %Deposit{}
    |> Deposit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deposit.

  ## Examples

      iex> update_deposit(deposit, %{field: new_value})
      {:ok, %Deposit{}}

      iex> update_deposit(deposit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deposit(%Deposit{} = deposit, attrs) do
    deposit
    |> Deposit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deposit.

  ## Examples

      iex> delete_deposit(deposit)
      {:ok, %Deposit{}}

      iex> delete_deposit(deposit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deposit(%Deposit{} = deposit) do
    Repo.delete(deposit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deposit changes.

  ## Examples

      iex> change_deposit(deposit)
      %Ecto.Changeset{data: %Deposit{}}

  """
  def change_deposit(%Deposit{} = deposit, attrs \\ %{}) do
    Deposit.changeset(deposit, attrs)
  end
end
