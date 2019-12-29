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

defmodule YinxingEWeb.EchoController do

  use YinxingEWeb, :controller

  def index(conn, _params) do
        render(conn, "index.html")
  end

  def show(conn, _params) do
        render(conn, "index.html")
       #render(conn, :show, page: find_message(params["id"]))
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

end


