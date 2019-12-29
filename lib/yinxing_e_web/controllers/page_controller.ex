'''
https://hexdocs.pm/phoenix/controllers.html#content
'''

defmodule YinxingEWeb.MyFallbackController do
  use Phoenix.Controller
  alias YinxingEWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render(:"403")
  end

end


defmodule YinxingEWeb.PostFinder do
  use Plug
  import Plug.Conn

  alias YinxingE.Blog

  def init(opts), do: opts

  def call(conn, _) do
    case Blog.get_post(conn.params["id"]) do
      {:ok, post} ->
        assign(conn, :post, post)
      {:error, :notfound} ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end
end






defmodule YinxingEWeb.PageController do

  use YinxingEWeb, :controller
  #plug :assign_welcome_message, "Welcome Back"
  plug :assign_welcome_message, "Hi!" when action in [:index, :show]

  alias YinxingE.{Authorizer, Blog}
  action_fallback YinxingEWeb.MyFallbackController  

  def index(conn, params) do
 #   render(conn, "index.html")
    conn
 #  |> put_status(202)    
 #  |> put_status(:not_found)
 #  |> assign(:message, "mmm")
 #  |> assign(:name, "nnnn")    
 #  |> render("index.html")
 #   text(conn, "滴滴滴di")
 #   json(conn, %{id: 123})
    render(conn, "index.html", message: params["message"])
  end

  def goto(conn, _params) do
    redirect(conn, to: Routes.res_json_url(conn, :res_goto))
  end

  def res_toto1(conn, _params) do
    u="https://elixir-lang.org/"
    redirect(conn, external: u)
  end

  def res_goto(conn, _params) do
       redirect(conn, to: "/ccc")
  end
  def res_json(conn, _params) do
        t= "application/json; charset=utf-8"
        conn
        |> put_resp_content_type(t)
        |> send_resp(201, '{"x":123}')
  end

  def error404(conn, _params) do
      conn
      |> put_status(:not_found)
      |> put_view(HelloWeb.ErrorView)
      |> render("404.html")
  end


  def error404_1(conn, _params) do
      conn
      |> send_resp(404, "Not found")
      |> halt()
  end


  def res_xml() do
#      x=...
#      conn
#      |> put_resp_content_type("text/xml")
#      |> render("index.xml", content: x)
  end

  def res_201(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(201, "ccc")

  end


  def index1(conn, _params) do
    conn
    |> assign(:message, "mmm")
    |> assign(:name, "nnnn")    
    |> render("index.html")
  end

  def index2(conn, _params) do
    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html")
  end


  def show(conn, %{"id" => id}, current_user) do
    with {:ok, post} <- Blog.fetch_post(id),
         :ok <- Authorizer.authorize(current_user, :view, post) do
      render(conn, "show.json", post: post)
    end
  end

  def show1(conn, %{"id" => id}) do
     text(conn, "Showing id #{id}")
  end

  def show1(conn, %{"id" => id}) do
      json(conn, %{id: id})
  end

  def show2(conn, %{"id" => id}) do
    html(conn, """
       <html>
         <head>
            <title>Passing an Id</title>
         </head>
         <body>
           <p>You sent in id #{id}</p>
         </body>
       </html>
      """)
  end
  def show3(conn, %{"q" => q}) do
    render(conn, "show.html", q: q)
  end  

  #http://localhost:4000/?message=123
  def show4(conn, params) do
    render(conn, "index.html", message: params["message"])
  end  

  defp assign_welcome_message(conn, msg) do
    assign(conn, :message, msg)
    assign(conn, :name, :zzz)
  end

  def post_authorization_plug(%{halted: true} = conn, _), do: 
    #conn
  end

end
