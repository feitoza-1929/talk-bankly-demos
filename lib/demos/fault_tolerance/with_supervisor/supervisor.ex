defmodule Demos.FaultTolerance.WithSupervisor.Supervisor do
  use Supervisor

  def start_link(args \\ []) do
    Supervisor.start_link(__MODULE__, args, name: :supervisor)
  end

  @impl true
  def init(_args) do
    children = [
      Demos.FaultTolerance.Persistence,
      Demos.FaultTolerance.Counter
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
