defmodule RefranerServerWeb.RefranesView do
  use RefranerServerWeb, :view

  def render("refranes.json", %{refranes: refranes}) do
    refranes |> Enum.map(&refran_json/1)
  end

  @refran_json_fields [
    :id,
    :refran,
    :significado,
    :rate,
    :total_votos,
    :ideas_clave,
    :marcador_de_uso,
    :tipo
  ]
  def refran_json(refran) do
    Map.take(refran, @refran_json_fields)
  end
end
