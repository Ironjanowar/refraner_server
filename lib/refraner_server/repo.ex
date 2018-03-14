defmodule RefranerServer.Repo do
  use Ecto.Repo, otp_app: :refraner_server, adapter: Sqlite.Ecto2
end
