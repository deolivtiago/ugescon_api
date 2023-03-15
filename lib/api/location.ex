defmodule Api.Location do
  @moduledoc """
  The Location context
  """
  alias Api.Location.City
  alias Api.Location.Country
  alias Api.Location.State

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

  @doc """
  Returns a list of states

  ## Examples

      iex> list_states()
      [%State{}, ...]

  """
  defdelegate list_states, to: State.List, as: :call

  @doc """
  Returns a list of states filtered by country id

  ## Examples

      iex> list_states(country_id: country_id)
      [%State{}, ...]

  """
  defdelegate list_states(filter), to: State.List, as: :call

  @doc """
  Gets a state

  ## Examples

      iex> get_state(value)
      {:ok, %State{}}

      iex> get_state(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_state(id), to: State.Get, as: :call

  @doc """
  Creates a state

  ## Examples

      iex> create_state(%{field: value})
      {:ok, %State{}}

      iex> create_state(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_state(attrs \\ %{}), to: State.Create, as: :call

  @doc """
  Updates a state

  ## Examples

      iex> update_state(state, %{field: new_value})
      {:ok, %State{}}

      iex> update_state(state, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_state(state, attrs), to: State.Update, as: :call

  @doc """
  Deletes a state

  ## Examples

      iex> delete_state(state)
      {:ok, %State{}}

      iex> delete_state(state)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_state(state), to: State.Delete, as: :call

  @doc """
  Returns a changeset for tracking state changes

  ## Examples

      iex> change_state(state)
      %Ecto.Changeset{data: %State{}}

  """
  defdelegate change_state(state, attrs \\ %{}), to: State.Change, as: :call

  @doc """
  Returns a list of cities

  ## Examples

      iex> list_cities()
      [%City{}, ...]

  """
  defdelegate list_cities, to: City.List, as: :call

  @doc """
  Returns a list of cities filtered by state id

  ## Examples

      iex> list_cities(state_id: state_id)
      [%State{}, ...]

  """
  defdelegate list_cities(filter), to: City.List, as: :call

  @doc """
  Gets a city

  ## Examples

      iex> get_city(value)
      {:ok, %City{}}

      iex> get_city(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_city(id), to: City.Get, as: :call

  @doc """
  Creates a city

  ## Examples

      iex> create_city(%{field: value})
      {:ok, %City{}}

      iex> create_city(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_city(attrs \\ %{}), to: City.Create, as: :call

  @doc """
  Updates a city

  ## Examples

      iex> update_city(city, %{field: new_value})
      {:ok, %City{}}

      iex> update_city(city, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_city(city, attrs), to: City.Update, as: :call

  @doc """
  Deletes a city

  ## Examples

      iex> delete_city(city)
      {:ok, %City{}}

      iex> delete_city(city)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_city(city), to: City.Delete, as: :call

  @doc """
  Returns a changeset for tracking city changes

  ## Examples

      iex> change_city(city)
      %Ecto.Changeset{data: %City{}}

  """
  defdelegate change_city(city, attrs \\ %{}), to: City.Change, as: :call
end
