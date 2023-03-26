defmodule ApiWeb.UserView do
  @moduledoc """
  View responsible for rendering users
  """
  use ApiWeb, :view

  alias ApiWeb.UserView
  alias ApiWeb.PersonView

  @doc """
  Renders a list of users
  """
  def render("index.json", %{users: users}) do
    %{success: true, data: render_many(users, UserView, "user.json")}
  end

  @doc """
  Renders a single user
  """
  def render("show.json", %{user: user}) do
    %{success: true, data: render_one(user, UserView, "user.json")}
  end

  @doc """
  Renders an user data
  """
  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      person: render_one(user.person, PersonView, "person.json")
    }
  end
end
