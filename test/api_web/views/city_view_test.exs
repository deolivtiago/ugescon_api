defmodule ApiWeb.CityViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias ApiWeb.CityView

  describe "render/3 returns success" do
    setup [:build_city]

    test "with a list of cities", %{city: city} do
      assert %{success: true, data: data} = render(CityView, "index.json", cities: [city])

      assert [city_data] = data

      assert city_data.id == city.id
      assert city_data.name == city.name
      assert city_data.state_id == city.state_id
    end

    test "with a single city", %{city: city} do
      assert %{success: true, data: city_data} = render(CityView, "show.json", city: city)

      assert city_data.id == city.id
      assert city_data.name == city.name
      assert city_data.state_id == city.state_id
    end

    test "with city data", %{city: city} do
      assert city_data = render(CityView, "city.json", city: city)

      assert city_data.id == city.id
      assert city_data.name == city.name
      assert city_data.state_id == city.state_id
    end
  end

  defp build_city(_) do
    :city
    |> build()
    |> then(&{:ok, city: &1})
  end
end
