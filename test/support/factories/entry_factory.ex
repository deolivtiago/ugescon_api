defmodule Api.Factories.EntryFactory do
  @moduledoc """
  Generates entry data for testing
  """
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  alias Api.Accounting.Entry

  defmacro __using__(_opts) do
    quote do
      def entry_factory do
        %Entry{
          id: Faker.UUID.v4(),
          name: Faker.Cat.name(),
          type: Faker.Random.Elixir.random_between(0, 1),
          value: Faker.Random.Elixir.random_between(1, 999_999_999),
          date: DateTime.truncate(Faker.DateTime.backward(366), :second),
          description: Faker.Lorem.sentence(),
          debit_account_code: insert(:account).code,
          credit_account_code: insert(:account).code,
          person_id: insert(:person).id,
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
