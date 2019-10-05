defmodule Weather do
  @moduledoc """
  Weather module is implemented as a stand alone module.

  Controller call this module instead of calling API itself - better this way as then the two aren't coupled.
  """

  # Fetch module depending on the environment we are in
  # When this is called in a testing environment we use a mock api
  @weather_api Application.get_env(:weather, :weather_api)

  def get_weather(lat, lon) do
    api_key = System.get_env("API_KEY")
    url = "/forecast/#{api_key}/#{lat},#{lon}"

    case @weather_api.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body} |> parse

      {:ok, %HTTPoison.Response{body: %{"code" => _code, "error" => error}}} ->
        {:error, error} |> parse
    end
  end

  def parse({:ok, body}) do
    {:ok, body |> transform}
  end

  def parse({:error, reason}) do
    {:error, reason}
  end

  def transform(%{
        "currently" => %{
          "time" => time,
          "icon" => icon,
          "summary" => summary,
          "temperature" => temperature,
          "windSpeed" => windSpeed,
          "windBearing" => windBearing,
          "precipProbability" => precipProbability
        },
        "daily" => %{"data" => daily}
      }) do
    %{
      "date" => time |> transform_time_to_date,
      "type" => icon,
      "description" => summary,
      "temperature" => temperature,
      "precip_prob" => precipProbability,
      "wind" => %{
        "speed" => windSpeed,
        "bearing" => windBearing
      },
      "daily" => daily |> Enum.map(&(&1 |> transform_daily))
    }
  end

  def transform_daily(%{
        "time" => time,
        "summary" => summary,
        "icon" => icon,
        "temperatureLow" => temperatureLow,
        "temperatureHigh" => temperatureHigh
      }) do
    %{
      "date" => time |> transform_time_to_date,
      "type" => icon,
      "description" => summary,
      "temperature" => %{
        "low" => temperatureLow,
        "high" => temperatureHigh
      }
    }
  end

  def transform_time_to_date(time) do
    time |> DateTime.from_unix!() |> DateTime.to_date()
  end
end
