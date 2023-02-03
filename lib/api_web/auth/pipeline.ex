defmodule ApiWeb.Auth.Pipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :api,
    module: ApiWeb.Auth.Guardian,
    error_handler: ApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource
  plug Guardian.Plug.EnsureAuthenticated
end
