defmodule ApiWeb.ChangesetView do
  @moduledoc """
  View responsible for rendering changeset errors
  """
  use ApiWeb, :view

  @doc """
  Traverses and translates changeset errors

  See `Ecto.Changeset.traverse_errors/2` and
  `ApiWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @doc """
  Renders changeset errors
  """
  def render("error.json", %{changeset: changeset}) do
    %{success: false, errors: translate_errors(changeset)}
  end
end
