defmodule TodoBackend.Repo do
  use Ecto.Repo,
    otp_app: :todo_backend,
    adapter: Ecto.Adapters.Postgres,
    database: "todo_backend_repo",
    username: "postgres",
    password: "postgres",
    hostname: "localhost"

  def init(_type, config) do
    {:ok, config}
  end
end
