import { rotateAll, project, PLANE_NAMES } from "./geometry.js";
import { build } from "./tesseract.js";

const canvas = document.querySelector("#screen");
const ctx = canvas.getContext("2d");
const status = document.querySelector("#status");

const WIDTH = 640;
const HEIGHT = 480;
const FPS = 30;
const ROTATION_STEP = 0.025;

canvas.width = WIDTH;
canvas.height = HEIGHT;

const model = build();
const angles = new Map();

let plane = 3;
let direction = 1;
let autoRotate = true;
let running = true;
let lastFrame = 0;

function pointKey(point) {
  return point.join(",");
}

function draw() {
  ctx.fillStyle = "#12141c";
  ctx.fillRect(0, 0, WIDTH, HEIGHT);

  const projected = new Map();

  for (const point of model.vertices) {
    const rotated = rotateAll(point, angles);

    projected.set(
      pointKey(point),
      project(rotated, WIDTH, HEIGHT, 4.0, 105.0),
    );
  }

  ctx.beginPath();

  for (const [p1, p2] of model.edges) {
    const a = projected.get(pointKey(p1));
    const b = projected.get(pointKey(p2));

    if (!a || !b) continue;

    ctx.moveTo(a[0], a[1]);
    ctx.lineTo(b[0], b[1]);
  }

  ctx.strokeStyle = "#64beeb";
  ctx.lineWidth = 1.5;
  ctx.stroke();

  status.textContent =
    `Plane: ${PLANE_NAMES[plane]} | ` +
    `Rotation: ${autoRotate ? "ON" : "OFF"} | ` +
    `Direction: ${direction > 0 ? "→" : "←"}`;
}

function animate(timestamp) {
  if (!running) return;

  requestAnimationFrame(animate);

  if (timestamp - lastFrame < 1000 / FPS) return;

  lastFrame = timestamp;

  if (autoRotate) {
    angles.set(
      plane,
      (angles.get(plane) ?? 0) +
        ROTATION_STEP * direction,
    );
  }

  draw();
}

function reset() {
  angles.clear();
  draw();
}

document.addEventListener("keydown", event => {
  if (
    ["ArrowLeft", "ArrowRight", " "].includes(event.key)
  ) {
    event.preventDefault();
  }

  if (event.repeat) return;

  switch (event.key.toLowerCase()) {
    case "1":
    case "2":
    case "3":
    case "4":
    case "5":
    case "6":
      plane = Number(event.key);
      break;

    case "arrowleft":
      direction = -1;
      break;

    case "arrowright":
      direction = 1;
      break;

    case " ":
      autoRotate = !autoRotate;
      break;

    case "r":
      reset();
      return;

    default:
      return;
  }

  draw();
});

document.querySelector("#toggle").addEventListener("click", () => {
  autoRotate = !autoRotate;
  draw();
});

document.querySelector("#reset").addEventListener("click", reset);

draw();
requestAnimationFrame(animate);
