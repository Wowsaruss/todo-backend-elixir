defmodule TodoBackend.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/users" do
    TodoBackend.UserController.index(conn)
  end
  get "/users/:id" do
    id = String.to_integer(id)
    TodoBackend.UserController.show(conn, id)
  end
  post "/users" do
    {:ok, body, conn} = read_body(conn)
    params = Jason.decode!(body)
    TodoBackend.UserController.create(conn, params)
  end

  get "/todos" do
    TodoBackend.TodoController.index(conn)
  end
  get "/todos/:id" do
    id = String.to_integer(id)
    TodoBackend.TodoController.show(conn, id)
  end
  post "/todos" do
    {:ok, body, conn} = read_body(conn)
    params = Jason.decode!(body)
    TodoBackend.TodoController.create(conn, params)
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Jason.encode!(%{error: "Not found"}))
  end
end
