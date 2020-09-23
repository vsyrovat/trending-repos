defmodule App.Github.ParserTest do
  use ExUnit.Case
  alias App.Github.Parser
  alias App.Github.Repo

  @correct_repos [
    %Repo{full_name: "cli/cli"},
    %Repo{full_name: "gnebbia/kb"},
    %Repo{full_name: "schollz/croc"},
    %Repo{full_name: "onevcat/Kingfisher"},
    %Repo{full_name: "moby/moby"},
    %Repo{full_name: "matterport/Mask_RCNN"},
    %Repo{full_name: "google/googletest"},
    %Repo{full_name: "FreeCAD/FreeCAD"},
    %Repo{full_name: "iamadamdev/bypass-paywalls-chrome"},
    %Repo{full_name: "vuejs/vue-next"},
    %Repo{full_name: "microsoft/onefuzz"},
    %Repo{full_name: "twintproject/twint"},
    %Repo{full_name: "lyhue1991/eat_tensorflow2_in_30_days"},
    %Repo{full_name: "snakers4/silero-models"},
    %Repo{full_name: "hediet/vscode-debug-visualizer"},
    %Repo{full_name: "tannerlinsley/react-query"},
    %Repo{full_name: "proxysu/windows"},
    %Repo{full_name: "mozilla/send"},
    %Repo{full_name: "jaywcjlove/linux-command"},
    %Repo{full_name: "material-shell/material-shell"},
    %Repo{full_name: "iamkun/dayjs"},
    %Repo{full_name: "swisskyrepo/PayloadsAllTheThings"},
    %Repo{full_name: "TheCherno/Hazel"},
    %Repo{full_name: "HeroTransitions/Hero"},
    %Repo{full_name: "pytorch/pytorch"}
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
