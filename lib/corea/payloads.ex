defmodule Corea.Payloads do
  @moduledoc """
  The Payloads context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Payloads.Payload

  @doc """
  Returns the list of payloads.

  ## Examples

      iex> list_payloads()
      [%Payload{}, ...]

  """
  def list_payloads do
    Repo.all(Payload)
  end

  @doc """
  Gets a single payload.

  Raises `Ecto.NoResultsError` if the Payload does not exist.

  ## Examples

      iex> get_payload!(123)
      %Payload{}

      iex> get_payload!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payload!(id), do: Repo.get!(Payload, id)

  @doc """
  Creates a payload.

  ## Examples

      iex> create_payload(%{field: value})
      {:ok, %Payload{}}

      iex> create_payload(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payload(attrs \\ %{}) do
    %Payload{}
    |> Payload.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payload.

  ## Examples

      iex> update_payload(payload, %{field: new_value})
      {:ok, %Payload{}}

      iex> update_payload(payload, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payload(%Payload{} = payload, attrs) do
    payload
    |> Payload.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payload.

  ## Examples

      iex> delete_payload(payload)
      {:ok, %Payload{}}

      iex> delete_payload(payload)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payload(%Payload{} = payload) do
    Repo.delete(payload)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payload changes.

  ## Examples

      iex> change_payload(payload)
      %Ecto.Changeset{data: %Payload{}}

  """
  def change_payload(%Payload{} = payload, attrs \\ %{}) do
    Payload.changeset(payload, attrs)
  end
end
