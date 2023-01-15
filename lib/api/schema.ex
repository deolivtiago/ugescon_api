defmodule Api.Schema do
  @moduledoc """
  Define a module to be used as base schema.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime]

      @doc false
      def changeset(attrs), do: changeset(struct(__MODULE__), attrs)
    end
  end
end
