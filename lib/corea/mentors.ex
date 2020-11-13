defmodule Corea.Mentors do
  @moduledoc """
  The Mentors context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Mentors.Mentor

  @doc """
  Returns the list of mentors.

  ## Examples

      iex> list_mentors()
      [%Mentor{}, ...]

  """
  def list_mentors do
    Repo.all(Mentor)
  end

  @doc """
  Gets a single mentor.

  Raises `Ecto.NoResultsError` if the Mentor does not exist.

  ## Examples

      iex> get_mentor!(123)
      %Mentor{}

      iex> get_mentor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mentor!(id), do: Repo.get!(Mentor, id)

  @doc """
  Creates a mentor.

  ## Examples

      iex> create_mentor(%{field: value})
      {:ok, %Mentor{}}

      iex> create_mentor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mentor(attrs \\ %{}) do
    %Mentor{}
    |> Mentor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mentor.

  ## Examples

      iex> update_mentor(mentor, %{field: new_value})
      {:ok, %Mentor{}}

      iex> update_mentor(mentor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mentor(%Mentor{} = mentor, attrs) do
    mentor
    |> Mentor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mentor.

  ## Examples

      iex> delete_mentor(mentor)
      {:ok, %Mentor{}}

      iex> delete_mentor(mentor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mentor(%Mentor{} = mentor) do
    Repo.delete(mentor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mentor changes.

  ## Examples

      iex> change_mentor(mentor)
      %Ecto.Changeset{data: %Mentor{}}

  """
  def change_mentor(%Mentor{} = mentor, attrs \\ %{}) do
    Mentor.changeset(mentor, attrs)
  end
end
