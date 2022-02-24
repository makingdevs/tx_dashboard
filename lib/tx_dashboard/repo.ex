defmodule TxDashboard.Repo do
  use Ecto.Repo,
    otp_app: :tx_dashboard,
    adapter: Ecto.Adapters.Postgres
end
