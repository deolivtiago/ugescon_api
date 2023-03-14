defmodule Api.Factories.CountryFactory do
  @moduledoc """
  Generates country data for testing
  """
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  alias Api.Location.Country

  defmacro __using__(_opts) do
    quote do
      def country_factory do
        %Country{
          id: Faker.UUID.v4(),
          name: Faker.Address.PtBr.country(),
          code: Faker.Address.country_code(),
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
