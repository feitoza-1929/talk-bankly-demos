defmodule Demos.FaultTolerance.WithSupervisor.Counter do
  use GenServer

  alias Demos.FaultTolerance.Persistence

  # Client

  def start_link(args \\ []),
    do: GenServer.start_link(__MODULE__, args, name: __MODULE__)

  def count,
    do: GenServer.cast(__MODULE__, :count)

  def fail,
    do: GenServer.cast(__MODULE__, :fail)

  # Server

  def init(_state) do
    schedule_work()

    {:ok, Persistence.get_value()}
  end

  def handle_cast(:fail, state) do
    raise "\n======== Error: process now is dead ========\n"

    {:noreply, state}
  end

  def handle_cast(:count, state) do
    IO.puts("\n -- #{new_state(state)}")

    Persistence.update_value(new_state(state))

    {:noreply, new_state(state)}
  end

  def handle_info(:count, state) do
    count()
    schedule_work()
    {:noreply, state}
  end

  # Helpers

  defp schedule_work,
    do: Process.send_after(__MODULE__, :count, 3000)

  defp new_state([]),
    do: 1

  defp new_state(state),
    do: state + 1
end
