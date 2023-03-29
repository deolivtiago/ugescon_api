defmodule Api.UserManagement.User do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Registry.Person
  alias Argon2

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, redact: true
    has_one :person, Person

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs || %{}, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    |> unique_constraint(:id, name: :users_pkey)
    |> unique_constraint(:email)
    |> cast_assoc(:person)
    |> validate_length(:email, min: 3, max: 128)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 2, max: 128)
    |> validate_length(:password, min: 6, max: 128)
    |> update_change(:password, &Argon2.hash_pwd_salt/1)
  end
end
