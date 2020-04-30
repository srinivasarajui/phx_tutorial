defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component
  alias Chirp.Timeline
  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="post">
    <div>@<%= @post.username %> - <%= @post.body %>
    <a href="#" phx-click="like" phx-target="<%= @myself %>">
    <%= @post.likes_count %>
    </a>
    <%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post.id) %>
    <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></span>
    </div>

    </div>
    """
  end

  def handle_event("like",_,socket) do
    Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end
end
