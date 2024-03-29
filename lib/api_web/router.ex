defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ApiWeb.Auth.Pipeline
  end

  scope "/api", ApiWeb do
    pipe_through [:api]

    post "/signup", AuthController, :signup
    post "/signin", AuthController, :signin
  end

  scope "/api", ApiWeb do
    pipe_through [:api, :auth]

    resources "/users", UserController, except: [:new, :edit]
    resources "/accounts", AccountController, except: [:new, :edit]

    resources "/persons", PersonController, except: [:new, :edit] do
      resources "/addresses", AddressController, except: [:new, :edit]
      resources "/entries", EntryController, except: [:new, :edit]
      resources "/financial-statement", FinancialStatementController, only: [:index]
    end

    resources "/countries", CountryController, except: [:new, :edit] do
      resources "/states", StateController, except: [:new, :edit] do
        resources "/cities", CityController, except: [:new, :edit]
      end
    end
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
