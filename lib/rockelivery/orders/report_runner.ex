defmodule Rockelivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Rockelivery.Orders.Report

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, 1000 * 10)
  end

  def init(state) do
    schedule_report_generation()
    {:ok, state}
  end

  def handle_info(:generate, state) do
    Logger.info("Generating report...")

    Report.create()

    schedule_report_generation()
    {:noreply, state}
  end
end
