defmodule HelloWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  # Default or options passed to the plug in its utilization
  def init(default), do: default

  # Here we are getting the locale param from the params (I.E. http://localhost:4000/?locale=fr, `locale` = `fr`)
  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    # With this function we save data in the conn data struct
    assign(conn, :locale, loc)
  end

  def call(conn, default) do
    # With this function we save data in the conn data struct
    assign(conn, :locale, default)
  end
end
