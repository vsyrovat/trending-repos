defmodule App.Github.RepositoryFetcher do
  use TypedStruct
  use Tesla

  plug Tesla.Middleware.FollowRedirects, max_redirects: 1
  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, headers()
  plug Tesla.Middleware.JSON

  defmodule Repo do
    @moduledoc false
    typedstruct enforce: true do
      field :id, integer()
      field :full_name, String.t()
      field :data, map()
    end
  end

  defmodule Limit do
    @moduledoc false
    typedstruct enforce: true do
      field :limit, integer()
      field :remain, integer()
      field :reset_at, integer()
    end
  end

  defp headers do
    default = [{"User-Agent", "Tesla"}]

    case token = Application.get_env(:app, :github_api_token) do
      nil -> default
      _ -> default ++ [{"Authorization", "token #{token}"}]
    end
  end

  def fetch(full_name) when is_binary(full_name) do
    unless String.match?(full_name, ~r|[^/]+/[^/]+|),
      do: raise(ArgumentError, message: "Argument should match the pattern \"{owner}/{repo}\"")

    {:ok, github_response} = get("/repos/#{full_name}")

    case github_response do
      %Tesla.Env{status: 200} ->
        {:ok, repo(github_response), limit(github_response)}

      %Tesla.Env{status: 404} ->
        {:error, :repo_private}

      %Tesla.Env{status: 403} ->
        case l = limit(github_response) do
          %Limit{remain: 0} -> {:error, :limit_exceeded, l}
          _ -> {:error, :forbidden}
        end

      _ ->
        {:error, github_response}
    end
  end

  defp repo(%Tesla.Env{status: 200, body: body}) do
    %Repo{id: body["id"], full_name: body["full_name"], data: body}
  end

  defp limit(%Tesla.Env{headers: headers}) do
    headers = Enum.into(headers, %{})

    {limit, ""} = Integer.parse(headers["x-ratelimit-limit"])
    {remain, ""} = Integer.parse(headers["x-ratelimit-remaining"])
    {reset_at_unix, ""} = Integer.parse(headers["x-ratelimit-reset"])
    reset_at = DateTime.from_unix!(reset_at_unix)
    %Limit{limit: limit, remain: remain, reset_at: reset_at}
  end
end
