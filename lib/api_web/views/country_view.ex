defmodule ApiWeb.CountryView do
  @moduledoc """
  View responsible for rendering countries
  """
  use ApiWeb, :view

  alias ApiWeb.CountryView

  @doc """
  Renders a list of countries
  """
  def render("index.json", %{countries: countries}) do
    %{success: true, data: render_many(countries, CountryView, "country.json")}
  end

  @doc """
  Renders a single country
  """
  def render("show.json", %{country: country}) do
    %{success: true, data: render_one(country, CountryView, "country.json")}
  end

  @doc """
  Renders a country data
  """
  def render("country.json", %{country: country}) do
    %{
      id: country.id,
      name: country.name,
      code: country.code
    }
  end
end
