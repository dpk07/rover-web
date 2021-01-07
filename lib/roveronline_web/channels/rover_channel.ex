defmodule RoveronlineWeb.RoverChannel do
  use Phoenix.Channel

  def join("rover:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("rover:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  @doc """
  Broadcasts the current location of the rover to all the connected devices of rover:lobby channel.
  """
  def broadcast_to_all(rover) do
    RoveronlineWeb.Endpoint.broadcast("rover:lobby", "new_msg", Map.from_struct(rover))
  end
end
