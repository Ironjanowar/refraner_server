defmodule RefranerServerWeb.RefranesController do
  use RefranerServerWeb, :controller

  alias RefranerServerWeb.ErrorView

  def get_refranes(conn, params) do
    case RefranerServer.Refraner.get_refranes(params) do
      nil ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", %{
          error_message: "No refranes with that filter",
          errors: nil
        })

      refranes ->
        render(conn, "refranes.json", %{
          refranes: refranes
        })
    end
  end
end
