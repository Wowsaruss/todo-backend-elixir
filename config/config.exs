import Config

config :todo_backend, TodoBackend.Repo,
  database: "todo_db",
  username: "russellhayes",
  password: "postgres",
  hostname: "localhost"

config :todo_backend,
  ecto_repos: [TodoBackend.Repo]

# Server configuration
config :todo_backend, :http_port, 5000
