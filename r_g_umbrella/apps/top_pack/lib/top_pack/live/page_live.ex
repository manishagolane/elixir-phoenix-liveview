defmodule TopPack.PageLive do
  use TopPack, :live_view

  @internal_database_topic "database:info"

  require Logger

  @impl true
  def mount(_param, session, socket) do
    IO.inspect(socket)
    name = Map.get(session,"name")
    {:ok,assign(socket,
    symbol: "",
    searched_repo: [],
    package: [],
    selected_repo: ""
    )}
  end

  @impl true
  def handle_info({:get_searched_repo, payload},socket) do
    Logger.debug("#{__MODULE__}: response data ")
    socket = assign(socket, searched_repo: payload)
    {:noreply, socket}
  end

  @impl true
  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
   ~L"""
   <div>
   <form phx-change="keyword-search" class="input-search-cont">
     <input class="input-search"  name="symbol"  type="text" placeholder="Search any git repo" autocorrect="off" icon="search" autocomplete="off" label="" rules="" dynamicwidthsize="8">
   </form>
   <%= if length(@searched_repo) != 0 do%>
    <%= for repo <- @searched_repo do %>
      <li>
      <p>Star Count: <%= repo.star_count %></p>
      <p>Name: <%= repo.name %></p>
      <button phx-click="import-packagejson-file" phx-value-selected_repo="<%= repo.star_count %>">Import</button>
      </li>
    <% end %>
  <%end%>
 </div>
    """
  end

  @impl true
  def handle_event("keyword-search", %{"symbol" => symbol}, socket) do
    # send(self(), {:run_symbol_search, symbol})
    Phoenix.PubSub.broadcast(
      TopPack.PubSub,
      @internal_database_topic,
      {:search_github_repositories_keyword,
       %{
        symbol: symbol
       }}
    )
    Phoenix.PubSub.subscribe(TopPack.PubSub, "get_searched_repo")
    socket =
      assign(
        socket,
        symbol: "",
        searched_repo: []
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("import-packagejson-file",%{"selected_repo" => selected_repo}, socket) do
    Phoenix.PubSub.broadcast(
      TopPack.PubSub,
      @internal_database_topic,
      {:import_jsonpackage,
       %{
        selected_repo: selected_repo
       }}
    )

    {:noreply,
    assign(socket,
     package: []
    )}
  end
end
