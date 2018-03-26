defmodule RefranerServerWeb.VoteController do
  use RefranerServerWeb, :controller

  def add_vote(conn, %{"tg_user_id" => tg_user_id, "refran_id" => refran_id, "vote" => vote}) do
    case RefranerServer.Refraner.add_vote(tg_user_id, refran_id, vote) do
      {:ok, _} -> send_resp(conn, 201, "")
      {:error, err} -> send_resp(conn, 500, err)
    end
  end

  def get_user_vote(conn, %{"tg_user_id" => tg_user_id, "refran_id" => refran_id}) do
    case RefranerServer.Refraner.get_user_vote(tg_user_id, refran_id) do
      {:ok, vote} -> render(conn, "vote.json", %{vote: vote})
      {:error, {:not_found, err}} -> send_resp(conn, 404, err)
      _ -> send_resp(conn, 500, "Internal Server Error")
    end
  end
end
