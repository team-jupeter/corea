defmodule Corea.PayloadArchives do
  @moduledoc """
  The PayloadArchives context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.PayloadArchives.PayloadArchive

  @doc """
  Returns the list of payload_archives.

  ## Examples

      iex> list_payload_archives()
      [%PayloadArchive{}, ...]

  """
  def list_payload_archives do
    Repo.all(PayloadArchive)
  end

  @doc """
  Gets a single payload_archive.

  Raises `Ecto.NoResultsError` if the Payload archive does not exist.

  ## Examples

      iex> get_payload_archive!(123)
      %PayloadArchive{}

      iex> get_payload_archive!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payload_archive!(id), do: Repo.get!(PayloadArchive, id)

  @doc """
  Creates a payload_archive.

  ## Examples

      iex> create_payload_archive(%{field: value})
      {:ok, %PayloadArchive{}}

      iex> create_payload_archive(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payload_archive(attrs \\ %{}) do
    %PayloadArchive{}
    |> PayloadArchive.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payload_archive.

  ## Examples

      iex> update_payload_archive(payload_archive, %{field: new_value})
      {:ok, %PayloadArchive{}}

      iex> update_payload_archive(payload_archive, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payload_archive(%PayloadArchive{} = payload_archive, attrs) do
    payload_archive
    |> PayloadArchive.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payload_archive.

  ## Examples

      iex> delete_payload_archive(payload_archive)
      {:ok, %PayloadArchive{}}

      iex> delete_payload_archive(payload_archive)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payload_archive(%PayloadArchive{} = payload_archive) do
    Repo.delete(payload_archive)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payload_archive changes.

  ## Examples

      iex> change_payload_archive(payload_archive)
      %Ecto.Changeset{data: %PayloadArchive{}}

  """
  def change_payload_archive(%PayloadArchive{} = payload_archive, attrs \\ %{}) do
    PayloadArchive.changeset(payload_archive, attrs)
  end
end
