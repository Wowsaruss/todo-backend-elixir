defmodule TodoBackend.TodoController do
  import Plug.Conn

  alias TodoBackend.Todo

  def index(conn) do
    todos = TodoBackend.Repo.all(Todo)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(todos))
  end

  def create(conn, params) do
    changeset = Todo.changeset(%Todo{}, params)
    case TodoBackend.Repo.insert(changeset) do
      {:ok, todo} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(todo))
      {:error, changeset} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{errors: changeset_errors(changeset)}))
    end
  end

  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
