defmodule AppWeb.ApiView do
  use AppWeb, :view

  def render("404.json", _assigns) do
    "Not found"
  end
end
