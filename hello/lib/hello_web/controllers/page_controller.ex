defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  # This plug will be executed only when the action is :index
  plug(HelloWeb.Plugs.Locale, "en" when action in [:index])

  def index(conn, _params) do
    # Connection
    conn

    # The default layout is the index.html.heex layout
    # so we can change the layout for a render with the next function
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")

    # Change the default layout
    # |> put_root_layout("admin.html")

    # Change the response content type
    # |> put_resp_content_type("text/html")

    # For .text files is necessary to have a file like this *.text.eex not *.text.heex
    |> render(:index)

    # Responds with status and a message
    # |> send_resp(201, "")
  end

  # Rendering a json message
  def show(conn, _params) do
    pages = [%{title: "foo"}, %{title: "bar"}]

    render(conn, "show.json", pages: pages)
  end

  def test(conn, _params) do
    render(conn, "test.html")
  end
end
