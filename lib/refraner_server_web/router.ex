defmodule RefranerServerWeb.Router do
  use RefranerServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api/refran", RefranerServerWeb do
    pipe_through(:api)

    get("/random", RefranController, :get_random_refran)
    get("/:refran_id", RefranController, :get_refran)
  end
end
