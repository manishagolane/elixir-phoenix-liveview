defmodule TopPackDatabase.GitRepoBookFunction do
  alias TopPackDatabase.GitRepoBook.{Repo,GitRepo}
  alias TopPackDatabase.PackagejsonBook.{Repo,PackageJson}

  require Logger
  @repo Repo

  def get_all_repo do
    @repo.all()
  end

  def get_repo_id(id) do
    @repo.get(id)
  end


  def create_repo(data) do
    %GitRepo{}
          |> struct(
            data
          )
          |>
    @repo.create()
  end

  def get_package_repo_id(repo_id) do
    @repo.get_package_repo_id(repo_id)
  end
end
