defmodule TodoBackend.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/todos" do
    TodoBackend.TodoController.index(conn)
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
