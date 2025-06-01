defmodule TodoBackend.Board do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :description, :user_id, :inserted_at, :updated_at]}
  schema "boards" do
    field :name, :string
    field :description, :string

    belongs_to :user, TodoBackend.User
    has_many :lists, TodoBackend.List

    timestamps(type: :utc_datetime)
  end

  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
