defmodule Weather.API do
  use HTTPoison.Base

  @endpoint "https://api.darksky.net"

  def process_url(url) do
    @endpoint <> url
  end

  def process_response_body(body) do
    body
    |> Jason.decode!()
  end
end
