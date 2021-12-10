defmodule HelloWeb.PageView do
  use HelloWeb, :view

  def render("show.json", %{pages: pages}) do
    %{data: Enum.map(pages, fn page -> %{title: page.title} end)}
  end

  def handler_info(conn) do
    "Request Hanlded By: #{controller_module(conn)}.#{action_name(conn)}"
  end

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end
end
