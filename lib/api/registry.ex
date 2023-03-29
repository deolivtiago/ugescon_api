defmodule Api.Registry do
  @moduledoc """
  The Registry context
  """
  alias Api.Registry.Address
  alias Api.Registry.Person

  @doc """
  Returns a list of persons

  ## Examples

      iex> list_persons()
      [%Person{}, ...]

  """
  defdelegate list_persons, to: Person.List, as: :call

  @doc """
  Gets a person

  ## Examples

      iex> get_person(value)
      {:ok, %Person{}}

      iex> get_person(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_person(id), to: Person.Get, as: :call

  @doc """
  Creates a person

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_person(attrs \\ %{}), to: Person.Create, as: :call

  @doc """
  Updates a person

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_person(person, attrs), to: Person.Update, as: :call

  @doc """
  Deletes a person

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_person(person), to: Person.Delete, as: :call

  @doc """
  Returns a changeset for tracking person changes

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{data: %Person{}}

  """
  defdelegate change_person(person, attrs \\ %{}), to: Person.Change, as: :call

  @doc """
  Returns a list of addresses

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """
  defdelegate list_addresses, to: Address.List, as: :call

  @doc """
  Returns a list of addresses filtered by person id

  ## Examples

      iex> list_addresses(person_id: person_id)`
      [%Address{}, ...]

  """
  defdelegate list_addresses(filter), to: Address.List, as: :call

  @doc """
  Gets a address

  ## Examples

      iex> get_address(value)
      {:ok, %Address{}}

      iex> get_address(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_address(id), to: Address.Get, as: :call

  @doc """
  Creates a address

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_address(attrs \\ %{}), to: Address.Create, as: :call

  @doc """
  Updates a address

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_address(address, attrs), to: Address.Update, as: :call

  @doc """
  Deletes a address

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_address(address), to: Address.Delete, as: :call

  @doc """
  Returns a changeset for tracking address changes

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{data: %Address{}}

  """
  defdelegate change_address(address, attrs \\ %{}), to: Address.Change, as: :call
end
