defmodule WeatherWeb.WeatherController do
  use WeatherWeb, :controller

  def index(conn, %{"latitude" => latitude, "longitude" => longitude}) do
    case Weather.get_weather(latitude, longitude) do
      {:ok, result} ->
        conn |> json(result)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Bad request"})
  end
end
