defmodule TopPack.TopPackGenserver do
  use GenServer
  require Logger

  @internal_topic "database:info"
  @github_api_url "https://api.github.com"
  alias NimbleCSV.RFC4180, as: CSV
  @local_write_path "/home/pranav/Documents/MANISHA/"



  def start_link(config) do
    GenServer.start_link(
      __MODULE__,
      config,
      name: __MODULE__
    )
end

  @impl true
  def init(_config) do
    # config = private_config()
    Phoenix.PubSub.subscribe(TopPack.PubSub, @internal_topic)
    {:ok, %{}}
  end

  @impl true
  def handle_info({event, payload}, state) do
    Logger.debug("#{__MODULE__}: Genserver recieved #{inspect(event)}, #{inspect(payload)}")

    case event do
      :import_jsonpackage ->
        handle_import_jsonpackage(payload,state)
      :search_github_repositories_keyword ->
        handle_search_github_repositories_keyword(payload,state)
    end
  end

  defp handle_import_jsonpackage(payload,state) do
    Logger.debug("#{__MODULE__}: payload data #{inspect(payload)}")
    repo = TopPackDatabase.GitRepoBookFunction.get_all_repo()
  #  data =  Enum.map(repo,fn t ->
  #     %{
  #       version: t.version
  #     }
  #   end)
    # local_path =
    #       case File.write!(@local_path, data) do
    #           :ok -> @local_path
    #           _ -> "ERROR"
    #       end
    # # [repo] = TopPackDatabase.GitRepoBookFunction.get_all_repo()
    Logger.debug("#{__MODULE__}: databse data #{inspect(repo)}")

    {:noreply, state}
  end


  defp handle_search_github_repositories_keyword(payload,state) do
    keyword = payload[:symbol]
    url = "https://api.github.com/search/repositories?q=#{URI.encode(keyword)}"
    headers = [{"User-Agent", "GithubSearch"}]

    data =
      HTTPoison.get(url, [], headers)
      |> parse_github_response

    Phoenix.PubSub.broadcast(
      TopPack.PubSub, "get_searched_repo",
      {:get_searched_repo, data}
    )
    {:noreply, state}
  end

  defp parse_github_response(response) do
    {:ok, %HTTPoison.Response{status_code: status_code, body: body}} = response

    case status_code do
      200 ->
      IO.inspect(body,label: "repo data")
      # {:ok, decoded_body} = Poison.decode(body)
      # IO.inspect(decoded_body)
      extract_repositories(body)

      _ ->
        []
    end

    # response = search_github_repositories(keyword)
    # repositories = parse_github_response(response)
  end

  defp extract_repositories(body) do
    {:ok, body} = Jason.decode(body, keys: :atoms)
    IO.inspect(body.items,limit: :infinity)

    # items = Map.get(body, "items", nil)
    # IO.inspect(items,label: "items hello")

    case body.items do
      nil -> []
      _ ->
        body.items
        |> Enum.map(&extract_repository_info/1)
    end
  end

  defp extract_repository_info(repo) do
    data = %{
      license: repo.license,
      deployments_url: repo.deployments_url,
      archived: repo.archived,
      created_at: repo.created_at,
      open_issues: repo.open_issues,
      has_wiki: repo.has_wiki,
      has_projects: repo.has_projects,
      mirror_url: repo.mirror_url,
      git_url: repo.git_url,
      star_count: repo.stargazers_count,
      forks_count: repo.forks_count,
      teams_url: repo.teams_url,
      comments_url: repo.comments_url,
      clone_url: repo.clone_url,
      description: repo.description,
      merges_url: repo.merges_url,
      size: repo.size,
      git_commits_url: repo.git_commits_url,
      blobs_url: repo.blobs_url,
      issues_url: repo.issues_url,
      default_branch: repo.default_branch,
      id: repo.id,
      has_pages: repo.has_pages,
      is_template: repo.is_template,
      open_issues_count: repo.open_issues_count,
      web_commit_signoff_required: repo.web_commit_signoff_required,
      subscribers_url: repo.subscribers_url,
      has_issues: repo.has_issues,
      milestones_url: repo.milestones_url,
      forks_url: repo.forks_url,
      ssh_url: repo.ssh_url,
      updated_at: repo.updated_at,
      name: repo.name,
      assignees_url: repo.assignees_url,
      stargazers_count: repo.stargazers_count,
      watchers: repo.watchers,
    }
    # IO.inspect(data,label: "finallyyy got data")
  end


end
