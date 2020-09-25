defmodule App.MainTest do
  use App.DataCase

  alias App.Main

  describe "trending_lists" do
    alias App.Main.TrendingList

    @valid_data [%{"a" => "b", "nested" => %{"d" => "e"}}, %{"a" => "c"}]
    @valid_attrs %{id: 1, data: @valid_data}
    @update_attrs %{id: 1, data: []}
    @invalid_attrs %{id: nil, data: nil}

    def trending_list_fixture(attrs \\ %{}) do
      {:ok, trending_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Main.create_trending_list()

      trending_list
    end

    test "list_trending_lists/0 returns all trending_lists" do
      trending_list = trending_list_fixture()
      assert Main.list_trending_lists() == [trending_list]
    end

    test "get_trending_list!/1 returns the trending_list with given id" do
      trending_list = trending_list_fixture()
      assert Main.get_trending_list!(trending_list.id) == trending_list
    end

    test "create_trending_list/1 with valid data creates a trending_list" do
      assert {:ok, %TrendingList{} = trending_list} = Main.create_trending_list(@valid_attrs)
      assert trending_list.data == @valid_data
    end

    test "create_trending_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_trending_list(@invalid_attrs)
    end

    test "update_trending_list/2 with valid data updates the trending_list" do
      trending_list = trending_list_fixture()
      assert {:ok, %TrendingList{} = trending_list} = Main.update_trending_list(trending_list, @update_attrs)
      assert trending_list.data == []
    end

    test "update_trending_list/2 with invalid data returns error changeset" do
      trending_list = trending_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_trending_list(trending_list, @invalid_attrs)
      assert trending_list == Main.get_trending_list!(trending_list.id)
    end

    test "delete_trending_list/1 deletes the trending_list" do
      trending_list = trending_list_fixture()
      assert {:ok, %TrendingList{}} = Main.delete_trending_list(trending_list)
      assert_raise Ecto.NoResultsError, fn -> Main.get_trending_list!(trending_list.id) end
    end

    test "change_trending_list/1 returns a trending_list changeset" do
      trending_list = trending_list_fixture()
      assert %Ecto.Changeset{} = Main.change_trending_list(trending_list)
    end
  end

  describe "grepos" do
    alias App.Main.Grepo

    @valid_attrs %{id: 1, data: %{}, full_name: "some full_name"}
    @update_attrs %{id: 1, data: %{}, full_name: "some updated full_name"}
    @invalid_attrs %{id: nil, data: nil, full_name: nil}

    def grepo_fixture(attrs \\ %{}) do
      {:ok, grepo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Main.create_grepo()

      grepo
    end

    test "list_grepos/0 returns all grepos" do
      grepo = grepo_fixture()
      assert Main.list_grepos() == [grepo]
    end

    test "list_grepos_by_full_names/1 return matched grepos" do
      grepo1 = grepo_fixture()
      grepo2 = grepo_fixture(%{id: 2, data: %{}, full_name: "other full_name"})
      assert Main.list_grepos() == [grepo1, grepo2]
      assert Main.list_grepos_by_full_names(["some full_name"]) == [grepo1]
    end

    test "get_grepo!/1 returns the grepo with given id" do
      grepo = grepo_fixture()
      assert Main.get_grepo!(grepo.id) == grepo
    end

    test "create_grepo/1 with valid data creates a grepo" do
      assert {:ok, %Grepo{} = grepo} = Main.create_grepo(@valid_attrs)
      assert grepo.data == %{}
      assert grepo.full_name == "some full_name"
    end

    test "create_grepo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_grepo(@invalid_attrs)
    end

    test "update_grepo/2 with valid data updates the grepo" do
      grepo = grepo_fixture()
      assert {:ok, %Grepo{} = grepo} = Main.update_grepo(grepo, @update_attrs)
      assert grepo.data == %{}
      assert grepo.full_name == "some updated full_name"
    end

    test "update_grepo/2 with invalid data returns error changeset" do
      grepo = grepo_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_grepo(grepo, @invalid_attrs)
      assert grepo == Main.get_grepo!(grepo.id)
    end

    test "delete_grepo/1 deletes the grepo" do
      grepo = grepo_fixture()
      assert {:ok, %Grepo{}} = Main.delete_grepo(grepo)
      assert_raise Ecto.NoResultsError, fn -> Main.get_grepo!(grepo.id) end
    end

    test "change_grepo/1 returns a grepo changeset" do
      grepo = grepo_fixture()
      assert %Ecto.Changeset{} = Main.change_grepo(grepo)
    end
  end
end
