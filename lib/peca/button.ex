defmodule Peca.Button do
  use Phoenix.Component

  import PhxComponentHelpers

  attr(:button_class, :string,
    default: "border hover:opacity-75 px-4 py-2 rounded-md",
    doc: "CSS class to add to the button."
  )

  attr(:button_text, :string, doc: "Button text. Only used if the button content is empty.")

  attr(:size, :string, values: ["xs", "sm", "md", "lg", "xl", "2xl"], default: "md")
  attr(:button_color, :string, default: "transparent")
  attr(:text_color, :string, default: "gray-700")

  slot(:inner_block)

  def button(assigns) do
    assigns =
      assigns
      |> extend_class(assigns.button_class, prefix_replace: false)
      |> extend_class("text-" <> assigns.size, prefix_replace: false)
      |> extend_class("bg-" <> assigns.button_color, prefix_replace: false)
      |> extend_class("text-" <> assigns.text_color, prefix_replace: false)

    ~H"""
    <button class={@class}>
      <%= render_slot(@inner_block) || @button_text %>
    </button>
    """
  end
end
