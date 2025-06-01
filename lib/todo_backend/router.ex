defmodule TodoBackend.Router do
  use Plug.Router

  alias TodoBackend.{
    UserController,
    BoardController,
    ListController,
    TodoController
  }

  plug :match
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  plug :dispatch

  # User routes
  get "/users" do
    UserController.index(conn)
  end
  get "/users/:id" do
    UserController.show(conn, %{"id" => id})
  end
  post "/users" do
    UserController.create(conn, conn.body_params)
  end

  # Board routes
  get "/boards" do
    BoardController.index(conn)
  end
  get "/boards/:id" do
    BoardController.show(conn, %{"id" => id})
  end
  post "/boards" do
    BoardController.create(conn, conn.body_params)
  end
  put "/boards/:id" do
    BoardController.update(conn, Map.put(conn.body_params, "id", id))
  end
  delete "/boards/:id" do
    BoardController.delete(conn, %{"id" => id})
  end

  # List routes
  get "/boards/:board_id/lists" do
    ListController.index(conn)
  end
  post "/boards/:board_id/lists" do
    ListController.create(conn, Map.put(conn.body_params, "board_id", board_id))
  end
  get "/lists/:id" do
    ListController.show(conn, %{"id" => id})
  end
  put "/lists/:id" do
    ListController.update(conn, Map.put(conn.body_params, "id", id))
  end
  delete "/lists/:id" do
    ListController.delete(conn, %{"id" => id})
  end

  # Todo routes
  get "/todos" do
    TodoController.index(conn)
  end
  post "/todos" do
    TodoController.create(conn, conn.body_params)
  end
  get "/todos/:id" do
    TodoController.show(conn, %{"id" => id})
  end
  put "/todos/:id" do
    TodoController.update(conn, Map.put(conn.body_params, "id", id))
  end
  delete "/todos/:id" do
    TodoController.delete(conn, %{"id" => id})
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Jason.encode!(%{error: "Not found"}))
  end
end
