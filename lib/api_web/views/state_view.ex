defmodule ApiWeb.StateView do
  @moduledoc """
  View responsible for rendering states
  """
  use ApiWeb, :view

  alias ApiWeb.StateView

  @doc """
  Renders a list of states
  """
  def render("index.json", %{states: states}) do
    %{success: true, data: render_many(states, StateView, "state.json")}
  end

  @doc """
  Renders a single state
  """
  def render("show.json", %{state: state}) do
    %{success: true, data: render_one(state, StateView, "state.json")}
  end

  @doc """
  Renders a state data
  """
  def render("state.json", %{state: state}) do
    %{
      id: state.id,
      name: state.name,
      code: state.code
    }
  end
end
