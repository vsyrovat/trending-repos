defmodule AppWeb.PageController do
  use AppWeb, :controller

  alias App.Main

  def index(conn, _params) do
    d =
      case Main.get_any_grepo() do
        nil -> nil
        grepo -> grepo.data
      end

    render(conn, "index.html", %{grepo: d})
  end
end
