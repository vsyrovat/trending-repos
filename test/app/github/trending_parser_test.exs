defmodule App.Github.ParserTest do
  use ExUnit.Case
  alias App.Github.Repo
  alias App.Github.TrendingParser

  @correct_repos [
    %Repo{full_name: "cli/cli", stars_today: 545},
    %Repo{full_name: "gnebbia/kb", stars_today: 253},
    %Repo{full_name: "schollz/croc", stars_today: 363},
    %Repo{full_name: "onevcat/Kingfisher", stars_today: 102},
    %Repo{full_name: "moby/moby", stars_today: 77},
    %Repo{full_name: "matterport/Mask_RCNN", stars_today: 102},
    %Repo{full_name: "google/googletest", stars_today: 125},
    %Repo{full_name: "FreeCAD/FreeCAD", stars_today: 289},
    %Repo{full_name: "iamadamdev/bypass-paywalls-chrome", stars_today: 171},
    %Repo{full_name: "vuejs/vue-next", stars_today: 363},
    %Repo{full_name: "microsoft/onefuzz", stars_today: 178},
    %Repo{full_name: "twintproject/twint", stars_today: 207},
    %Repo{full_name: "lyhue1991/eat_tensorflow2_in_30_days", stars_today: 88},
    %Repo{full_name: "snakers4/silero-models", stars_today: 52},
    %Repo{full_name: "hediet/vscode-debug-visualizer", stars_today: 103},
    %Repo{full_name: "tannerlinsley/react-query", stars_today: 171},
    %Repo{full_name: "proxysu/windows", stars_today: 85},
    %Repo{full_name: "mozilla/send", stars_today: 423},
    %Repo{full_name: "jaywcjlove/linux-command", stars_today: 148},
    %Repo{full_name: "material-shell/material-shell", stars_today: 194},
    %Repo{full_name: "iamkun/dayjs", stars_today: 330},
    %Repo{full_name: "swisskyrepo/PayloadsAllTheThings", stars_today: 242},
    %Repo{full_name: "TheCherno/Hazel", stars_today: 52},
    %Repo{full_name: "HeroTransitions/Hero", stars_today: 72},
    %Repo{full_name: "pytorch/pytorch", stars_today: 163}
  ]
  def correct_repos, do: @correct_repos

  def trending_html do
    Path.join(Path.dirname(__ENV__.file), "data/trending.html")
    |> File.read!()
  end

  test "parse trending repos" do
    repos =
      trending_html()
      |> TrendingParser.parse_trending()

    assert repos == {:ok, @correct_repos}
  end
end
