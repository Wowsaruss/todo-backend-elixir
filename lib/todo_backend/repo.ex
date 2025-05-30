defmodule TodoBackend.Repo do
  use Ecto.Repo,
    otp_app: :todo_backend,
    adapter: Ecto.Adapters.Postgres,
    database: "todo_db",
    username: "russellhayes",
    password: "postgres",
    hostname: "localhost"

  def init(_type, config) do
    {:ok, config}
  end
end
