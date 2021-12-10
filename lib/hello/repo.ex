defmodule Hello.Repo do
  use Ecto.Repo,
    otp_app: :hello,

    # Adapter of the repo module (postgres)
    adapter: Ecto.Adapters.Postgres
end
