defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  # This plug will be executed only when the action is :index
  plug(HelloWeb.Plugs.Locale, "en" when action in [:index])

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
