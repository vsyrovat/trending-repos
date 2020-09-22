defmodule App.Storage do
  @moduledoc """
  Proxy storage module
  """

  alias App.Storage.Ram

  defdelegate get, to: Ram
  defdelegate set(value), to: Ram
end
