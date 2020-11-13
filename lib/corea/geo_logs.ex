defmodule Corea.GeoLogs do
  @moduledoc """
  The GeoLogs context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GeoLogs.GeoLog

  @doc """
  Returns the list of geo_logs.

  ## Examples

      iex> list_geo_logs()
      [%GeoLog{}, ...]

  """
  def list_geo_logs do
    Repo.all(GeoLog)
  end

  @doc """
  Gets a single geo_log.

  Raises `Ecto.NoResultsError` if the Geo log does not exist.

  ## Examples

      iex> get_geo_log!(123)
      %GeoLog{}

      iex> get_geo_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_geo_log!(id), do: Repo.get!(GeoLog, id)

  @doc """
  Creates a geo_log.

  ## Examples

      iex> create_geo_log(%{field: value})
      {:ok, %GeoLog{}}

      iex> create_geo_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_geo_log(attrs \\ %{}) do
    %GeoLog{}
    |> GeoLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a geo_log.

  ## Examples

      iex> update_geo_log(geo_log, %{field: new_value})
      {:ok, %GeoLog{}}

      iex> update_geo_log(geo_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_geo_log(%GeoLog{} = geo_log, attrs) do
    geo_log
    |> GeoLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a geo_log.

  ## Examples

      iex> delete_geo_log(geo_log)
      {:ok, %GeoLog{}}

      iex> delete_geo_log(geo_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_geo_log(%GeoLog{} = geo_log) do
    Repo.delete(geo_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking geo_log changes.

  ## Examples

      iex> change_geo_log(geo_log)
      %Ecto.Changeset{data: %GeoLog{}}

  """
  def change_geo_log(%GeoLog{} = geo_log, attrs \\ %{}) do
    GeoLog.changeset(geo_log, attrs)
  end
end
