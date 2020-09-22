defmodule App.Github.ParserTest do
  use ExUnit.Case
  alias App.Github.Parser
  alias App.Github.Repo

  @correct_repos [
    %Repo{id: "cli/cli"},
    %Repo{id: "gnebbia/kb"},
    %Repo{id: "schollz/croc"},
    %Repo{id: "onevcat/Kingfisher"},
    %Repo{id: "moby/moby"},
    %Repo{id: "matterport/Mask_RCNN"},
    %Repo{id: "google/googletest"},
    %Repo{id: "FreeCAD/FreeCAD"},
    %Repo{id: "iamadamdev/bypass-paywalls-chrome"},
    %Repo{id: "vuejs/vue-next"},
    %Repo{id: "microsoft/onefuzz"},
    %Repo{id: "twintproject/twint"},
    %Repo{id: "lyhue1991/eat_tensorflow2_in_30_days"},
    %Repo{id: "snakers4/silero-models"},
    %Repo{id: "hediet/vscode-debug-visualizer"},
    %Repo{id: "tannerlinsley/react-query"},
    %Repo{id: "proxysu/windows"},
    %Repo{id: "mozilla/send"},
    %Repo{id: "jaywcjlove/linux-command"},
    %Repo{id: "material-shell/material-shell"},
    %Repo{id: "iamkun/dayjs"},
    %Repo{id: "swisskyrepo/PayloadsAllTheThings"},
    %Repo{id: "TheCherno/Hazel"},
    %Repo{id: "HeroTransitions/Hero"},
    %Repo{id: "pytorch/pytorch"}
  ]
  def correct_repos, do: @correct_repos

  def trending_html do
    Path.join(Path.dirname(__ENV__.file), "data/trending.html")
    |> File.read!()
  end

  test "parse trending repos" do
    repos =
      trending_html()
      |> Parser.parse_trending()

    assert repos == {:ok, @correct_repos}
  end
end
