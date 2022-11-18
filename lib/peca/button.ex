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
                     "rounded-md"
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
    doc: "Button text. Used only if the button content (inner_block) is empty."
  )

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

  slot(:inner_block)

  def button(assigns) do
    assigns =
      case Map.get(assigns, :class) do
        nil ->
          assigns
          |> extend_class(assigns.spacing, prefix_replace: false)
          |> extend_class(assigns.sizing, prefix_replace: false)
          |> extend_class(assigns.typography, prefix_replace: false)
          |> extend_class(assigns.background, prefix_replace: false)
          |> extend_class(assigns.borders, prefix_replace: false)
          |> extend_class(assigns.rounded, prefix_replace: false)
          |> extend_class(assigns.states, prefix_replace: false)
          |> extend_class(assigns.custom_class, prefix_replace: false)

        _ ->
          assigns
      end

    ~H"""
    <button class={@class}>
      <%= render_slot(@inner_block) || @button_text %>
    </button>
    """
  end
end
