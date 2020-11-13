defmodule Corea.InvoiceItems do
  @moduledoc """
  The InvoiceItems context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.InvoiceItems.InvoiceItem

  @doc """
  Returns the list of invoice_items.

  ## Examples

      iex> list_invoice_items()
      [%InvoiceItem{}, ...]

  """
  def list_invoice_items do
    Repo.all(InvoiceItem)
  end

  @doc """
  Gets a single invoice_item.

  Raises `Ecto.NoResultsError` if the Invoice item does not exist.

  ## Examples

      iex> get_invoice_item!(123)
      %InvoiceItem{}

      iex> get_invoice_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invoice_item!(id), do: Repo.get!(InvoiceItem, id)

  @doc """
  Creates a invoice_item.

  ## Examples

      iex> create_invoice_item(%{field: value})
      {:ok, %InvoiceItem{}}

      iex> create_invoice_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invoice_item(attrs \\ %{}) do
    %InvoiceItem{}
    |> InvoiceItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice_item.

  ## Examples

      iex> update_invoice_item(invoice_item, %{field: new_value})
      {:ok, %InvoiceItem{}}

      iex> update_invoice_item(invoice_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invoice_item(%InvoiceItem{} = invoice_item, attrs) do
    invoice_item
    |> InvoiceItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invoice_item.

  ## Examples

      iex> delete_invoice_item(invoice_item)
      {:ok, %InvoiceItem{}}

      iex> delete_invoice_item(invoice_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invoice_item(%InvoiceItem{} = invoice_item) do
    Repo.delete(invoice_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice_item changes.

  ## Examples

      iex> change_invoice_item(invoice_item)
      %Ecto.Changeset{data: %InvoiceItem{}}

  """
  def change_invoice_item(%InvoiceItem{} = invoice_item, attrs \\ %{}) do
    InvoiceItem.changeset(invoice_item, attrs)
  end
end
