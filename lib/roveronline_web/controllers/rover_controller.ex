defmodule RoveronlineWeb.RoverController do
  use RoveronlineWeb, :controller

  def index(conn, _params) do
    rover_map = Rover.Server.get_current_state() |> Map.from_struct
    render(conn, "index.html", rover_map)
  end

  def move(conn, _params = %{"direction" => direction, "steps" => steps}) do
    {steps, _} = Integer.parse(steps)

    case Rover.Server.move(direction, steps) do
      {:ok, rover} -> RoveronlineWeb.RoverChannel.broadcast_to_all(rover)
                      conn |> send_resp(200, "Moved successfully.")

      error -> conn |> handle_error(error)
    end
  end

  def move(conn, _params), do: conn |> send_resp(400, "Invalid input.")

  defp handle_error(conn, {:error, :invalid_input, :direction}), do: conn |> send_resp(400, "Invalid input: direction.")

  defp handle_error(conn, {:error, :invalid_input, :steps}), do: conn |> send_resp(400, "Invalid input: steps.")

  defp handle_error(conn, {:error, :invalid_operation, :position_out_of_bounds}), do: conn |> send_resp(400, "Rover cannot move outside the grid.")
end
