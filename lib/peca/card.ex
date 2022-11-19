defmodule Peca.Card do
  use PecaComponent,
    defaults_for: :card,
    opts: [
      borders: "border",
      rounded: "rounded-lg",
      states: "drop-shadow-lg"
    ]

  # stardard class attrs

  attr(:sizing, :string,
    default: @sizing_default,
    doc:
      "Sets h-* and w-* classes. Optional. Recommend setting height and NOT width so it can adjust according to the text/content."
  )

  attr(:spacing, :string, default: @spacing_default, doc: "CSS spacing class(es).")

  attr(:rounded, :string, default: @rounded_default, doc: "CSS rounded class(es).")

  attr(:background, :string,
    default: @background_default,
    doc: "CSS button background class(es)."
  )

  attr(:typography, :string,
    default: @typography_default,
    doc: "CSS button text class(es)."
  )

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

  attr(:header_class, :string, default: "text-xl font-bold", doc: "CSS class(es) for header.")
  attr(:content_class, :string, default: "p-4", doc: "CSS class(es) for content.")
  attr(:footer_class, :string, default: "", doc: "CSS class(es) for footer.")

  slot(:header)
  slot(:inner_block)
  slot(:footer)

  def card(assigns) do
    assigns =
      assigns
      |> handle_class_assigns()
      |> assign_rest(
        standard_class_excludes_plus: [
          :header,
          :footer,
          :header_class,
          :content_class,
          :footer_class
        ]
      )

    ~H"""
    <div class={@class} {@rest}>
        <div class={@header_class}><%= render_slot(@header) %></div>
        <div class={@content_class}><%= render_slot(@inner_block) %></div>
        <div class={@footer_class}><%= render_slot(@footer) %></div>
    </div>
    """
  end
end
