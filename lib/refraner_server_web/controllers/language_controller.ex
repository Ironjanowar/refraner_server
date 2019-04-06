defmodule RefranerServerWeb.LanguagesController do
  use RefranerServerWeb, :controller

  def get_languages(conn, _params) do
    languages = RefranerServer.Refraner.get_languages()
    render(conn, "languages.json", %{languages: languages})
  end
end
