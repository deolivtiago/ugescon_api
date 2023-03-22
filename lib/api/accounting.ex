defmodule Api.Accounting do
  @moduledoc """
  The Accounting context
  """
  alias Api.Accounting.Account

  @doc """
  Returns a list of accounts

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  defdelegate list_accounts, to: Account.List, as: :call

  @doc """
  Gets a account

  ## Examples

      iex> get_account(value)
      {:ok, %Account{}}

      iex> get_account(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_account(id), to: Account.Get, as: :call

  @doc """
  Creates a account

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_account(attrs \\ %{}), to: Account.Create, as: :call

  @doc """
  Updates a account

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_account(account, attrs), to: Account.Update, as: :call

  @doc """
  Deletes a account

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_account(account), to: Account.Delete, as: :call

  @doc """
  Returns a changeset for tracking account changes

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  defdelegate change_account(account, attrs \\ %{}), to: Account.Change, as: :call
end
