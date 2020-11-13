defmodule Corea.AccountBooks do
  @moduledoc """
  The AccountBooks context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.AccountBooks.AccountBook

  @doc """
  Returns the list of account_books.

  ## Examples

      iex> list_account_books()
      [%AccountBook{}, ...]

  """
  def list_account_books do
    Repo.all(AccountBook)
  end

  @doc """
  Gets a single account_book.

  Raises `Ecto.NoResultsError` if the Account book does not exist.

  ## Examples

      iex> get_account_book!(123)
      %AccountBook{}

      iex> get_account_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account_book!(id), do: Repo.get!(AccountBook, id)

  @doc """
  Creates a account_book.

  ## Examples

      iex> create_account_book(%{field: value})
      {:ok, %AccountBook{}}

      iex> create_account_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account_book(attrs \\ %{}) do
    %AccountBook{}
    |> AccountBook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account_book.

  ## Examples

      iex> update_account_book(account_book, %{field: new_value})
      {:ok, %AccountBook{}}

      iex> update_account_book(account_book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_book(%AccountBook{} = account_book, attrs) do
    account_book
    |> AccountBook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account_book.

  ## Examples

      iex> delete_account_book(account_book)
      {:ok, %AccountBook{}}

      iex> delete_account_book(account_book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account_book(%AccountBook{} = account_book) do
    Repo.delete(account_book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account_book changes.

  ## Examples

      iex> change_account_book(account_book)
      %Ecto.Changeset{data: %AccountBook{}}

  """
  def change_account_book(%AccountBook{} = account_book, attrs \\ %{}) do
    AccountBook.changeset(account_book, attrs)
  end
end
