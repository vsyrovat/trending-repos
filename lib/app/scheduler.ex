defmodule App.Scheduler do
  @moduledoc """
  Scheduler for refilling Storage with trending repos
  """

  use GenServer

  require Logger

  alias App.Scheduler.Mutex

  @schedule_period_seconds 3600

  # General

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl GenServer
  def init(state) do
    Mutex.start_link()
    true = Mutex.acquire_lock?()
    send(self(), :work)
    {:ok, state}
  end

  # Api

  def run_work do
    if Mutex.acquire_lock?(), do: GenServer.cast(__MODULE__, :work)
  end

  def running?, do: Mutex.locked?()

  # Callbacks

  @impl GenServer
  def handle_cast(:work, state) do
    work()
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(:work, state) do
    work()
    schedule_work(@schedule_period_seconds)
    {:noreply, state}
  end

  # Private

  defp work do
    App.Filler.refill()
    Mutex.release()
  end

  defp schedule_work(seconds) do
    Process.send_after(self(), :work, seconds * 1000)
  end
end
