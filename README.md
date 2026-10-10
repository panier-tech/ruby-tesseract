# Ruby Tesseract

A Ruby-based 4D hypercube visualization using SDL2.

## Requirements

* Ruby
* Bundler
* SDL2 and its development libraries

## Setup

Install the dependencies:

```sh
bundle install
```

## Usage

Run the program:

```sh
bundle exec ruby main.rb
```

## Controls

| Key              | Action                    |
| ---------------- | ------------------------- |
| `1`–`6`          | Select a rotation plane   |
| `Left` / `Right` | Change rotation direction |
| `Space`          | Toggle automatic rotation |
| `R`              | Reset rotations           |
| `Esc` / `Q`      | Quit the program          |

The six rotation planes are XY, XZ, XW, YZ, YW, and ZW.

## License

See [LICENSE](LICENSE) for details.
