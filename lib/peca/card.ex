defmodule Peca.Card do
  use PecaComponent,
    defaults_for: :card,
    opts: [
      spacing: "",
      sizing: "",
      typography: "",
      background: "",
      borders: "border",
      rounded: "rounded-lg",
      states: "drop-shadow-lg"
    ]

  # stardard attrs

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

  attr(:custom_class, :string, default: "", doc: "Additional CSS class(es) for customization.")

  # custom attrs

  attr(:header_class, :string, default: "text-xl font-bold", doc: "CSS class(es) for header.")
  attr(:content_class, :string, default: "p-4", doc: "CSS class(es) for content.")
  attr(:footer_class, :string, default: "", doc: "CSS class(es) for footer.")

  slot(:header)
  slot(:inner_block)
  slot(:footer)

  def card(assigns) do
    assigns = handle_class_assigns(assigns)

    ~H"""
    <div class={@class}>
        <div class={@header_class}><%= render_slot(@header) %></div>
        <div class={@content_class}><%= render_slot(@inner_block) %></div>
        <div class={@footer_class}><%= render_slot(@footer) %></div>
    </div>
    """
  end
end
