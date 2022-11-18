defmodule Peca.Button do
  use Phoenix.Component

  import PhxComponentHelpers

  @spacing_default Application.compile_env(
                     :peca_components,
                     [:defaults, :button, :spacing],
                     "px-4"
                   )
  @sizing_default Application.compile_env(
                    :peca_components,
                    [:defaults, :button, :sizing],
                    "h-10"
                  )
  @typography_default Application.compile_env(
                        :peca_components,
                        [:defaults, :button, :typography],
                        ""
                      )
  @background_default Application.compile_env(
                        :peca_components,
                        [:defaults, :button, :background],
                        "transparent"
                      )
  @borders_default Application.compile_env(
                     :peca_components,
                     [:defaults, :button, :borders],
                     "border"
                   )

  @rounded_default Application.compile_env(
                     :peca_components,
                     [:defaults, :button, :rounded],
                     "rounded"
                   )

  @states_default Application.compile_env(
                    :peca_components,
                    [:defaults, :button, :states],
                    "hover:opacity-75"
                  )

  @button_text_default Application.compile_env(
                         :peca_components,
                         [:defaults, :button, :button_text],
                         "Click Me"
                       )

  attr(:button_text, :string,
    default: @button_text_default,
    doc: "Button text. Only used if the button content is empty."
  )

  attr(:sizing, :string,
    default: @sizing_default,
    doc: "Standard sizes for the button. Sets h-* and w-* classes. Optional."
  )

  attr(:spacing, :string, default: @spacing_default, doc: "CSS spacing class(es) for the button.")

  attr(:rounded, :string, default: @rounded_default, doc: "CSS rounding class(es) for the button.")

  attr(:background, :string,
    default: @background_default,
    doc: "CSS button background color class(es) for the button."
  )

  attr(:typography, :string,
    default: @typography_default,
    doc: "CSS button text color class(es) for the button."
  )

  attr(:borders, :string, default: @borders_default, doc: "CSS border class(es) for the button.")
  attr(:states, :string, default: @states_default, doc: "CSS hover class(es) for the button.")

  attr(:button_class, :string, default: "", doc: "CSS class to add to the button.")

  slot(:inner_block)

  def button(assigns) do
    assigns =
      assigns
      |> extend_class(assigns.spacing, prefix_replace: false)
      |> extend_class(assigns.sizing, prefix_replace: false)
      |> extend_class(assigns.typography, prefix_replace: false)
      |> extend_class(assigns.background, prefix_replace: false)
      |> extend_class(assigns.borders, prefix_replace: false)
      |> extend_class(assigns.rounded, prefix_replace: false)
      |> extend_class(assigns.states, prefix_replace: false)
      |> extend_class(assigns.button_class, prefix_replace: false)

    ~H"""
    <button class={@class}>
      <%= render_slot(@inner_block) || @button_text %>
    </button>
    """
  end
end
