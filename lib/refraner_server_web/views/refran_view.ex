defmodule RefranerServerWeb.RefranView do
  use RefranerServerWeb, :view

  def render("refran.json", %{refran: refran}) do
    refran_json(refran)
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
