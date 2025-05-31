defmodule TodoBackend.UserController do
  import Plug.Conn

  alias TodoBackend.User

  def index(conn) do
    todos = TodoBackend.Repo.all(User)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(todos))
  end

  def show(conn, id) do
    case TodoBackend.Repo.get(User, id) do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "User not found"}))
      todo ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(todo))
    end
  end

  def create(conn, params) do
    changeset = User.changeset(%User{}, params)
    case TodoBackend.Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(user))
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
