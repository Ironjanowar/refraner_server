defmodule RefranerServer.Refraner.Utils do
  def string_to_integer(id) when is_integer(id), do: id
  def string_to_integer(id) when is_binary(id), do: String.to_integer(id)

  def calculate_new_rate(old_rate, old_votos, new_rate) do
    new_total_votos = old_votos + 1
    new_avarage_rate = (old_rate * old_votos + new_rate) / new_total_votos

    {new_avarage_rate, new_total_votos}
  end
end
