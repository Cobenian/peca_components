defmodule PecaComponent do
  defmacro __using__(defaults_for: component, opts: opts) when is_atom(component) do
    quote do
      use Phoenix.Component
      import PhxComponentHelpers

      @spacing_default Application.compile_env(
                         :peca_components,
                         [:defaults, unquote(component), :spacing],
                         unquote(opts[:spacing])
                       )
      @sizing_default Application.compile_env(
                        :peca_components,
                        [:defaults, unquote(component), :sizing],
                        unquote(opts[:sizing])
                      )
      @typography_default Application.compile_env(
                            :peca_components,
                            [:defaults, unquote(component), :typography],
                            unquote(opts[:typography])
                          )
      @background_default Application.compile_env(
                            :peca_components,
                            [:defaults, unquote(component), :background],
                            unquote(opts[:background])
                          )
      @borders_default Application.compile_env(
                         :peca_components,
                         [:defaults, unquote(component), :borders],
                         unquote(opts[:borders])
                       )

      @rounded_default Application.compile_env(
                         :peca_components,
                         [:defaults, unquote(component), :rounded],
                         unquote(opts[:rounded])
                       )

      @states_default Application.compile_env(
                        :peca_components,
                        [:defaults, unquote(component), :states],
                        unquote(opts[:states])
                      )
    end
  end
end
