defmodule PecaComponent.Table.TCell do
  use Phoenix.Component

  import PecaComponent.Table.THelpers

  attr :class, :string, default: ""
  attr :rest, :global, include: ~w(colspan headers rowspan)

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
    <td
      class={
        build_class(
          [
            "px-6 py-4 text-sm",
            @class
          ],
          " "
        )
      }
      {@rest}
    >
      <%= if assigns.slot do %>
        <%= render_slot(assigns.slot, assigns.row) %>
      <% else %>
        <%= Map.get(assigns.row, assigns.header.value) %>
      <% end %>
    </td>
    """
  end
end
