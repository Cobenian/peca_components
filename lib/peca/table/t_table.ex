defmodule PecaComponent.Table.TTable do
  use Phoenix.Component

  import PecaComponent.Table.THelpers

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: false)

  def table_table(assigns) do
    assigns =
      assigns
      |> assign_new(:table_head, fn -> nil end)
      |> assign_new(:table_foot, fn -> nil end)

    ~H"""
    <div class="overflow-x-auto">
      <table
        class={
          build_class([
            "min-w-full overflow-hidden divide-y rounded-sm table-auto",
            @class
          ])
        }
        {@rest}
      >
        <%= render_slot(@table_head) %>
        <%= render_slot(@inner_block) %>
        <%= if @table_foot do %>
        <%= render_slot(@table_foot) %>
        <% end %>
      </table>
    </div>
    """
  end
end
