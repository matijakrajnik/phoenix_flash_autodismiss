defmodule PhoenixFlashAutodismiss.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixFlashAutodismissWeb.Telemetry,
      PhoenixFlashAutodismiss.Repo,
      {DNSCluster,
       query: Application.get_env(:phoenix_flash_autodismiss, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixFlashAutodismiss.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixFlashAutodismiss.Finch},
      # Start a worker by calling: PhoenixFlashAutodismiss.Worker.start_link(arg)
      # {PhoenixFlashAutodismiss.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixFlashAutodismissWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixFlashAutodismiss.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixFlashAutodismissWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
