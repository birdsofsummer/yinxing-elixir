defmodule YinxingEWeb.EchoController do
  use YinxingEWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"q" => q}) do
      render(conn, "show.html", q: q)
  end  
end
