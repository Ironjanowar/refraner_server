defmodule RefranerServerWeb.RefranController do
  use RefranerServerWeb, :controller

  def get_random_refran(conn, _params) do
    render(conn, "refran.json", %{refran: RefranerServer.Refraner.get_random_refran()})
  end

  def get_refran(conn, %{"refran_id" => refran_id}) do
    render(conn, "refran.json", %{refran: RefranerServer.Refraner.get_refran(refran_id)})
  end

  def add_rating(conn, %{"refran_id" => refran_id, "rate" => new_rate}) do
    case RefranerServer.Refraner.add_rating(refran_id, new_rate) do
      {:ok, refran} -> render(conn, "refran.json", %{refran: refran})
      _ -> render(conn, "500.json")
    end
  end
end
