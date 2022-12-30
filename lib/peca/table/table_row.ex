defmodule PecaComponent.Table.TableRow do
  use PecaComponent, :live

  alias PecaComponent.Table.TableCell

  def mount(socket) do
    socket =
      socket
      |> assign_new(:inner_block, fn -> nil end)

    {:ok, socket}
  end
end
