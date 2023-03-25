defmodule ApiWeb.EntryViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias Api.Accounting.Entry
  alias ApiWeb.EntryView

  describe "render/3 returns success" do
    setup [:build_entry]

    test "with a list of entries", %{entry: entry} do
      assert %{success: true, data: data} = render(EntryView, "index.json", entries: [entry])
      assert [entry_data] = data

      assert entry_data.id == entry.id
      assert entry_data.type == Ecto.Enum.mappings(Entry, :type)[entry.type]
      assert entry_data.value == entry.value
      assert entry_data.description == entry.description
      assert entry_data.debit_account_code == entry.debit_account_code
      assert entry_data.credit_account_code == entry.credit_account_code
      assert entry_data.person_id == entry.person_id
    end

    test "with a single entry", %{entry: entry} do
      assert %{success: true, data: entry_data} = render(EntryView, "show.json", entry: entry)

      assert entry_data.id == entry.id
      assert entry_data.type == Ecto.Enum.mappings(Entry, :type)[entry.type]
      assert entry_data.value == entry.value
      assert entry_data.description == entry.description
      assert entry_data.debit_account_code == entry.debit_account_code
      assert entry_data.credit_account_code == entry.credit_account_code
      assert entry_data.person_id == entry.person_id
    end

    test "with entry data", %{entry: entry} do
      assert entry_data = render(EntryView, "entry.json", entry: entry)

      assert entry_data.id == entry.id
      assert entry_data.type == Ecto.Enum.mappings(Entry, :type)[entry.type]
      assert entry_data.value == entry.value
      assert entry_data.description == entry.description
      assert entry_data.debit_account_code == entry.debit_account_code
      assert entry_data.credit_account_code == entry.credit_account_code
      assert entry_data.person_id == entry.person_id
    end
  end

  defp build_entry(_) do
    :entry
    |> build()
    |> then(&Map.put(&1, :type, Enum.at(Ecto.Enum.values(Entry, :type), &1.type)))
    |> then(&{:ok, entry: &1})
  end
end
