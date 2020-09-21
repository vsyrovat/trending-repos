defmodule App.Github.Parser do
  @moduledoc """
  Parse html from trending repo page
  """

  use TypedStruct

  defmodule Repo do
    @moduledoc false
    typedstruct enforce: true do
      field :id, String.t()
    end
  end

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
    %Repo{id: id_from_href(href)}
  end

  defp href_from_attrs([]), do: nil

  defp href_from_attrs([h | t]) do
    case h do
      {"href", href} -> href
      _ -> href_from_attrs(t)
    end
  end

  defp id_from_href("/" <> id), do: id
end
