defmodule TodoBackend.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :email, :password_hash, :first_name, :last_name]}
  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :first_name, :string
    field :last_name, :string
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password_hash, :first_name, :last_name])
    |> validate_required([:username, :email, :password_hash])
  end
end
