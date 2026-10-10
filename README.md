# Ruby Tesseract

A 4D hypercube (tesseract) visualization project implemented in Ruby and JavaScript.

The project explores four-dimensional geometry, rotation, and projection into two-dimensional space. It includes a Ruby implementation for rendering images and a browser-based demo for interactive rotation.

## Demo

Try the interactive demo on GitHub Pages:

**[Open the Tesseract Demo](https://panier-tech.github.io/ruby-tesseract/)**

* Rotate the tesseract automatically.
* Select different rotation planes.
* Change the rotation direction.
* Pause, resume, or reset the rotation.

## Features

* Generate the vertices and edges of a tesseract.
* Rotate objects in six planes of four-dimensional space.
* Project four-dimensional coordinates into three-dimensional space.
* Project the result onto a two-dimensional screen.
* Render images with Ruby.
* Explore the geometry interactively in a web browser with JavaScript.

## Controls

| Key     | Action                           |
| ------- | -------------------------------- |
| `1`–`6` | Select a rotation plane          |
| `←`     | Rotate in the opposite direction |
| `→`     | Rotate in the forward direction  |
| `Space` | Pause or resume rotation         |
| `R`     | Reset the rotation               |

The six rotation planes are:

| Key | Plane |
| --- | ----- |
| `1` | XY    |
| `2` | XZ    |
| `3` | XW    |
| `4` | YZ    |
| `5` | YW    |
| `6` | ZW    |

Unlike rotation in three-dimensional space, a four-dimensional object can rotate in planes involving the fourth coordinate, `W`.

## Run locally

Clone the repository:

```sh
git clone https://github.com/panier-tech/ruby-tesseract.git
cd ruby-tesseract
```

### JavaScript demo

Start a local HTTP server:

```sh
python3 -m http.server 8080
```

Open http://localhost:8080/ in your browser.

### Ruby implementation

Install the dependencies:

```sh
bundle install
```

Run the program:

```sh
bundle exec ruby main.rb
```

Run the tests:

```sh
bundle exec ruby test_tesseract.rb
bundle exec ruby test_geometry.rb
```

Use the Bundler command available in your environment if it is named differently.

## Project structure

```text
.
├── geometry.rb
├── tesseract.rb
├── renderer.rb
├── main.rb
├── test_geometry.rb
├── test_tesseract.rb
├── index.html
└── js/
    ├── geometry.js
    ├── tesseract.js
    └── main.js
```

* `geometry.rb` / `js/geometry.js` — rotation and projection mathematics.
* `tesseract.rb` / `js/tesseract.js` — vertices and edges of the tesseract.
* `renderer.rb` — Ruby image rendering.
* `main.rb` — Ruby entry point.
* `index.html` and `js/` — interactive browser demo.
* `test_*.rb` — Ruby tests.

## Geometry

A tesseract is the four-dimensional analogue of a cube. It has:

* 16 vertices
* 32 edges
* 24 square faces
* 8 cubic cells

The implementation represents each vertex using four coordinates:

$$
(x, y, z, w)
$$

Rotation is performed in one of the six coordinate planes, followed by perspective projection into three-dimensional space and then onto the screen.

## License

See [LICENSE](LICENSE) for details.
