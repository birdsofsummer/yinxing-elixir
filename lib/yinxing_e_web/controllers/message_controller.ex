'''
      resources "/echo", EchoController
      GET/POST/PATCH/PUT/DELETE
     "_csrf_token" conn.body_params 

     crud

     + index
     + edit
     + new
     + show
     + create
     + update
     + delete

      echo  GET     /echo            EchoController :index
      echo  GET     /echo/:id/edit   EchoController :edit
      echo  GET     /echo/new        EchoController :new
      echo  GET     /echo/:id        EchoController :show
      echo  POST    /echo            EchoController :create
      echo  PATCH   /echo/:id        EchoController :update
      echo  PUT     /echo/:id        EchoController :update
      echo  DELETE  /echo/:id        EchoController :delete
'''

defmodule YinxingEWeb.MessageController do

  use YinxingEWeb, :controller

  plug :authenticate
  plug :fetch_message
  plug :authorize_message

  def find_message(id) do
      id
  end

  def index(conn, _params) do
        render(conn, "index.html")
  end

  def show(conn, params) do
    case authenticate(conn,params) do
      {:ok, user} ->
        case find_message(params["id"]) do
          nil ->
            conn 
            |> put_flash(:info, "That message wasn't found") 
            |> redirect(to: "/")
          message ->
            case authorize_message(conn, params["id"]) do
              :ok ->
                render(conn, :show, page: find_message(params["id"]))
              :error ->
                conn 
                |> put_flash(:info, "You can't access that page") 
                |> redirect(to: "/")
            end
        end
      :error ->
        conn 
        |> put_flash(:info, "You must be logged in") 
        |> redirect(to: "/")
    end
  end


  def show1(conn, %{"q" => q,"x" => x } =  params) do
        render(conn, "show.html", q: q, x: x )
  end  

  def edit(conn, _params) do
        render(conn, "index.html")
  end

  def new(conn, _params) do
        render(conn, "index.html")
  end


  def create(conn, _params) do
        render(conn, "index.html")
  end

  def update(conn, _params) do
        render(conn, "index.html")
  end

  def delete(conn, _params) do
        render(conn, "index.html")
  end

  defp authenticate(conn, _) do
    case Authenticator.find_user(conn) do
      {:ok, user} ->
        assign(conn, :user, user)
      :error ->
        conn 
        |> put_flash(:info, "You must be logged in") 
        |> redirect(to: "/") 
        |> halt()
    end
  end

  defp fetch_message(conn, _) do
    case find_message(conn.params["id"]) do
      nil ->
        conn 
        |> put_flash(:info, "That message wasn't found") 
        |> redirect(to: "/") 
        |> halt()
      message ->
        assign(conn, :message, message)
    end
  end

  defp authorize_message(conn, _) do
    if Authorizer.can_access?(conn.assigns[:user], conn.assigns[:message]) do
      conn
    else
      conn 
      |> put_flash(:info, "You can't access that page") 
      |> redirect(to: "/") 
      |> halt()
    end
  end
end


