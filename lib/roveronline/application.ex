defmodule Roveronline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Rover Server
      {Rover.Server, {10000, 10000}},
      # Start the Telemetry supervisor
      RoveronlineWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Roveronline.PubSub},
      # Start the Endpoint (http/https)
      RoveronlineWeb.Endpoint
      # Start a worker by calling: Roveronline.Worker.start_link(arg)
      # {Roveronline.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Roveronline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RoveronlineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
