defmodule ApiWeb.CityView do
  @moduledoc """
  View responsible for rendering states
  """
  use ApiWeb, :view

  alias ApiWeb.CityView

  @doc """
  Renders a list of cities
  """
  def render("index.json", %{cities: cities}) do
    %{success: true, data: render_many(cities, CityView, "city.json")}
  end

  @doc """
  Renders a single city
  """
  def render("show.json", %{city: city}) do
    %{success: true, data: render_one(city, CityView, "city.json")}
  end

  @doc """
  Renders a city data
  """
  def render("city.json", %{city: city}) do
    %{
      id: city.id,
      name: city.name,
      state_id: city.state_id
    }
  end
end
