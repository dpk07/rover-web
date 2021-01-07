defmodule RoveronlineWeb.RoverChannelTest do
  use RoveronlineWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      RoveronlineWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(RoveronlineWeb.RoverChannel, "rover:lobby")

    %{socket: socket}
  end

  test "new_msg broadcasts to rover:lobby", %{socket: _socket} do
    RoveronlineWeb.RoverChannel.broadcast_to_all(Rover.init())
    assert_broadcast "new_msg", %{direction: "N", x: 0, y: 0}
  end
end
