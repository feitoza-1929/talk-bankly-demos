defmodule Demos.FaultTolerance.WithSupervisor.Persistence do
  use Agent

  def start_link(initial_value \\ []) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get_value do
    Agent.get(__MODULE__, & &1)
  end

  def update_value(value) do
    Agent.update(__MODULE__, fn _ -> value end)
  end
end
