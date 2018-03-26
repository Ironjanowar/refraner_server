defmodule RefranerServer.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add(:tg_user_id, :integer, null: false)
      add(:refran_id, references("refranes"), null: false)
      add(:vote, :integer, null: false)
    end
  end
end
