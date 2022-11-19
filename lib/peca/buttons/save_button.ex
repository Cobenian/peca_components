defmodule Peca.Buttons.SaveButton do
  use Phoenix.Component

  import Peca.Button

  def save_button(assigns) do
    ~H"""
    <.button background="bg-primary-500" typography="text-white">
        <div class="flex flex-inline items-center"><Heroicons.circle_stack class="h-6 w-6 mr-1" /> Save</div>
    </.button>
    """
  end
end
