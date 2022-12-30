defmodule PecaComponent.Table.TableCell do
  use Phoenix.LiveComponent

  def mount(socket) do
    socket =
      socket
      |> assign_new(:inner_block, fn -> nil end)

    {:ok, socket}
  end
end
