defmodule ApiWeb.CountryViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias ApiWeb.CountryView

  describe "render/3 returns success" do
    setup [:build_country]

    test "with a list of countries", %{country: country} do
      assert %{success: true, data: data} =
               render(CountryView, "index.json", countries: [country])

      assert [country_data] = data

      assert country_data.id == country.id
      assert country_data.code == country.code
      assert country_data.name == country.name
    end

    test "with a single country", %{country: country} do
      assert %{success: true, data: country_data} =
               render(CountryView, "show.json", country: country)

      assert country_data.id == country.id
      assert country_data.code == country.code
      assert country_data.name == country.name
    end

    test "with country data", %{country: country} do
      assert country_data = render(CountryView, "country.json", country: country)

      assert country_data.id == country.id
      assert country_data.code == country.code
      assert country_data.name == country.name
    end
  end

  defp build_country(_) do
    :country
    |> build()
    |> then(&{:ok, country: &1})
  end
end
