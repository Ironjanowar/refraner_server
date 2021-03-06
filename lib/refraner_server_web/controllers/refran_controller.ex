defmodule RefranerServerWeb.RefranController do
  use RefranerServerWeb, :controller

  alias RefranerServerWeb.ErrorView

  def get_refran(conn, %{"refran_id" => refran_id}) do
    case RefranerServer.Refraner.get_refran(refran_id) do
      {:ok, refran} ->
        render(conn, "refran.json", %{refran: refran})

      {:error, {:not_found, error_message, errors}} ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", %{error_message: error_message, errors: errors})
    end
  end
end
