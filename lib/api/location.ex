defmodule Api.Location do
  @moduledoc """
  The Location context
  """
  alias Api.Location.Change
  alias Api.Location.Create
  alias Api.Location.Delete
  alias Api.Location.Get
  alias Api.Location.List
  alias Api.Location.Update

  @doc """
  Returns a list of countries

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  defdelegate list_countries, to: List, as: :call

  @doc """
  Gets a country

  ## Examples

      iex> get_country(value)
      {:ok, %Country{}}

      iex> get_country(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_country(id), to: Get, as: :call

  @doc """
  Creates a country

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_country(attrs \\ %{}), to: Create, as: :call

  @doc """
  Updates a country

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_country(country, attrs), to: Update, as: :call

  @doc """
  Deletes a country

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_country(country), to: Delete, as: :call

  @doc """
  Returns a changeset for tracking country changes

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  defdelegate change_country(country, attrs \\ %{}), to: Change, as: :call
end
