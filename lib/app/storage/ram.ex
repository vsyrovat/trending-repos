defmodule App.Storage.Ram do
  @moduledoc """
  In-memory storage. Don't use directly, use App.Storage instead
  """

  use Agent

  def start_link(_initial_value) do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def set(value) do
    Agent.update(__MODULE__, fn _state -> value end)
  end
end
