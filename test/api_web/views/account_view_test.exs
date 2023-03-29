defmodule ApiWeb.AccountViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias Api.Accounting.Account
  alias ApiWeb.AccountView

  describe "render/3 returns success" do
    setup [:build_account]

    test "with a list of accounts", %{account: account} do
      assert %{success: true, data: data} = render(AccountView, "index.json", accounts: [account])
      assert [account_data] = data

      assert account_data.id == account.id
      assert account_data.type == Ecto.Enum.mappings(Account, :type)[account.type]
      assert account_data.code == account.code
      assert account_data.level == account.level
      assert account_data.name == account.name
    end

    test "with a single account", %{account: account} do
      assert %{success: true, data: account_data} =
               render(AccountView, "show.json", account: account)

      assert account_data.id == account.id
      assert account_data.type == Ecto.Enum.mappings(Account, :type)[account.type]
      assert account_data.code == account.code
      assert account_data.level == account.level
      assert account_data.name == account.name
    end

    test "with account data", %{account: account} do
      assert account_data = render(AccountView, "account.json", account: account)

      assert account_data.id == account.id
      assert account_data.type == Ecto.Enum.mappings(Account, :type)[account.type]
      assert account_data.code == account.code
      assert account_data.level == account.level
      assert account_data.name == account.name
    end
  end

  defp build_account(_) do
    :account
    |> build()
    |> then(&Map.put(&1, :type, Enum.at(Ecto.Enum.values(Account, :type), &1.type)))
    |> then(&{:ok, account: &1})
  end
end
