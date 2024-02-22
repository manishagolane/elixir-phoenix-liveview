defmodule TopPack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TopPack.Telemetry,
      # Start the Endpoint (http/https)
      TopPack.Endpoint,
       # Start the PubSub System
      {Phoenix.PubSub, name: TopPack.PubSub},
      {TopPack.TopPackGenserver,[]},

      # Start a worker by calling: TopPack.Worker.start_link(arg)
      # {TopPack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TopPack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TopPack.Endpoint.config_change(changed, removed)
    :ok
  end
end
