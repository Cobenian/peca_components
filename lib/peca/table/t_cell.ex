defmodule PecaComponent.Table.TCell do
  use PecaComponent, :functional

  def table_cell(assigns) do
    assigns =
      assigns
      |> assign_new(:custom_column, fn -> [] end)
      |> assign_new(:slot, fn ->
        Enum.find(assigns.custom_column, fn col ->
          col.slot == assigns.header.value
        end)
      end)

    ~H"""
    <.td>
    <%= if assigns.slot do %>
    <%= render_slot(assigns.slot, assigns.row) %>
    <% else %>
    <%= Map.get(assigns.row, assigns.header.value) %>
    <% end %>
    </.td>
    """
  end
end
