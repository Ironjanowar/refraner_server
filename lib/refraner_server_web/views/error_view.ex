defmodule RefranerServerWeb.ErrorView do
  use RefranerServerWeb, :view

  require Logger

  defp basic_error_format(error_code, error_message, errors) do
    %{
      error_code: error_code,
      message: error_message,
      errors: errors
    }
  end

  def render("404.json", %{error_message: error_message, errors: errors}) do
    basic_error_format(404, error_message, errors)
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Page not found"}}
  end

  def render("400.json", %{error_message: error_message, errors: errors}) do
    basic_error_format(400, error_message, errors)
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
