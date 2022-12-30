defmodule PecaComponent.Table.TRow do
  use PecaComponent, :functional

  import PecaComponent.Table.TCell

  def table_row(assigns) do
    ~H"""
    <.tr>
    <%= for header <- assigns.headers do %>
        <.table_cell row={assigns.row} header={header} custom_column={assigns.custom_column}>
        </.table_cell>
    <% end %>
    </.tr>
    """
  end
end
