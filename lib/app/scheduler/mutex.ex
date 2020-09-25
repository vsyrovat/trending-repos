defmodule App.Scheduler.Mutex do
  @moduledoc """
  Mutex for App.Scheduler
  """

  use Agent

  def start_link do
    Agent.start_link(fn -> :free end, name: __MODULE__)
  end

  def locked?, do: Agent.get(__MODULE__, & &1) == :lock

  def acquire_lock? do
    Agent.get_and_update(__MODULE__, fn state -> {state, :lock} end) == :free
  end

  def release do
    Agent.update(__MODULE__, fn _ -> :free end)
  end
end
