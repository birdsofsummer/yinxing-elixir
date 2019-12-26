defmodule YinxingEWeb.Router do
  use YinxingEWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", YinxingEWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/echo", EchoController, :index
    # "http://localhost:4000/echo:ccc"
    # "http://localhost:4000/echo/ccc"
    get "/echo:q", EchoController, :show
    get "/echo/:q", EchoController, :show

  end

  # Other scopes may use custom stacks.
   scope "/api", YinxingEWeb do
     pipe_through :api
     # get "/api/echo" EchoController, :index
   end
end
