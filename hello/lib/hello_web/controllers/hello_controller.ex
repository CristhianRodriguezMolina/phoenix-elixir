defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    # Now we pass the messenger value as the third argument of render
    render(conn, "show.html", messenger: messenger)
  end
end
