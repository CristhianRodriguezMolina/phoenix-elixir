defmodule HelloWeb.RoomChannelTest do
  use HelloWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      HelloWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(HelloWeb.RoomChannel, "room:lobby")

    %{socket: socket}
  end

<<<<<<< HEAD
  @tag :not_used
  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    # Asserts that the server sends an asynchronous reply
    assert_reply(ref, :ok, %{"hello" => "there"})
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    # Emulate the client pushin a message to the channel
    push(socket, "new_msg", %{"body" => "all"})
    # This asserts that a message was broadcast in the PubSub system.
    assert_broadcast("new_msg", %{body: "all"})
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push("broadcast", %{"some" => "data"})
=======
  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
>>>>>>> main
  end
end
