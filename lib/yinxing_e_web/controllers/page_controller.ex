defmodule YinxingEWeb.PageController do
  use YinxingEWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
