defmodule TopPackDatabase.ResetDatabase.ResetGitRepoDatabase do

  def reset_database do

    v1 = %{
      version: "3.4.0"
    }

    v2 = %{
      version: "5.4.0",


    }



    TopPackDatabase.GitRepoBookFunction.create_repo(v1)
  end
end
