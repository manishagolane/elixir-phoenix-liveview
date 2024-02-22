defmodule TopPackDatabase.GitRepoBook.GitRepo do
  use Memento.Table,
  attributes: [
    :git_repo_id,
    :version
  ],
  type: :ordered_set,
  autoincrement: true
end
