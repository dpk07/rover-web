defmodule RoveronlineWeb.RoverControllerTest do
  use RoveronlineWeb.ConnCase

  test "GET /rover", %{conn: conn} do
    conn = get(conn, "/rover")
    assert html_response(conn, 200) =~ "Current Rover Position"
  end

  test "POST /rover.", %{conn: conn} do
    conn = post(conn, Routes.rover_path(conn, :move), direction: "R", steps: "10")
    assert "Moved successfully." = response(conn, 200)
  end

  test "POST /rover with invalid direction", %{conn: conn} do
    conn = post(conn, Routes.rover_path(conn, :move), direction: "Z", steps: "10")
    assert "Invalid input: direction." = response(conn, 400)
  end

  test "POST /rover with invalid steps", %{conn: conn} do
    conn = post(conn, Routes.rover_path(conn, :move), direction: "R", steps: "-10")
    assert "Invalid input: steps." = response(conn, 400)
  end

  test "POST /rover moving outside the grid", %{conn: conn} do
    conn = post(conn, Routes.rover_path(conn, :move), direction: "L", steps: "10000")
    assert "Rover cannot move outside the grid." = response(conn, 400)
  end
end
