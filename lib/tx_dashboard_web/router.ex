defmodule TxDashboardWeb.Router do
  use TxDashboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TxDashboardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TxDashboardWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/accounts", Account.AccountsLive, :index
    live "/accounts/new", Account.AccountsLive, :new
    live "/accounts/:id/edit", Account.AccountsLive, :edit

    live "/accounts/new_customer", Account.NewCustomerLive, :index

    live "/accounts/:id", Account.SummaryLive, :show
    live "/accounts/:id/show/edit", Account.SummaryLive, :edit

    live "/transactions", Transaction.MovementsLive, :index
    live "/transactions/new", Transaction.MovementsLive, :new
    live "/transactions/:id/edit", Transaction.MovementsLive, :edit

    live "/transactions/:id", Transaction.DetailsLive, :show
    live "/transactions/:id/show/edit", Transaction.DetailsLive, :edit

    live "/balances/:account_number", Balances.AccountStatusLive, :index

    live "/verification/code", Verification.CodeLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TxDashboardWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TxDashboardWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
