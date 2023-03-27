defmodule ApiWeb.EntryViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias Api.Accounting.Entry
  alias ApiWeb.EntryView

  describe "render/3 returns success" do
    setup [:insert_entry]

    test "with a list of entries", %{entry: entry} do
      assert %{success: true, data: data} = render(EntryView, "index.json", entries: [entry])
      assert [entry_data] = data

      assert entry_data.id == entry.id
      assert entry_data.type == Ecto.Enum.mappings(Entry, :type)[entry.type]
      assert entry_data.value == entry.value
      assert entry_data.name == entry.name
      assert DateTime.compare(entry_data.date, entry.date) == :eq
      assert entry_data.description == entry.description
      assert entry_data.person_id == entry.person_id
    end

    test "with a single entry", %{entry: entry} do
      assert %{success: true, data: entry_data} = render(EntryView, "show.json", entry: entry)

      assert entry_data.id == entry.id
      assert entry_data.type == Ecto.Enum.mappings(Entry, :type)[entry.type]
      assert entry_data.value == entry.value
      assert entry_data.name == entry.name
      assert DateTime.compare(entry_data.date, entry.date) == :eq
      assert entry_data.description == entry.description
      assert entry_data.person_id == entry.person_id
    end

    test "with entry data", %{entry: entry} do
      assert entry_data = render(EntryView, "entry.json", entry: entry)

      assert entry_data.id == entry.id
      assert entry_data.type == Ecto.Enum.mappings(Entry, :type)[entry.type]
      assert entry_data.value == entry.value
      assert entry_data.name == entry.name
      assert DateTime.compare(entry_data.date, entry.date) == :eq
      assert entry_data.description == entry.description
      assert entry_data.person_id == entry.person_id
    end
  end

  defp insert_entry(_) do
    :entry
    |> insert()
    |> Api.Repo.preload([:credit_account, :debit_account])
    |> then(&{:ok, entry: &1})
  end
end
