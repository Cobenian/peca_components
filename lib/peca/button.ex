defmodule Peca.Button do
  use Phoenix.Component

  import PhxComponentHelpers

  @padding_default Application.compile_env(
                     :peca_components,
                     [:defaults, :button, :padding],
                     "px-4 py-2"
                   )
  @rounded_default Application.compile_env(
                     :peca_components,
                     [:defaults, :button, :rounded],
                     "rounded"
                   )
  @button_color_default Application.compile_env(
                          :peca_components,
                          [:defaults, :button, :button_color],
                          "transparent"
                        )
  @button_text_default Application.compile_env(
                         :peca_components,
                         [:defaults, :button, :text_color],
                         "Click Me"
                       )
  @border_default Application.compile_env(
                    :peca_components,
                    [:defaults, :button, :border],
                    "border"
                  )
  @hover_default Application.compile_env(
                   :peca_components,
                   [:defaults, :button, :hover],
                   "hover:opacity-75"
                 )

  attr(:button_text, :string, doc: "Button text. Only used if the button content is empty.")

  attr(:size, :string,
    values: ["xs", "sm", "md", "lg", "xl", "2xl"],
    default: "md",
    doc: "Standard sizes for the button. (xs|sm|md|lg|xl|2xl) Default is 'md'. Optional."
  )

  attr(:padding, :string, default: @padding_default, doc: "CSS padding class(es) for the button.")

  attr(:rounded, :string, default: @rounded_default, doc: "CSS rounding class(es) for the button.")

  attr(:button_color, :string,
    default: @button_color_default,
    doc: "CSS button background color class(es) for the button."
  )

  attr(:text_color, :string,
    default: @button_text_default,
    doc: "CSS button text color class(es) for the button."
  )

  attr(:border, :string, default: @border_default, doc: "CSS border class(es) for the button.")
  attr(:hover, :string, default: @hover_default, doc: "CSS hover class(es) for the button.")

  attr(:button_class, :string, default: "", doc: "CSS class to add to the button.")

  slot(:inner_block)

  def button(assigns) do
    assigns =
      assigns
      |> extend_class(assigns.border, prefix_replace: false)
      |> extend_class(assigns.hover, prefix_replace: false)
      |> extend_class(assigns.rounded, prefix_replace: false)
      |> extend_class(assigns.padding, prefix_replace: false)
      |> extend_class("text-" <> assigns.size, prefix_replace: false)
      |> extend_class("bg-" <> assigns.button_color, prefix_replace: false)
      |> extend_class("text-" <> assigns.text_color, prefix_replace: false)
      |> extend_class(assigns.button_class, prefix_replace: false)

    ~H"""
    <button class={@class}>
      <%= render_slot(@inner_block) || @button_text %>
    </button>
    """
  end
end
