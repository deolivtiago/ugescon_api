defmodule Api.UserManagement do
  @moduledoc """
  The User Management context
  """
  alias Api.UserManagement.Change
  alias Api.UserManagement.Create
  alias Api.UserManagement.Delete
  alias Api.UserManagement.Get
  alias Api.UserManagement.List
  alias Api.UserManagement.Update

  @doc """
  Returns a list of users

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  defdelegate list_users, to: List, as: :call

  @doc """
  Gets an user

  ## Examples

      iex> get_user(value)
      {:ok, %User{}}

      iex> get_user(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_user(id), to: Get, as: :call

  @doc """
  Creates an user

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_user(attrs \\ %{}), to: Create, as: :call

  @doc """
  Updates an user

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_user(user, attrs), to: Update, as: :call

  @doc """
  Deletes an user

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_user(user), to: Delete, as: :call

  @doc """
  Returns a changeset for tracking user changes

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  defdelegate change_user(user, attrs \\ %{}), to: Change, as: :call
end
