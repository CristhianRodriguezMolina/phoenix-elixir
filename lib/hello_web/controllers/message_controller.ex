defmodule HelloWeb.MessageController do
  use HelloWeb, :controller

  # This plugs will be executed in every action in order
  plug(:authenticate)
  plug(:fetch_message)
  plug(:authorize_message)

  def show(conn, params) do
    # With conn.assigns[:message] we get the `:message` field in conn
    render(conn, :show, page: conn.assigns[:message])
  end

  defp authenticate(conn, _) do
    case Authenticator.find_user(conn) do
      {:ok, user} ->
        # With this we assign the found user to the :user field in conn struct
        assign(conn, :user, user)

      :error ->
        # The halt(conn) tells Plug that the next plug should not be invoked
        conn |> put_flash(:info, "You must be logged in") |> redirect(to: "/") |> halt()
    end
  end

  defp fetch_message(conn, _) do
    # This was commented due to the function inexistence
    # case find_message(conn.params["id"]) do
    case "Message" do
      nil ->
        # The halt(conn) tells Plug that the next plug should not be invoked
        conn |> put_flash(:info, "That message wasn't found") |> redirect(to: "/") |> halt()

      message ->
        # With this we assign the message to the :message field in conn struct
        assign(conn, :message, message)
    end
  end

  defp authorize_message(conn, _) do
    if Authorizer.can_access?(conn.assigns[:user], conn.assigns[:message]) do
      # If everything is alright just returns the conn
      conn
    else
      # The halt(conn) tells Plug that the next plug should not be invoked
      conn |> put_flash(:info, "You can't access that page") |> redirect(to: "/") |> halt()
    end
  end
end
