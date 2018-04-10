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

    case Refran |> RefranerServer.Repo.get(id) do
      nil ->
        {:error, {:not_found, "Refran ID #{inspect(id)} not found", %{refran_id: "not_found"}}}

      refran ->
        {:ok, refran}
    end
  end

  defp get_vote(tg_user_id, refran_id) do
    tg_user_id = string_to_integer(tg_user_id)
    refran_id = string_to_integer(refran_id)

    case Vote |> RefranerServer.Repo.get_by(tg_user_id: tg_user_id, refran_id: refran_id) do
      nil ->
        {:error,
         {:not_found, "Telegram User #{tg_user_id} not found for Refran ID #{refran_id}",
          %{tg_user_id: "not_found"}}}

      vote ->
        {:ok, vote}
    end
  end

  def get_user_vote(tg_user_id, refran_id) do
    with {:ok, _} <- get_refran(refran_id),
         {:ok, vote} <- get_vote(tg_user_id, refran_id) do
      {:ok, vote}
    else
      err -> err
    end
  end

  def add_vote(tg_user_id, refran_id, new_vote) when is_binary(new_vote) do
    new_vote = string_to_integer(new_vote)
    add_vote(tg_user_id, refran_id, new_vote)
  end

  def add_vote(_tg_user_id, _refran_id, new_vote) when new_vote < 1 or 5 < new_vote,
    do:
      {:error,
       {:not_in_range, "Vote should be between 1 and 5, received vote is #{inspect(new_vote)}",
        %{vote: "not_in_range"}}}

  def add_vote(tg_user_id, refran_id, new_vote) when is_integer(new_vote) do
    refran_id = string_to_integer(refran_id)
    tg_user_id = string_to_integer(tg_user_id)
    new_vote = string_to_integer(new_vote)

    case get_user_vote(tg_user_id, refran_id) do
      {:ok, %{vote: ^new_vote} = result} ->
        {:ok, result}

      {:ok, saved_vote} ->
        Vote.update_vote(saved_vote, new_vote)

      {:error, {:not_found, _error_message, %{refran_id: "not_found"}}} = err ->
        err

      {:error, _} ->
        Vote.insert_vote(%Vote{
          tg_user_id: tg_user_id,
          refran_id: refran_id,
          vote: new_vote
        })
    end
  end
end
