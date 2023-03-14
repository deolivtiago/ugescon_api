defmodule ApiWeb.StateViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias ApiWeb.StateView

  describe "render/3 returns success" do
    setup [:build_state]

    test "with a list of states", %{state: state} do
      assert %{success: true, data: data} = render(StateView, "index.json", states: [state])

      assert [state_data] = data

      assert state_data.id == state.id
      assert state_data.code == state.code
      assert state_data.name == state.name
    end

    test "with a single state", %{state: state} do
      assert %{success: true, data: state_data} = render(StateView, "show.json", state: state)

      assert state_data.id == state.id
      assert state_data.code == state.code
      assert state_data.name == state.name
    end

    test "with state data", %{state: state} do
      assert state_data = render(StateView, "state.json", state: state)

      assert state_data.id == state.id
      assert state_data.code == state.code
      assert state_data.name == state.name
    end
  end

  defp build_state(_) do
    :state
    |> build()
    |> then(&{:ok, state: &1})
  end
end
