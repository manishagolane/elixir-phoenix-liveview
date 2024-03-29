defmodule MyDummyDatabase.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(
    __MODULE__,
    :ok,
    opts
    )
  end

  def init(:ok) do
    children = []

    opts = [strategy: :one_for_one]
    Supervisor.init(children,opts)
  end

end
