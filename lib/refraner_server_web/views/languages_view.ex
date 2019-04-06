defmodule RefranerServerWeb.LanguagesView do
  use RefranerServerWeb, :view

  def render("languages.json", %{languages: languages}), do: languages
end
