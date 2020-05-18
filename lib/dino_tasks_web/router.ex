defmodule DinoTasksWeb.Router do
  use DinoTasksWeb, :router
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :admins_only do
    plug :basic_auth, username: "dino", password: "fGBkodWUcH"
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DinoTasksWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", DinoTasksWeb do
    pipe_through :browser

    live("/", Live.Home)
    live("/example", Live.WeatherExample)
  end

  scope "/" do
    pipe_through [:browser, :admins_only]
    live_dashboard "/dashboard", metrics: DinoTasksWeb.Telemetry
  end
end
