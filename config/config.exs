import Config

config :todo_backend, TodoBackend.Repo,
  database: System.get_env("DB_NAME", "todo_backend_repo"),
  username: System.get_env("DB_USER", "postgres"),
  password: System.get_env("DB_PASSWORD", "postgres"),
  hostname: System.get_env("DB_HOST", "localhost"),
  port: String.to_integer(System.get_env("DB_PORT", "5432"))

config :todo_backend,
  ecto_repos: [TodoBackend.Repo]

# Server configuration
config :todo_backend, :http_port, String.to_integer(System.get_env("PORT", "5000"))
