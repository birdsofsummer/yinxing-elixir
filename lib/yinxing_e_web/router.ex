'''
https://hexdocs.pm/phoenix/routing.html#content
'''



defmodule YinxingEWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end
  def call(conn, default), do: assign(conn, :locale, default)
end



defmodule YinxingEWeb.Router do
  use YinxingEWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug YinxingEWeb.Plugs.Locale, "en"
    plug :cors
    plug :put_headers,%{"token": "123"} 
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :cors
    plug :put_headers,%{token: "123"} 
  end

  pipeline :token_checks do
    #plug :ensure_authenticated_user
  end

  scope "/", YinxingEWeb do
    pipe_through :browser
    get "/", PageController, :index 
    get "/goto", PageController, :res_json, as: :res_json    
    get "ccc", PageController, :res_json
    get "/echo", EchoController, :index
    get "/echo:q", EchoController, :show1
    get "/echo/:q", EchoController, :show1
    post "/echo/:q", EchoController, :show1
  end

  scope "/api", YinxingEWeb, as: :api do
    pipe_through :browser

    scope "/v1", as: :v1 do
          scope "/guest" , as: :admin do

              resources "/user", EchoController 
              resources "/blog", EchoController
              resources "/comments", EchoController
              resources "/music", EchoController

              get "/", PageController, :index
              get "/echo", EchoController, :index
              get "/echo:q", EchoController, :show1
              get "/echo/:q", EchoController, :show1
              post "/echo/:q", EchoController, :show1

          end
          scope "/admin" , as: :admin do
                  resources "/user", EchoController
                  resources "/blog", EchoController
                  resources "/comments", EchoController
          end
    end
  end

  scope "/admin",YinxingEWeb, as: :admin do
      pipe_through [:browser,]
      resources "/user", EchoController
      resources "/blog", EchoController
      resources "/comments", EchoController
  end

  scope "/v1", YinxingEWeb, as: :v1 do
      pipe_through :browser
      resources "/user", EchoController 
      resources "/blog", EchoController
      resources "/comments", EchoController
  end

#  scope "/v2", YinxingEWeb.V2, as: :v2 do
#      resources "/user", EchoController  
#      resources "/blog", EchoController
#      resources "/comments", EchoController
#  end



    def put_headers(conn, key_values) do
          Enum.reduce key_values, conn, fn {k, v}, conn ->
            Plug.Conn.put_resp_header(conn, to_string(k), v)
          end
    end

    def cors(conn,_) do
         ah=["X-TOKEN","Content-Type"] |>Enum.join(",")
         am=["HEAD","POST","GET","OPTIONS","PATCH","PUT","DELETE"]|>Enum.join(",")
         ao="*"
         IO.puts(am)
         h=%{ 
                content_encoding: "gzip",  
                cache_control: "max-age=3600", 
                "Access-Control-Max-Age": "86400",
                "Access-Control-Allow-Origin": ao,
                "Access-Control-Allow-Headers": ah, 
                "Access-Control-Request-Method": am,
         }
        put_headers(conn,h)
    end


end



