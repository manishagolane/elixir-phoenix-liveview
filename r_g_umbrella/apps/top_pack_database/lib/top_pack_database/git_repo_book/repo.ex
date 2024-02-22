defmodule TopPackDatabase.GitRepoBook.Repo do
  alias TopPackDatabase.GitRepoBook.GitRepo

  def create(%GitRepo{} = git_repo) do
    Memento.transaction!(fn ->
      Memento.Query.write(git_repo)
    end)
  end

  def all do
    Memento.transaction!(fn ->
      Memento.Query.all(GitRepo)
    end)
  end

  def get(id) do
    Memento.transaction!(fn->
      Memento.Query.read(GitRepo, id)
    end)
  end


end
