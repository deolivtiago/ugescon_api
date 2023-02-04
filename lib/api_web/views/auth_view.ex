defmodule ApiWeb.AuthView do
  @moduledoc """
  View responsible for rendering users
  """
  use ApiWeb, :view

  alias ApiWeb.UserView

  def render("auth.json", %{data: %{user: user, token: token}}) do
    %{
      success: true,
      data: %{
        token: token,
        user: render_one(user, UserView, "user.json")
      }
    }
  end
end
