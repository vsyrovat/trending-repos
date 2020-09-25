defmodule AppWeb.ApiController do
  use AppWeb, :controller

  alias App.Main

  def trending(conn, _params) do
    {:ok, repos} = App.trending_repos()
    json(conn, repos)
  end

  def repo(conn, %{"id" => id}) do
    case Main.get_grepo(String.to_integer(id)) do
      nil -> render(conn, "404.json")
      grepo -> json(conn, grepo.data)
    end
  end

  def repo(conn, %{"owner" => owner, "name" => name}) do
    case Main.get_grepo("#{owner}/#{name}") do
      nil -> render(conn, "404.json")
      grepo -> json(conn, grepo.data)
    end
  end
end
