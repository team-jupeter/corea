defmodule Corea.MetabolicPanels do
  @moduledoc """
  The MetabolicPanels context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.MetabolicPanels.MetabolicPanel

  @doc """
  Returns the list of metabolic_panels.

  ## Examples

      iex> list_metabolic_panels()
      [%MetabolicPanel{}, ...]

  """
  def list_metabolic_panels do
    Repo.all(MetabolicPanel)
  end

  @doc """
  Gets a single metabolic_panel.

  Raises `Ecto.NoResultsError` if the Metabolic panel does not exist.

  ## Examples

      iex> get_metabolic_panel!(123)
      %MetabolicPanel{}

      iex> get_metabolic_panel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_metabolic_panel!(id), do: Repo.get!(MetabolicPanel, id)

  @doc """
  Creates a metabolic_panel.

  ## Examples

      iex> create_metabolic_panel(%{field: value})
      {:ok, %MetabolicPanel{}}

      iex> create_metabolic_panel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_metabolic_panel(attrs \\ %{}) do
    %MetabolicPanel{}
    |> MetabolicPanel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a metabolic_panel.

  ## Examples

      iex> update_metabolic_panel(metabolic_panel, %{field: new_value})
      {:ok, %MetabolicPanel{}}

      iex> update_metabolic_panel(metabolic_panel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_metabolic_panel(%MetabolicPanel{} = metabolic_panel, attrs) do
    metabolic_panel
    |> MetabolicPanel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a metabolic_panel.

  ## Examples

      iex> delete_metabolic_panel(metabolic_panel)
      {:ok, %MetabolicPanel{}}

      iex> delete_metabolic_panel(metabolic_panel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_metabolic_panel(%MetabolicPanel{} = metabolic_panel) do
    Repo.delete(metabolic_panel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking metabolic_panel changes.

  ## Examples

      iex> change_metabolic_panel(metabolic_panel)
      %Ecto.Changeset{data: %MetabolicPanel{}}

  """
  def change_metabolic_panel(%MetabolicPanel{} = metabolic_panel, attrs \\ %{}) do
    MetabolicPanel.changeset(metabolic_panel, attrs)
  end
end
