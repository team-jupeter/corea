defmodule Corea.Repo do
  use Ecto.Repo,
    otp_app: :corea,
    adapter: Ecto.Adapters.Postgres
end
