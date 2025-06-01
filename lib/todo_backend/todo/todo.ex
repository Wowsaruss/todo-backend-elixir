defmodule TodoBackend.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :order, :completed, :user_id, :list_id, :description, :due_date, :position, :inserted_at, :updated_at]}
  schema "todos" do
    field :title, :string
    field :order, :integer
    field :completed, :boolean, default: false
    field :description, :string
    field :due_date, :utc_datetime
    field :position, :integer

    belongs_to :user, TodoBackend.Users.User
    belongs_to :list, TodoBackend.Lists.List

    timestamps(type: :utc_datetime)
  end

  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :order, :completed, :user_id, :list_id, :description, :due_date, :position])
    |> validate_required([:title, :user_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:list_id)
  end
end
