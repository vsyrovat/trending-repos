defmodule AppWeb.ApiController do
  use AppWeb, :controller

  alias App.Main
  alias App.Scheduler

  require Logger

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

  def cmd_refill(conn, _) do
    if Scheduler.running?() do
      json(conn, "Already running")
    else
      Scheduler.run_work()
      :timer.sleep(25)

      if Scheduler.running?(),
        do: json(conn, "Started"),
        else: json(conn, "Started and finished (probably nothing to do)")
    end
  end
end
