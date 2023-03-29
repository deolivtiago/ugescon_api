defmodule ApiWeb.EntryView do
  @moduledoc """
  View responsible for rendering entries
  """
  use ApiWeb, :view

  alias Api.Accounting.Entry
  alias ApiWeb.AccountView
  alias ApiWeb.EntryView

  @doc """
  Renders a list of entries
  """
  def render("index.json", %{entries: entries}) do
    %{success: true, data: render_many(entries, EntryView, "entry.json")}
  end

  @doc """
  Renders a single entry
  """
  def render("show.json", %{entry: entry}) do
    %{success: true, data: render_one(entry, EntryView, "entry.json")}
  end

  @doc """
  Renders a entry data
  """
  def render("entry.json", %{entry: entry}) do
    %{
      id: entry.id,
      type: Ecto.Enum.mappings(Entry, :type)[entry.type],
      name: entry.name,
      value: entry.value,
      date: entry.date,
      description: entry.description,
      debit_account: render_one(entry.debit_account, AccountView, "account.json"),
      credit_account: render_one(entry.credit_account, AccountView, "account.json"),
      person_id: entry.person_id
    }
  end
end
