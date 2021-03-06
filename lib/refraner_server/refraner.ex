defmodule RefranerServer.Refraner do
  alias RefranerServer.Model.Vote
  alias RefranerServer.Model.Refran

  import RefranerServer.Refraner.Utils
  import Ecto.Query

  defp apply_filter({"language", language}, q),
    do: from(refran in q, where: refran.idioma_codigo == ^language)

  defp apply_filter({"search", search_query}, q) do
    search_query = "%#{search_query}%"
    from(refran in q, where: like(refran.refran, ^search_query))
  end

  defp apply_filter(_, q), do: q

  defp apply_filters(query, opts), do: Enum.reduce(opts, query, &apply_filter/2)

  def get_refranes(opts \\ []) do
    limit = opts["count"] || 1

    from(refran in Refran,
      order_by: [asc: fragment("RANDOM()")],
      limit: ^limit,
      where: not is_nil(refran.refran)
    )
    |> apply_filters(opts)
    |> RefranerServer.Repo.all()
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

  def get_vote(tg_user_id, refran_id) do
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

    case get_vote(tg_user_id, refran_id) do
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

  def get_languages() do
    from(refran in Refran, distinct: true, select: refran.idioma_codigo)
    |> RefranerServer.Repo.all()
  end
end
