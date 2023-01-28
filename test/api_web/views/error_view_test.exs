defmodule ApiWeb.ErrorViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View

  alias ApiWeb.ErrorView

  test "renders 500.json" do
    assert %{success: false, errors: errors} = render(ErrorView, "500.json", [])

    assert errors.detail == "Internal Server Error"
  end
end
