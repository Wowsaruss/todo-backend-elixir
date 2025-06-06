defmodule TodoBackend.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :description, :user_id, :inserted_at, :updated_at]}
  schema "boards" do
    field :name, :string
    field :description, :string

    belongs_to :user, TodoBackend.Users.User
    has_many :lists, TodoBackend.Lists.List

    timestamps(type: :utc_datetime)
  end

  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :user_id])
    |> unique_constraint([:name, :user_id], name: :boards_name_user_id_index)
    |> foreign_key_constraint(:user_id)
  end
end
