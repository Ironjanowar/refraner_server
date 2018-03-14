defmodule RefranerServer.Refraner do
  import RefranerServer.Refraner.Utils
  import Ecto.Query, only: [from: 2]

  def get_random_refran() do
    q =
      from(refran in RefranerServer.Model.Refran, order_by: [asc: fragment("RANDOM()")], limit: 1)

    RefranerServer.Repo.one(q)
  end

  def get_refran(id) do
    id = id_to_integer(id)
    RefranerServer.Model.Refran |> RefranerServer.Repo.get(id)
  end

  def add_rating(refran_id, new_rate) do
    refran_id = id_to_integer(refran_id)
    new_rate = String.to_integer(new_rate)
    %{rate: rate, total_votos: total_votos} = refran = get_refran(refran_id)
    {new_rate, new_total_votos} = calculate_new_rate(rate, total_votos, new_rate)

    RefranerServer.Model.Refran.update_rate(refran, %{
      rate: new_rate,
      total_votos: new_total_votos
    })
    |> RefranerServer.Repo.update()
  end
end
