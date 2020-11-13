defmodule Corea.PatentApplications do
  @moduledoc """
  The PatentApplications context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.PatentApplications.PatentApplication

  @doc """
  Returns the list of patent_applications.

  ## Examples

      iex> list_patent_applications()
      [%PatentApplication{}, ...]

  """
  def list_patent_applications do
    Repo.all(PatentApplication)
  end

  @doc """
  Gets a single patent_application.

  Raises `Ecto.NoResultsError` if the Patent application does not exist.

  ## Examples

      iex> get_patent_application!(123)
      %PatentApplication{}

      iex> get_patent_application!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patent_application!(id), do: Repo.get!(PatentApplication, id)

  @doc """
  Creates a patent_application.

  ## Examples

      iex> create_patent_application(%{field: value})
      {:ok, %PatentApplication{}}

      iex> create_patent_application(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patent_application(attrs \\ %{}) do
    %PatentApplication{}
    |> PatentApplication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patent_application.

  ## Examples

      iex> update_patent_application(patent_application, %{field: new_value})
      {:ok, %PatentApplication{}}

      iex> update_patent_application(patent_application, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patent_application(%PatentApplication{} = patent_application, attrs) do
    patent_application
    |> PatentApplication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patent_application.

  ## Examples

      iex> delete_patent_application(patent_application)
      {:ok, %PatentApplication{}}

      iex> delete_patent_application(patent_application)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patent_application(%PatentApplication{} = patent_application) do
    Repo.delete(patent_application)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patent_application changes.

  ## Examples

      iex> change_patent_application(patent_application)
      %Ecto.Changeset{data: %PatentApplication{}}

  """
  def change_patent_application(%PatentApplication{} = patent_application, attrs \\ %{}) do
    PatentApplication.changeset(patent_application, attrs)
  end
end
