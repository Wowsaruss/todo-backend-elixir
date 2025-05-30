import Config

config :todo_backend, TodoBackend.Repo,
  database: "todo_backend_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :todo_backend,
  ecto_repos: [TodoBackend.Repo] 