defmodule TodoBackend.UserController do
  import Plug.Conn

  alias TodoBackend
  alias TodoBackend.User.Users

  def index(conn) do
    todos = Users.get_users()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(todos))
  end

  def show(conn, id) do
    case Users.get_user!(id) do
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
    case Users.create_user(params) do
      {:ok, user} ->
        token = TodoBackend.Auth.generate_token(user)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(%{user: user, token: token}))
      {:error, changeset} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
    end
  end
end
