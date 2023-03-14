defmodule Api.Location do
  @moduledoc """
  The Location context
  """
  alias Api.Location.Country

  @doc """
  Returns a list of countries

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  defdelegate list_countries, to: Country.List, as: :call

  @doc """
  Gets a country

  ## Examples

      iex> get_country(value)
      {:ok, %Country{}}

      iex> get_country(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_country(id), to: Country.Get, as: :call

  @doc """
  Creates a country

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_country(attrs \\ %{}), to: Country.Create, as: :call

  @doc """
  Updates a country

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_country(country, attrs), to: Country.Update, as: :call

  @doc """
  Deletes a country

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_country(country), to: Country.Delete, as: :call

  @doc """
  Returns a changeset for tracking country changes

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  defdelegate change_country(country, attrs \\ %{}), to: Country.Change, as: :call
end
