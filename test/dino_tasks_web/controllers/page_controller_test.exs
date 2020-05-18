defmodule DinoTasksWeb.LayoutControllerTest do
  use DinoTasksWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "font-sans antialiased"
  end
end
