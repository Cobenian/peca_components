defmodule PecaComponent.Table.TTable do
  use Phoenix.Component
  # use PecaComponent, :functional

  def table_table(assigns) do
    assigns =
      assigns
      |> assign_new(:table_head, fn -> nil end)
      |> assign_new(:table_foot, fn -> nil end)

    ~H"""
    <div class="overflow-x-auto">
        <.table class="table-auto">
            <%= render_slot(@table_head) %>
            <%= render_slot(@inner_block) %>
            <%= if @table_foot do %>
            <%= render_slot(@table_foot) %>
            <% end %>
        </.table>
    </div>
    """
  end
end
