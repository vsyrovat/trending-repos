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
end
