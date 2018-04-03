defmodule RefranerServer.Refraner do
  alias RefranerServer.Model.Vote
  alias RefranerServer.Model.Refran

  import RefranerServer.Refraner.Utils
  import Ecto.Query

  def get_random_refran() do
    q = from(refran in Refran, order_by: [asc: fragment("RANDOM()")], limit: 1)

    RefranerServer.Repo.one(q)
  end

  def get_refran(id) do
    id = string_to_integer(id)
    Refran |> RefranerServer.Repo.get(id)
  end

  def get_user_vote(tg_user_id, refran_id) do
    case Vote
         |> RefranerServer.Repo.get_by(tg_user_id: tg_user_id, refran_id: refran_id) do
      nil -> {:error, {:not_found, "Telegram User #{inspect(tg_user_id)} not found"}}
      vote -> {:ok, vote}
    end
  end

  def add_vote(tg_user_id, refran_id, new_vote) do
    refran_id = string_to_integer(refran_id)
    tg_user_id = string_to_integer(tg_user_id)
    new_vote = string_to_integer(new_vote)

    case get_user_vote(tg_user_id, refran_id) do
      {:ok, %{vote: ^new_vote} = result} ->
        {:ok, result}

      {:ok, saved_vote} ->
        Vote.update_vote(saved_vote, new_vote)

      {:error, _} ->
        Vote.insert_vote(%Vote{
          tg_user_id: tg_user_id,
          refran_id: refran_id,
          vote: new_vote
        })
    end
  end
end
