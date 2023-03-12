defmodule Api.Factories.PersonFactory do
  @moduledoc """
  Generates person data for testing
  """
  alias Api.Registry.Person

  defmacro __using__(_opts) do
    quote do
      def person_factory do
        %Person{
          id: Faker.UUID.v4(),
          name: Faker.Person.name(),
          alias: Faker.Person.name(),
          type: Faker.Random.Elixir.random_between(0, 2),
          social_id: "#{Faker.Random.Elixir.random_between(11_111_111_111, 99_999_999_999_999)}",
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
