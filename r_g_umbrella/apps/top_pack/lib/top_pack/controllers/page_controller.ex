defmodule TopPack.PageController do
  use TopPack, :controller
  import Phoenix.LiveView.Controller


  def index(conn, _params) do
    # render(conn, "index.html")
    live_render(conn, TopPack.PageLive,session: %{"name" => "Hello"})

  end
end
