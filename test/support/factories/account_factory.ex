defmodule Api.Factories.AccountFactory do
  @moduledoc """
  Generates account data for testing
  """
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  alias Api.Accounting.Account

  defmacro __using__(_opts) do
    quote do
      def account_factory do
        %Account{
          id: Faker.UUID.v4(),
          name: Faker.Cat.name(),
          code: "#{Faker.Random.Elixir.random_between(1, 59999)}",
          level: Faker.Random.Elixir.random_between(1, 4),
          type: Faker.Random.Elixir.random_between(0, 1),
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
