defmodule WeatherWeb.Router do
  use WeatherWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeatherWeb do
    pipe_through :api
    get "/", WeatherController, :index
  end
end
