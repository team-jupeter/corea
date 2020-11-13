defmodule Corea.ProductAnnotations do
  @moduledoc """
  The ProductAnnotations context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.ProductAnnotations.ProductAnnotation

  @doc """
  Returns the list of product_annotations.

  ## Examples

      iex> list_product_annotations()
      [%ProductAnnotation{}, ...]

  """
  def list_product_annotations do
    Repo.all(ProductAnnotation)
  end

  @doc """
  Gets a single product_annotation.

  Raises `Ecto.NoResultsError` if the Product annotation does not exist.

  ## Examples

      iex> get_product_annotation!(123)
      %ProductAnnotation{}

      iex> get_product_annotation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_annotation!(id), do: Repo.get!(ProductAnnotation, id)

  @doc """
  Creates a product_annotation.

  ## Examples

      iex> create_product_annotation(%{field: value})
      {:ok, %ProductAnnotation{}}

      iex> create_product_annotation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_annotation(attrs \\ %{}) do
    %ProductAnnotation{}
    |> ProductAnnotation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_annotation.

  ## Examples

      iex> update_product_annotation(product_annotation, %{field: new_value})
      {:ok, %ProductAnnotation{}}

      iex> update_product_annotation(product_annotation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_annotation(%ProductAnnotation{} = product_annotation, attrs) do
    product_annotation
    |> ProductAnnotation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_annotation.

  ## Examples

      iex> delete_product_annotation(product_annotation)
      {:ok, %ProductAnnotation{}}

      iex> delete_product_annotation(product_annotation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_annotation(%ProductAnnotation{} = product_annotation) do
    Repo.delete(product_annotation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_annotation changes.

  ## Examples

      iex> change_product_annotation(product_annotation)
      %Ecto.Changeset{data: %ProductAnnotation{}}

  """
  def change_product_annotation(%ProductAnnotation{} = product_annotation, attrs \\ %{}) do
    ProductAnnotation.changeset(product_annotation, attrs)
  end
end
