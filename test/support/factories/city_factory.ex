defmodule Api.Factories.CityFactory do
  @moduledoc """
  Generates city data for testing
  """
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  alias Api.Location.City

  defmacro __using__(_opts) do
    quote do
      def city_factory do
        %City{
          id: Faker.UUID.v4(),
          name: Faker.Address.PtBr.city(),
          state_id: insert(:state).id,
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
