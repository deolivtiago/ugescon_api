defmodule Api.Factories.StateFactory do
  @moduledoc """
  Generates state data for testing
  """
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  alias Api.Location.State

  defmacro __using__(_opts) do
    quote do
      def state_factory do
        %State{
          id: Faker.UUID.v4(),
          name: Faker.Address.PtBr.state(),
          code: Faker.Address.state_abbr(),
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
