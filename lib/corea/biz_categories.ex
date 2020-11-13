defmodule Corea.BizCategories do
  @moduledoc """
  The BizCategories context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.BizCategories.BizCategory

  @doc """
  Returns the list of biz_categories.

  ## Examples

      iex> list_biz_categories()
      [%BizCategory{}, ...]

  """
  def list_biz_categories do
    Repo.all(BizCategory)
  end

  @doc """
  Gets a single biz_category.

  Raises `Ecto.NoResultsError` if the Biz category does not exist.

  ## Examples

      iex> get_biz_category!(123)
      %BizCategory{}

      iex> get_biz_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_biz_category!(id), do: Repo.get!(BizCategory, id)

  @doc """
  Creates a biz_category.

  ## Examples

      iex> create_biz_category(%{field: value})
      {:ok, %BizCategory{}}

      iex> create_biz_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_biz_category(attrs \\ %{}) do
    %BizCategory{}
    |> BizCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a biz_category.

  ## Examples

      iex> update_biz_category(biz_category, %{field: new_value})
      {:ok, %BizCategory{}}

      iex> update_biz_category(biz_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_biz_category(%BizCategory{} = biz_category, attrs) do
    biz_category
    |> BizCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a biz_category.

  ## Examples

      iex> delete_biz_category(biz_category)
      {:ok, %BizCategory{}}

      iex> delete_biz_category(biz_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_biz_category(%BizCategory{} = biz_category) do
    Repo.delete(biz_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking biz_category changes.

  ## Examples

      iex> change_biz_category(biz_category)
      %Ecto.Changeset{data: %BizCategory{}}

  """
  def change_biz_category(%BizCategory{} = biz_category, attrs \\ %{}) do
    BizCategory.changeset(biz_category, attrs)
  end
end
