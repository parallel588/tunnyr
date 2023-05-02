defmodule Tunnyr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TunnyrWeb.Telemetry,
      # Start the Ecto repository
      Tunnyr.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tunnyr.PubSub},
      # Start Finch
      {Finch, name: Tunnyr.Finch},
      # Start the Endpoint (http/https)
      TunnyrWeb.Endpoint
      # Start a worker by calling: Tunnyr.Worker.start_link(arg)
      # {Tunnyr.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tunnyr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TunnyrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
