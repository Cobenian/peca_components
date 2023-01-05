defmodule PecaComponent.Table.THeader do
  use Phoenix.Component

  # import PecaComponent.Table.TCell
  import PecaComponent.Table.THelpers

  require Logger

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: false)

  def table_header(assigns) do
    assigns =
      assigns
      |> assign_new(:sortable, fn -> false end)

    ~H"""
    <tr>
      <%= for header <- assigns.headers do %>
        <th
          class={
            build_class(
              [
                "px-6 py-3 text-xs font-medium text-left uppercase",
                @class
              ],
              " "
            )
          }
          {@rest}
        >
          <%= if Map.get(header, :sortable) do %>
            <!-- <%= assigns.sort_bys %> -->
            <%= header.name %>
            <button phx-click="sort_toggle" phx-value-header={header.value} phx-target={@sort_target}>
              <%= if toggle_icon(assigns.sort_bys, as_str(header.value)) == :sort_ascending do %>
                <Heroicons.bars_arrow_up class="w-5 h-5" />
              <% else %>
                <%= if toggle_icon(assigns.sort_bys, as_str(header.value)) == :sort_descending do %>
                  <Heroicons.bars_arrow_down class="w-5 h-5" />
                <% else %>
                  <Heroicons.arrows_up_down class="w-5 h-5" />
                <% end %>
              <% end %>
            </button>
            <%!--
            <%= if asc?(assigns.sort_bys, as_str(header.value)) do %>
                <Heroicons.Outline.sort_ascending />
            <% else %>
                <%= if desc?(assigns.sort_bys, as_str(header.value)) do %>
                    <Heroicons.Outline.sort_descending />
                <%= end %>
            <% end %>
            --%>

            <%!-- <.button phx-click="sort_asc" phx-value-header={header.value} phx-target={@sort_target}>Asc</.button>
            <.button phx-click="sort_desc" phx-value-header={header.value} phx-target={@sort_target}>Desc</.button> --%>

          <% else %>
            <%= header.name %>
          <% end %>
        </th>
      <% end %>
    </tr>
    """
  end

  def toggle_icon(sort_bys, header) do
    if asc?(sort_bys, header) do
      :sort_ascending
    else
      if desc?(sort_bys, header) do
        :sort_descending
      else
        :switch_vertical
      end
    end
  end

  def as_str(s) when is_binary(s), do: s
  def as_str(s) when is_atom(s), do: Atom.to_string(s)
  def as_str(s), do: s

  def asc?(sort_bys, header) do
    # Logger.info("looking for asc header #{inspect header} in #{inspect sort_bys}")
    Enum.find(sort_bys, fn
      [^header, "asc"] -> true
      _ -> false
    end)
  end

  def desc?(sort_bys, header) do
    # Logger.info("looking for desc header #{inspect header} in #{inspect sort_bys}")
    Enum.find(sort_bys, fn
      [^header, "desc"] -> true
      _ -> false
    end)
  end
end
