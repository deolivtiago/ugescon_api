defmodule ApiWeb.AddressView do
  use ApiWeb, :view

  alias ApiWeb.AddressView
  alias ApiWeb.CityView

  def render("index.json", %{addresses: addresses}) do
    %{success: true, data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{success: true, data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      id: address.id,
      alias: address.alias,
      street: address.street,
      number: address.number,
      complement: address.complement,
      neighborhood: address.neighborhood,
      zip: address.zip,
      city: render_one(address.city, CityView, "city.json")
    }
  end
end
