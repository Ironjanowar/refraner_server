defmodule RefranerServerWeb.Router do
  use RefranerServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api/refranes", RefranerServerWeb do
    pipe_through(:api)

    get("/", RefranesController, :get_refranes)
    get("/:refran_id", RefranController, :get_refran)

    post("/:refran_id/vote", VoteController, :add_vote)
    get("/:refran_id/vote/user/:tg_user_id", VoteController, :get_user_vote)
  end

  scope "/api", RefranerServerWeb do
    pipe_through(:api)

    get("/languages", LanguagesController, :get_languages)
  end
end
