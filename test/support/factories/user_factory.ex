defmodule Api.Factories.UserFactory do
  @moduledoc """
  Generates user data for testing
  """
  alias Api.UserManagement.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          id: Faker.UUID.v4(),
          name: Faker.Person.name(),
          email: Faker.Internet.email(),
          password: Base.encode64(:crypto.strong_rand_bytes(32), padding: false),
          inserted_at: Faker.DateTime.backward(366),
          updated_at: DateTime.utc_now()
        }
      end
    end
  end
end
