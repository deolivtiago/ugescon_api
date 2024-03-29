defmodule Api.Factory do
  @moduledoc """
  Defines factory for generating data
  """
  use ExMachina.Ecto, repo: Api.Repo

  use Api.Factories.UserFactory
  use Api.Factories.AuthFactory
  use Api.Factories.PersonFactory
  use Api.Factories.CountryFactory
  use Api.Factories.StateFactory
  use Api.Factories.CityFactory
  use Api.Factories.AccountFactory
  use Api.Factories.EntryFactory
end
