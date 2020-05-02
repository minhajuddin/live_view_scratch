defmodule LiveViewScratch.Repo do
  use Ecto.Repo,
    otp_app: :live_view_scratch,
    adapter: Ecto.Adapters.Postgres
end
