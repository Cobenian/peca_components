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

      @layout_default Application.compile_env(
                        :peca_components,
                        [:defaults, unquote(component), :layout],
                        unquote(opts[:layout])
                      )

      @placement_default Application.compile_env(
                           :peca_components,
                           [:defaults, unquote(component), :placement],
                           unquote(opts[:placement])
                         )

      defp standard_class_attrs() do
        [
          :sizing,
          :spacing,
          :rounded,
          :background,
          :typography,
          :borders,
          :states,
          :layout,
          :placement,
          :custom_class
        ]
      end

      defp standard_exclude_class_attrs() do
        standard_class_attrs() ++ [:class, :heex_class]
      end

      defp handle_class_assigns(assigns) do
        case Map.get(Map.get(assigns, :rest, %{}), :class) do
          nil ->
            standard_class_attrs()
            |> Enum.reduce(assigns, fn attr, acc ->
              case acc[attr] do
                nil ->
                  acc

                cls ->
                  acc
                  |> extend_class(cls, prefix_replace: false)
              end
            end)

          _ ->
            assigns
        end
      end
    end
  end
end
