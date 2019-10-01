defmodule WeatherWeb.WeatherControllerTest do
  use WeatherWeb.ConnCase

  test "get some weather", %{conn: conn} do
    conn = get(conn, "/weather?latitude=-33.918861&longitude=18.423300")

    body = conn |> response(200) |> Jason.decode!()

    assert Map.keys(body) == [
             "daily",
             "date",
             "description",
             "precip_prob",
             "temperature",
             "type",
             "wind"
           ]
  end
end
