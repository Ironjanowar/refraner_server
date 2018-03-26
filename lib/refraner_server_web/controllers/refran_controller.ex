defmodule RefranerServerWeb.RefranController do
  use RefranerServerWeb, :controller

  def get_random_refran(conn, _params) do
    render(conn, "refran.json", %{refran: RefranerServer.Refraner.get_random_refran()})
  end

  def get_refran(conn, %{"refran_id" => refran_id}) do
    render(conn, "refran.json", %{refran: RefranerServer.Refraner.get_refran(refran_id)})
  end
end
