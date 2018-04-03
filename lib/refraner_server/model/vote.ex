defmodule RefranerServer.Model.Vote do
  use Ecto.Schema

  schema "votes" do
    field(:tg_user_id, :integer)
    field(:refran_id, :integer)
    field(:vote, :integer)
  end

  def changeset(vote, params \\ %{}) do
    vote
    |> Ecto.Changeset.cast(params, [:vote])
  end

  def update_vote(vote, new_vote) do
    changeset(vote, %{vote: new_vote})
    |> RefranerServer.Repo.update()
  end

  def insert_vote(vote) do
    case RefranerServer.Repo.insert(vote) do
      {:ok, _} = res_ok -> res_ok
      _ -> {:error, "Could not insert vote #{inspect(vote)}"}
    end
  end
end
