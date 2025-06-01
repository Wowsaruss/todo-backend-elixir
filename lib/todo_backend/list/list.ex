defmodule TodoBackend.List do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :board_id, :title, :position, :inserted_at, :updated_at]}
  schema "lists" do
    field :title, :string
    field :position, :integer

    belongs_to :board, TodoBackend.Board
    has_many :todos, TodoBackend.Todo

    timestamps(type: :utc_datetime)
  end

  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :position, :board_id])
    |> validate_required([:title, :board_id])
    |> foreign_key_constraint(:board_id)
  end
end
