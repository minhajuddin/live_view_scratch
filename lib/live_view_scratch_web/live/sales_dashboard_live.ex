defmodule LiveViewScratchWeb.SalesDashboardLive do
  use LiveViewScratchWeb, :live_view
  alias LiveViewScratch.Sales

  def mount(_params, _session, socket) do
    if connected?(socket) do
      send(self(), :refresh)
    end
    {:ok, update_state(socket)}
  end

  def render(assigns) do
    ~L"""
    <h2>Dashboard</h2>

    <table>
    <tr>
    <td>New Orders</td>
    <td><%= @new_orders %></td>
    </tr><tr>
    <td>Sales Amount</td>
    <td><%= @sales_amount %></td>
    </tr><tr>
    <td>Satisfaction</td>
    <td><%= @satisfaction %></td>
    </tr>
    </table>
    <button phx-click=refresh>Refresh</button>
    """
  end

  def handle_info(:refresh, socket) do
    Process.send_after(self(), :refresh, 1000)
    {:noreply, update_state(socket)}
  end

  def handle_event("refresh", _, socket) do
    {:noreply, update_state(socket)}
  end

  defp update_state(socket) do
    stats = Sales.stats()
    assign(socket,
      sales_amount: stats.sales_amount,
      new_orders: stats.new_orders,
      satisfaction: stats.satisfaction
    )
  end
end

defmodule LiveViewScratch.Sales do
  def stats do
    %{
      sales_amount: :crypto.rand_uniform(1000, 40000),
      new_orders: :crypto.rand_uniform(100, 400),
      satisfaction: :crypto.rand_uniform(0, 100)
    }
  end
end
