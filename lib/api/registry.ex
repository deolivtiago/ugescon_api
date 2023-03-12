defmodule Api.Registry do
  @moduledoc """
  The Registry context
  """
  alias Api.Registry.Change
  alias Api.Registry.Create
  alias Api.Registry.Delete
  alias Api.Registry.Get
  alias Api.Registry.List
  alias Api.Registry.Update

  @doc """
  Returns a list of persons

  ## Examples

      iex> list_persons()
      [%User{}, ...]

  """
  defdelegate list_persons, to: List, as: :call

  @doc """
  Gets a person

  ## Examples

      iex> get_person(value)
      {:ok, %User{}}

      iex> get_person(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_person(id), to: Get, as: :call

  @doc """
  Creates a person

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %User{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_person(attrs \\ %{}), to: Create, as: :call

  @doc """
  Updates a person

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %User{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_person(person, attrs), to: Update, as: :call

  @doc """
  Deletes a person

  ## Examples

      iex> delete_person(person)
      {:ok, %User{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_person(person), to: Delete, as: :call

  @doc """
  Returns a changeset for tracking person changes

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{data: %User{}}

  """
  defdelegate change_person(person, attrs \\ %{}), to: Change, as: :call
end
