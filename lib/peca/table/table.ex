defmodule PecaComponent.Table.Table do
  use PecaComponent, :live

  alias PecaComponent.Table.TableHeader
  alias PecaComponent.Table.TableRow

  def mount(socket) do
    socket =
      socket
      |> assign_new(:table_head, fn -> nil end)
      |> assign_new(:table_foot, fn -> nil end)

    {:ok, socket}
  end
end
