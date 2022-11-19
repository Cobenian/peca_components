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

      defp standard_class_attrs() do 
        [
            :sizing,
            :spacing,
            :rounded,
            :background,
            :typography,
            :borders,
            :states,
            :custom_class,
        ]
      end

      defp standard_exclude_class_attrs() do
        standard_class_attrs() ++ [:class, :heex_class]
      end

      defp handle_class_assigns(assigns) do
        case Map.get(assigns, :class) do
          nil ->
            standard_class_attrs()
            |> Enum.reduce(assigns, fn attr, acc ->
               acc
               |> extend_class(acc[attr], prefix_replace: false) 
            end)
            # |> Enum.into(%{})
            # assigns
            # |> extend_class(assigns.spacing, prefix_replace: false)
            # |> extend_class(assigns.sizing, prefix_replace: false)
            # |> extend_class(assigns.typography, prefix_replace: false)
            # |> extend_class(assigns.background, prefix_replace: false)
            # |> extend_class(assigns.borders, prefix_replace: false)
            # |> extend_class(assigns.rounded, prefix_replace: false)
            # |> extend_class(assigns.states, prefix_replace: false)
            # |> extend_class(assigns.custom_class, prefix_replace: false)

          _ ->
            assigns
        end
      end

      defp assign_rest(assigns, :standard_class_exludes) do
        assign_rest(assigns, standard_exclude_class_attrs())
      end

      defp assign_rest(assigns, [standard_class_exludes_plus: exclude]) when is_atom(exclude) do
        assign_rest(assigns, [standard_class_exludes_plus: [exclude]])
      end
      defp assign_rest(assigns, [standard_class_exludes_plus: excludes]) do
        assign_rest(assigns, standard_exclude_class_attrs() + excludes)
      end

      defp assign_rest(assigns, [exclude: excludes]) do
        Phoenix.Component.assign(
            assigns,
            :rest,
            Phoenix.Component.assigns_to_attributes(assigns, excludes)
          )
      end
    end
  end
end
