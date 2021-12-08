defmodule HelloWeb.PageControllerTest do
  use HelloWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    # Asserts that it contains the string `Welcome to Phoenix!`
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
