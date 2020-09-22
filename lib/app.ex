defmodule App do
  @moduledoc """
  App keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias App.Filler
  alias App.Provider

  defdelegate refill_trending_repos, to: Filler
  defdelegate trending_repos, to: Provider
end
