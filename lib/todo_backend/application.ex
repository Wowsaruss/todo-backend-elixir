defmodule TodoBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:todo_backend, :http_port, 5000)

    children = [
      TodoBackend.Repo,
      {Plug.Cowboy, scheme: :http, plug: TodoBackend.Router, options: [port: port]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodoBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
