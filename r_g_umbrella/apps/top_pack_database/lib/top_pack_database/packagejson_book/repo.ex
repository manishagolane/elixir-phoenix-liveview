defmodule TopPackDatabase.PackagejsonBook.Repo  do
  alias TopPackDatabase.PackagejsonBook.PackageJson

  def create(%PackageJson{} = package_json) do
    Memento.transaction!(fn ->
      Memento.Query.write(package_json)
    end)
  end

  def all do
    Memento.transaction!(fn ->
      Memento.Query.all(PackageJson)
    end)
  end

  def get(id) do
    Memento.transaction!(fn->
      Memento.Query.read(PackageJson, id)
    end)
  end
  
  def get_package_repo_id(repo_id) do
    guard = {:repo_id}
  end


end
