defmodule PecaComponent.Table.TRow do
  use Phoenix.Component

  import PecaComponent.Table.TCell
  import PecaComponent.Table.THelpers

  attr :class, :string, default: ""
  slot :inner_block, required: false

  def table_row(assigns) do
    ~H"""
    <tr
      class={
        build_class([
          "border-b",
          @class
        ])
      }
    >
      <%= for header <- assigns.headers do %>
        <.table_cell row={assigns.row} header={header} custom_column={assigns.custom_column}>
        </.table_cell>
      <% end %>
    </tr>
    """
  end
end
