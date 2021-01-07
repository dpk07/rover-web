defmodule RoveronlineWeb.RoverController do
  use RoveronlineWeb, :controller

  def index(conn, _params) do
    rover = Rover.Server.get_current_state()
    render(conn, "index.html", Map.from_struct(rover))
  end

  def move(conn, _params = %{"direction" => direction, "steps" => steps}) do
    {steps, _} = Integer.parse(steps)

    case Rover.Server.move(direction, steps) do
      {:ok, rover} ->
        RoveronlineWeb.RoverChannel.broadcast_to_all(rover)
        conn |> send_resp(200, "Moved successfully.")

      error ->
        conn |> handle_error(error)
    end
  end

  def move(conn, _params), do: conn |> send_resp(400, "Invalid input.")

  defp handle_error(conn, error) do
    case error do
      {:error, :invalid_input, :direction} ->
        conn |> send_resp(400, "Invalid input: direction.")

      {:error, :invalid_input, :steps} ->
        conn |> send_resp(400, "Invalid input: steps.")

      {:error, :invalid_operation, :position_out_of_bounds} ->
        conn |> send_resp(400, "Rover cannot move outside the grid.")
    end
  end
end
