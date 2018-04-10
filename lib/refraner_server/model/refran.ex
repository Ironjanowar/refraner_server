defmodule RefranerServer.Model.Refran do
  use Ecto.Schema

  schema "refranes" do
    field(:refran, :string)
    field(:significado, :string)
    field(:ideas_clave, :string)
    field(:tipo, :string)
    field(:marcador_de_uso, :string)
    field(:comentario_marcador_de_uso, :string)
    field(:observaciones, :string)
    field(:observaciones_lexicas, :string)
    field(:idioma, :string)
    field(:idioma_codigo, :string)
    field(:traduccion_literal, :string)
  end
end
