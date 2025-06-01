defmodule TodoBackend.ListController do
  import Plug.Conn

  alias TodoBackend
  alias TodoBackend.List
  alias TodoBackend.List.Lists
  alias TodoBackend.Repo

  def index(conn) do
    lists = Lists.list_lists()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(lists))
  end

  def show(conn, %{"id" => id}) do
    id
    |> Lists.get_list!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "List not found"}))
      list ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(list))
    end
  end

  def create(conn, params) do
    params
    |> Lists.create_list()
    |> case do
      {:ok, list} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(list))
      {:error, changeset} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
    end
  end

  def update(conn, %{"id" => id} = params) do
    id
    |> Lists.get_list!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "List not found"}))
      list ->
        case list |> List.changeset(params) |> Repo.update() do
          {:ok, updated_list} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(200, Jason.encode!(updated_list))
          {:error, changeset} ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(400, Jason.encode!(%{errors: TodoBackend.changeset_errors(changeset)}))
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    id
    |> Lists.get_list!()
    |> case do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "List not found"}))
      list ->
        Repo.delete(list)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(204, "")
    end
  end
end
