defmodule TodoBackend.BoardController do
  import Plug.Conn

  alias TodoBackend
  alias TodoBackend.Board
  alias TodoBackend.Board.Boards
  alias TodoBackend.Repo

  def index(conn) do
    boards = Boards.list_boards()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(boards))
  end

  def show(conn, %{"id" => id}) do
    id
    |> Boards.get_board!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Board not found"}))
      board ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(board))
    end
  end

  def create(conn, params) do
    params
    |> Boards.create_board()
    |> case do
      {:ok, board} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(board))
      {:error, changeset} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
    end
  end

  def update(conn, %{"id" => id} = params) do
    id
    |> Boards.get_board!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Board not found"}))
      board ->
        case board |> Board.changeset(params) |> Repo.update() do
          {:ok, updated_board} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(200, Jason.encode!(updated_board))
          {:error, changeset} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    id
    |> Boards.get_board!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Board not found"}))
      board ->
        Repo.delete(board)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(204, "")
    end
  end
end
