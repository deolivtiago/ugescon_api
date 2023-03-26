defmodule Api.Accounting do
  @moduledoc """
  The Accounting context
  """
  alias Api.Accounting.Account
  alias Api.Accounting.Entry

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

  @doc """
  Returns a list of entries

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  defdelegate list_entries, to: Entry.List, as: :call

  @doc """
  Returns a list of entries filtered by person id

  ## Examples

      iex> list_entries(person_id: person_id)`
      [%Account{}, ...]

  """
  defdelegate list_entries(filter), to: Entry.List, as: :call

  @doc """
  Gets a entry

  ## Examples

      iex> get_entry(value)
      {:ok, %Entry{}}

      iex> get_entry(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_entry(id), to: Entry.Get, as: :call

  @doc """
  Creates a entry

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_entry(attrs \\ %{}), to: Entry.Create, as: :call

  @doc """
  Updates a entry

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_entry(entry, attrs), to: Entry.Update, as: :call

  @doc """
  Deletes a entry

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_entry(entry), to: Entry.Delete, as: :call

  @doc """
  Returns a changeset for tracking entry changes

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  defdelegate change_entry(entry, attrs \\ %{}), to: Entry.Change, as: :call
end
