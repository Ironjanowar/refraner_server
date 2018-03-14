defmodule RefranerServer.Model.Refran do
  use Ecto.Schema

  alias __MODULE__

  schema "refranes" do
    field(:refran, :string)
    field(:significado, :string)
    field(:rate, :float)
    field(:total_votos, :integer)
    field(:ideas_clave, :string)
    field(:marcador_de_uso, :string)
    field(:tipo, :string)
  end

  def update_rate(%Refran{} = refran, params \\ %{}) do
    refran
    |> Ecto.Changeset.cast(params, [:rate, :total_votos])
  end
end
