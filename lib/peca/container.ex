defmodule Peca.Container do
  use PecaComponent,
    defaults_for: :container,
    opts: [
      spacing: "",
      sizing: "",
      typography: "",
      background: "",
      borders: "",
      rounded: "",
      states: "",
      layout: "",
      placement: ""
    ]

  # stardard class attrs

  attr(:sizing, :string,
    default: @sizing_default,
    doc:
      "Sets h-* and w-* classes. Optional. Recommend setting height and NOT width so it can adjust according to the text/content."
  )

  attr(:spacing, :string, default: @spacing_default, doc: "CSS spacing class(es).")

  attr(:rounded, :string, default: @rounded_default, doc: "CSS rounded class(es).")

  attr(:background, :string, default: @background_default, doc: "CSS button background class(es).")

  attr(:typography, :string, default: @typography_default, doc: "CSS button text class(es).")

  attr(:borders, :string, default: @borders_default, doc: "CSS border class(es).")

  attr(:states, :string,
    default: @states_default,
    doc: "CSS states class(es) [hover, focus, etc.]."
  )

  attr(:layout, :string, default: @layout_default, doc: "CSS layout class(es)")

  attr(:placement, :string,
    default: @placement_default,
    doc: "CSS placement class(es) [flexbox, grid]"
  )

  attr(:custom_class, :string, default: "", doc: "Additional CSS class(es) for customization.")

  # custom attrs

  slot(:inner_block)

  def container(assigns) do
    assigns =
      assigns
      |> handle_class_assigns()
      |> assign_rest(:standard_class_excludes)

    ~H"""
    <div class={@class} {@rest}>
        <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
