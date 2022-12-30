defmodule PecaComponent.Table.TableHeader do
  use PecaComponent, :live

  def mount(socket) do
    socket =
      socket
      |> assign_new(:inner_block, fn -> nil end)

    {:ok, socket}
  end
end
