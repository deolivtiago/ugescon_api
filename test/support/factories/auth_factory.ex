defmodule Api.Factories.AuthFactory do
  @moduledoc """
  Generates auth data for testing
  """

  defmacro __using__(_opts) do
    quote do
      alias Api.Factory
      alias ApiWeb.Auth

      def auth_factory do
        :user
        |> Factory.build_and_validate(%{email: "some@mail.com", password: "123456"})
        |> Factory.insert()
        |> Api.Repo.preload(:person)
        |> Auth.generate_token()
      end
    end
  end
end
