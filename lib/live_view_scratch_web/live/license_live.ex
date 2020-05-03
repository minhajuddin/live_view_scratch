defmodule LiveViewScratchWeb.LicenseLive do
  use LiveViewScratchWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, update_state(socket, 2)}
  end

  defp compute_cost(seats), do: seats * 20

  def render(assigns) do
    ~L"""
    <p>Your license is currently for <%= @seats %> seats.</p>
    <form phx-change=update>
      <input type=range min=1 max=10 name=seats value="<%= @seats %>"/>
      Cost: $<%= @cost %>
    </form>
    """
  end

  @impl true
  def handle_event("update", event, socket) do
    {:noreply, update_state(socket, String.to_integer(event["seats"]))}
  end

  defp update_state(socket, seats) do
    assign(socket, seats: seats, cost: compute_cost(seats))
  end
end
