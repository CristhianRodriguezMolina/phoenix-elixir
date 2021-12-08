defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    # Now we pass the messenger value as the third argument of render
    conn

    # The default layout is the index.html.heex layout
    # so we can change the layout for a render with the next function
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")

    # Assigning the values
    |> assign(:messenger, messenger)
    |> assign(:receiver, "Babushka")

    # Putting a status 202 to the message
    |> put_status(202)
    |> render("show.html")
  end
end
