defmodule TodoBackend.TodoController do
  import Plug.Conn

  alias TodoBackend
  alias TodoBackend.{
    Repo,
    Todos,
    Todos.Todo
  }

  def index(conn) do
    todos = Todos.list_todos()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(todos))
  end

  def show(conn, %{"id" => id}) do
    id
    |> Todos.get_todo!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Todo not found"}))
      todo ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(todo))
    end
  end

  def create(conn, params) do
    params
    |> Todos.create_todo()
    |> case do
      {:ok, todo} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(todo))
      {:error, changeset} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
    end
  end

  def update(conn, %{"id" => id} = params) do
    id
    |> Todos.get_todo!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Todo not found"}))
      todo ->
        case todo |> Todo.changeset(params) |> Repo.update() do
          {:ok, updated_todo} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(200, Jason.encode!(updated_todo))
          {:error, changeset} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    id
    |> Todos.get_todo!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Todo not found"}))
      todo ->
        Repo.delete(todo)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(204, "")
    end
  end
end
