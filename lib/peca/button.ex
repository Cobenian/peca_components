defmodule Peca.Button do
  use PecaComponent,
    defaults_for: :button,
    opts: [
      spacing: "px-4",
      sizing: "h-10",
      typography: "",
      background: "transparent",
      borders: "border",
      rounded: "rounded-md",
      states: "hover:opacity-75"
    ]

  @button_text_default Application.compile_env(
                         :peca_components,
                         [:defaults, :button, :button_text],
                         "Click Me"
                       )

  # standard attrs

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

  attr(:button_text, :string,
    default: @button_text_default,
    doc: "Button text. Used only if the button content (inner_block) is empty."
  )

  slot(:inner_block)

  def button(assigns) do
    assigns =
      assigns
      |> handle_class_assigns()
      |> assign_rest(standard_class_excludes_plus: [:button_text])

    ~H"""
    <button class={@class} {@rest}>
      <%= render_slot(@inner_block) || @button_text %>
    </button>
    """
  end
end
