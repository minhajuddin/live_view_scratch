defmodule LiveViewScratchWeb.LightLive do
  use LiveViewScratchWeb, :live_view

  @impl true
  def mount(params, session, socket) do
    IO.inspect(%{params: params, session: session, socket: socket})
    {:ok, assign(socket, :brightness, 90)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h2> Welcome to lights </h2>
    <span><%= @brightness %></span>
    <br />
    <%= for level <- ~w[dim normal bright] do %>
      <button phx-click=change-brightness phx-value-brightness=<%= level %>>Set brightness to <%= level %></button>
    <% end %>
    """
  end


  @impl true
  def handle_event("change-brightness", event, socket) do
    {:noreply, assign(socket, :brightness, event["brightness"])}
  end

#** (UndefinedFunctionError) function LiveViewScratchWeb.LightLive.handle_event/3 is undefined or private
  #LiveViewScratchWeb.LightLive.handle_event("change-brightness", %{"altKey" => false, "ctrlKey" => false, "detail" => 1, "metaKey" => false, "offsetX" => 114, "offsetY" => 13,
    #"pageX" => 142, "pageY" => 281, "screenX" => 2775, "screenY" => 516, "shiftKey" => false, "value" => "", "x" => 142, "y" => 281}
    #, #Phoenix.LiveView.Socket<assigns: %{brightness: 90, flash: %{}, live_action: :index, live_module: LiveViewScratchWeb.LightLive},
    #changed: %{}, endpoint: LiveViewScratchWeb.Endpoint, id: "phx-FgtkaTCNL3-UDRDC", parent_pid: nil,
    #root_pid: #PID<0.1419.0>, router: LiveViewScratchWeb.Router, view: LiveViewScratchWeb.LightLive, ...>)
end
