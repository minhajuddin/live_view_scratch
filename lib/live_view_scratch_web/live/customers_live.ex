defmodule LiveViewScratchWeb.CustomersLive do
  use LiveViewScratchWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, customers: [], customer: :none)}
  end

  def render(assigns) do
    ~L"""
    <h2>Customers</h2>
    <form phx-change=autocomplete >
      <input type="text" name=name list="customers-name" phx-debounce=1000>


    <%= if @customer != :none do %>
      <h3><%= @customer["name"] %></h3>
      <p>
      <dl>
        <dt>Age</dt>
        <dd><%= @customer["age"] %></dd>
        <dt>Gender</dt>
        <dd><%= @customer["gender"] %></dd>
        <dt>Email</dt>
        <dd><%= @customer["email"] %></dd>
      </dl>
      </p>
      <% end %>

      <datalist id='customers-name'>
      <%= for c <- @customers do %>
        <option value="<%= c["name"] %>" />
      <% end %>
      </datalist>
    </form>
    """
  end

  def handle_event("autocomplete", event, socket) do
    case  Customers.find(event["name"]) do
      [] -> {:noreply, socket
      |> put_flash(:info, "No customers matching \"#{event["name"]}\"")
      |> assign(customers: [], customer: :none)
      }
      [customer] ->
        {:noreply, assign(socket, customers: [customer], customer: customer)}
      customers ->
        {:noreply, assign(socket, customers: customers, customer: :none)}
    end
  end
end

defmodule Customers do
  @customers "#{:code.priv_dir(:live_view_scratch)}/customers_full.json"
  |> File.read!
  |> String.split("\n")
  |> Enum.map(&Jason.decode/1)
  |> Enum.filter_map(fn {:ok, _} -> true; _ -> false end, fn {:ok, customer} -> customer end)

  def all, do: @customers

  def find(pattern) do
    pattern = String.downcase(pattern)
    all
    |> Enum.filter(fn x -> String.starts_with?(String.downcase(x["name"]), pattern) end)
    |> Enum.take(10)
  end
end
