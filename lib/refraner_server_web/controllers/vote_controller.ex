defmodule RefranerServerWeb.VoteController do
  use RefranerServerWeb, :controller

  alias RefranerServerWeb.ErrorView

  def add_vote(conn, %{"tg_user_id" => tg_user_id, "refran_id" => refran_id, "vote" => vote}) do
    case RefranerServer.Refraner.add_vote(tg_user_id, refran_id, vote) do
      {:ok, _} ->
        send_resp(conn, 201, "")

      {:error, {:not_in_range, error_message, errors}} ->
        conn
        |> put_status(400)
        |> render(ErrorView, "400.json", %{error_message: error_message, errors: errors})

      {:error, {:not_found, error_message, errors}} ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", %{error_message: error_message, errors: errors})

      {:error, err} ->
        send_resp(conn, 500, err)
    end
  end

  def get_user_vote(conn, %{"tg_user_id" => tg_user_id, "refran_id" => refran_id}) do
    with {:ok, _} <- get_refran(refran_id),
         {:ok, vote} <- get_vote(tg_user_id, refran_id) do
      render(conn, "vote.json", %{vote: vote})
    else
      {:error, {:not_found, error_message, errors}} ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", %{error_message: error_message, errors: errors})

      _ ->
        render(conn, ErrorView, "500.json")
    end
  end
end
