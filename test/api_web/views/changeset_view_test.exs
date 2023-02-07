defmodule ApiWeb.ChangesetViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View

  alias Api.UserManagement.User
  alias ApiWeb.ChangesetView

  describe "render/3 returns error" do
    test "with an user changeset" do
      changeset = User.invalid_changeset(:id, Ecto.UUID.generate(), "not found")

      assert json = render(ChangesetView, "error.json", changeset: changeset)

      refute json.success
      assert json.errors.id == ["not found"]
    end
  end
end
