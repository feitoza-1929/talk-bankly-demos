defmodule Demos.Communication do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: :joe)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_info(msg, state) do
    handle_message(msg)

    {:noreply, state}
  end

  defp handle_message(msg) do
    case msg do
      "Hello, Joe" ->
        IO.puts("From Joe: Hello, Mike")

      _ ->
        IO.puts("Message received!")
    end
  end
end
