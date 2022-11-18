# PecaComponents

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `peca_components` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:peca_components, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/peca_components>.

## Override default styling:

config :peca_components, 
    defaults: [
        button: [
            padding: "px-4 py-2",
            rounded: "rounded-md",
            size: nil,
            button_color: "transparent",
            text_color: "gray-700",
            border: "border",
            hover: "hover:opacity-75"
        ]
    ]