defmodule TrainBoard.Periodically do
  use GenServer

  alias TrainBoard.Schedules

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # Start the work
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Schedules.clear_and_reset_trains

    schedule_work()
    {:noreply, state}
  end

  def schedule_work() do
    # Run every two minutes
    Process.send_after(self(), :work, 2 * 60 * 1000)
  end
end
