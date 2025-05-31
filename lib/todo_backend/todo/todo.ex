defmodule TodoBackend.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :completed]}
  schema "todos" do
    field :title, :string
    field :completed, :boolean, default: false
  end

  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :completed])
    |> validate_required([:title])
  end
end
