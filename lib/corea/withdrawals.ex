defmodule Corea.Withdrawals do
  @moduledoc """
  The Withdrawals context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Withdrawals.Withdrawal

  @doc """
  Returns the list of withdrawals.

  ## Examples

      iex> list_withdrawals()
      [%Withdrawal{}, ...]

  """
  def list_withdrawals do
    Repo.all(Withdrawal)
  end

  @doc """
  Gets a single withdrawal.

  Raises `Ecto.NoResultsError` if the Withdrawal does not exist.

  ## Examples

      iex> get_withdrawal!(123)
      %Withdrawal{}

      iex> get_withdrawal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_withdrawal!(id), do: Repo.get!(Withdrawal, id)

  @doc """
  Creates a withdrawal.

  ## Examples

      iex> create_withdrawal(%{field: value})
      {:ok, %Withdrawal{}}

      iex> create_withdrawal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_withdrawal(attrs \\ %{}) do
    %Withdrawal{}
    |> Withdrawal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a withdrawal.

  ## Examples

      iex> update_withdrawal(withdrawal, %{field: new_value})
      {:ok, %Withdrawal{}}

      iex> update_withdrawal(withdrawal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_withdrawal(%Withdrawal{} = withdrawal, attrs) do
    withdrawal
    |> Withdrawal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a withdrawal.

  ## Examples

      iex> delete_withdrawal(withdrawal)
      {:ok, %Withdrawal{}}

      iex> delete_withdrawal(withdrawal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_withdrawal(%Withdrawal{} = withdrawal) do
    Repo.delete(withdrawal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking withdrawal changes.

  ## Examples

      iex> change_withdrawal(withdrawal)
      %Ecto.Changeset{data: %Withdrawal{}}

  """
  def change_withdrawal(%Withdrawal{} = withdrawal, attrs \\ %{}) do
    Withdrawal.changeset(withdrawal, attrs)
  end
end
