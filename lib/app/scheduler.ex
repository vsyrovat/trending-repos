defmodule App.Scheduler do
  @moduledoc """
  Scheduler for refilling Storage with trending repos
  """

  use GenServer

  @schedule_period_seconds 3600

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl GenServer
  def init(state) do
    send(self(), :work)
    {:ok, state}
  end

  @impl GenServer
  def handle_info(:work, state) do
    work()
    schedule_work(@schedule_period_seconds)
    {:noreply, state}
  end

  defp work do
    App.Filler.refill_trending_repos()
  end

  defp schedule_work(seconds) do
    Process.send_after(self(), :work, seconds * 1000)
  end
end
