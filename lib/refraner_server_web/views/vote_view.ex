defmodule RefranerServerWeb.VoteView do
  use RefranerServerWeb, :view

  def render("vote.json", %{vote: vote}) do
    vote_json(vote)
  end

  @vote_json_fields [:id, :tg_user_id, :refran_id, :vote]
  def vote_json(vote) do
    Map.take(vote, @vote_json_fields)
  end
end
