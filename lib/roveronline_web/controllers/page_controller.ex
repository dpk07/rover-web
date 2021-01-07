defmodule RoveronlineWeb.PageController do
  use RoveronlineWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
