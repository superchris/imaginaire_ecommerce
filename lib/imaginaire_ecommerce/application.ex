defmodule ImaginaireEcommerce.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ImaginaireEcommerceWeb.Telemetry,
      ImaginaireEcommerce.Repo,
      {DNSCluster,
       query: Application.get_env(:imaginaire_ecommerce, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ImaginaireEcommerce.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ImaginaireEcommerce.Finch},
      {Wasmex.Components,
       bytes: File.read!("priv/wasm/apply_discount.wasm"),
       name: DiscountCalculator,
       wasi: %Wasmex.Wasi.WasiP2Options{inherit_stdout: true}},
      # Start a worker by calling: ImaginaireEcommerce.Worker.start_link(arg)
      # {ImaginaireEcommerce.Worker, arg},
      # Start to serve requests, typically the last entry
      ImaginaireEcommerceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImaginaireEcommerce.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ImaginaireEcommerceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
