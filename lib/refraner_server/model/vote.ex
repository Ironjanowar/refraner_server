defmodule RefranerServer.Model.Vote do
  use Ecto.Schema

  alias __MODULE__

  schema "votes" do
    field(:tg_user_id, :integer)
    field(:refran_id, :integer)
    field(:vote, :integer)
  end
end
