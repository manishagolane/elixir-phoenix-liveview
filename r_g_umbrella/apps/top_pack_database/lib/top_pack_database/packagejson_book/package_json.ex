defmodule TopPackDatabase.PackagejsonBook.PackageJson do
  use Memento.Table,
  attributes: [
    :id,
    :git_repo_id,
    :version,
    :name
  ],
  type: :ordered_set,
  autoincrement: true
end
