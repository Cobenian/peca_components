defmodule PecaComponent.Table do
  use PecaComponent, :live

  alias PecaComponent.Table.Table
  alias PecaComponent.Table.TableHeader
  alias PecaComponent.Table.TableRow

  import PecaComponent.Table.TTable
  import PecaComponent.Table.THeader
  import PecaComponent.Table.TRow

  require Logger

  def mount(socket) do
    socket =
      socket
      |> assign_new(:table_id, fn -> Ecto.UUID.generate() end)
      |> assign_new(:sort_bys, fn -> [] end)
      # |> assign_new(:custom_sort, fn ->
      #   fn items, _sort_bys -> items end
      # end)
      |> assign_new(:custom_sort, fn -> &default_sorter/2 end)

    {:ok, socket}
  end

  def update(assigns, socket) do
    Logger.info("updating table .... #{inspect(assigns)}")
    socket = assign(socket, assigns)

    {:ok, socket}
  end

  defp has_header?(sort_bys, header) do
    Enum.find(sort_bys, fn
      [^header, _] -> true
      _ -> false
    end)
  end

  def handle_event("sort_toggle", %{"header" => header}, socket) do
    old_sort_bys = socket.assigns.sort_bys || []

    new_sort_bys =
      if has_header?(old_sort_bys, header) do
        old_sort_bys
        |> Enum.map(fn sort_by ->
          case sort_by do
            [^header, "asc"] -> [header, "desc"]
            [^header, "desc"] -> nil
            _ -> sort_by
          end
        end)
        |> Enum.reject(&is_nil/1)
      else
        old_sort_bys ++ [[header, "asc"]]
      end

    socket =
      socket
      |> assign(:sort_bys, new_sort_bys)
      |> sort_rows()

    {:noreply, socket}
  end

  def sort_rows(socket) do
    rows = socket.assigns.rows
    sort_bys = socket.assigns.sort_bys
    sorter = socket.assigns.custom_sort

    sorted_rows = sorter.(rows, sort_bys)

    # Logger.info("sorted rows #{inspect sorted_rows}")

    socket
    |> assign(:rows, sorted_rows)
  end

  def default_sorter(items, sort_bys) do
    # sort_bys |> IO.inspect(label: :sort_bys)
    sort_items(items, sort_bys)
    # |> IO.inspect(label: :sorted_not_flat, limit: :infinity, pretty: true)
    |> List.flatten()
  end

  def sort_items(items, []) do
    items
  end

  def sort_items(items, [[header, "asc"] | sort_bys]) do
    items
    |> Enum.sort_by(fn item ->
      Map.get(item, String.to_atom(header))
    end)
    |> Enum.chunk_by(fn item ->
      Map.get(item, String.to_atom(header))
    end)
    # |> IO.inspect(label: :asc_chunks)
    |> Enum.map(&sort_items(&1, sort_bys))
  end

  def sort_items(items, [[header, "desc"] | sort_bys]) do
    items
    |> Enum.sort_by(fn item ->
      Map.get(item, String.to_atom(header))
    end)
    |> Enum.chunk_by(fn item ->
      Map.get(item, String.to_atom(header))
    end)
    |> Enum.reverse()
    # |> IO.inspect(label: :desc_chunks)
    |> Enum.map(&sort_items(&1, sort_bys))
  end
end
