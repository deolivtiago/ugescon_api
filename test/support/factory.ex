defmodule Api.Factory do
  @moduledoc """
  Defines factory for generating data
  """
  use ExMachina.Ecto, repo: Api.Repo

  use Api.Factories.UserFactory
end
