defmodule AppWeb.ApiController do
  use AppWeb, :controller

  def trending(conn, _params) do
    {:ok, repos} = App.trending_repos()
    json(conn, repos)
  end
end
