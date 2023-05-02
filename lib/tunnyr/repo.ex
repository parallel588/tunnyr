defmodule Tunnyr.Repo do
  use Ecto.Repo,
    otp_app: :tunnyr,
    adapter: Ecto.Adapters.Postgres
end
