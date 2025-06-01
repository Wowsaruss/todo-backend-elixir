defmodule TodoBackend.Todo.Todos do
  alias TodoBackend.Todo
  alias TodoBackend.Repo

  @doc """
  Lists all todos.
  """
  def list_todos do
    Repo.all(Todo)
  end

  @doc """
  Gets a single todo by ID.
  """
  def get_todo!(id) do
    Repo.get!(Todo, id)
  end

  @doc """
  Creates a todo.
  """
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo.
  """
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo.
  """
  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end
end
