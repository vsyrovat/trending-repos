defmodule App.Github.Parser do
  @moduledoc """
  Parse html from trending repo page
  """

  alias App.Github.Repo

  @spec parse_trending(binary) :: {:ok, list(Repo.t())}
  def parse_trending(trending_html) when is_binary(trending_html) do
    {:ok, doc} = Floki.parse_document(trending_html)

    articles = Floki.find(doc, "article.Box-row")
    {:ok, Enum.map(articles, &parse_article(&1))}
  end

  defp parse_article(article) do
    [a | _] = Floki.find(article, "h1.h3 a")
    {"a", attrs, _} = a
    href = href_from_attrs(attrs)

    %Repo{
      full_name: full_name_from_href(href),
      stars_today: stars_today_from_article(article)
    }
  end

  defp href_from_attrs([]), do: nil

  defp href_from_attrs([h | t]) do
    case h do
      {"href", href} -> href
      _ -> href_from_attrs(t)
    end
  end

  defp full_name_from_href("/" <> full_name), do: full_name

  defp stars_today_from_article(article) do
    [span | _] = Floki.find(article, "span:fl-contains('stars today')")
    {"span", _, children} = span
    Enum.map(children, &find_stars_today(&1)) |> Enum.filter(& &1) |> List.first()
  end

  defp find_stars_today(node) when is_binary(node) do
    node = String.trim(node)

    case Regex.run(~r/(?<num>\d+) stars today/, node, capture: [:num]) do
      [num] -> String.to_integer(num)
      nil -> nil
    end
  end

  defp find_stars_today(_), do: nil
end
