defmodule TxDashboard.Repo do
  use Ecto.Repo,
    otp_app: :tx_dashboard,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
