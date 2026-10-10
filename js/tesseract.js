const SIZE = 1.0;
const DIVISIONS = 1;

const GRID = Array.from(
{ length: DIVISIONS + 1 },
(_, i) => -SIZE + (2 * SIZE * i) / DIVISIONS,
);

function pointKey(point) {
return point.join(",");
}

export function build() {
const vertices = new Map();
const edges = new Map();

for (let fixedAxis = 0; fixedAxis < 4; fixedAxis++) {
const otherAxes = [0, 1, 2, 3].filter(
axis => axis !== fixedAxis,
);

for (const side of [-SIZE, SIZE]) {
  for (let a = 0; a <= DIVISIONS; a++) {
    for (let b = 0; b <= DIVISIONS; b++) {
      for (let c = 0; c <= DIVISIONS; c++) {
        const indices = [a, b, c];
        const point = Array(4);

        point[fixedAxis] = side;

        otherAxes.forEach((axis, i) => {
          point[axis] = GRID[indices[i]];
        });

        vertices.set(pointKey(point), point);
      }
    }
  }

  for (let a = 0; a <= DIVISIONS; a++) {
    for (let b = 0; b <= DIVISIONS; b++) {
      for (let c = 0; c <= DIVISIONS; c++) {
        const indices = [a, b, c];

        for (let axisIndex = 0; axisIndex < 3; axisIndex++) {
          if (indices[axisIndex] >= DIVISIONS) continue;

          const nextIndices = [...indices];
          nextIndices[axisIndex]++;

          const p1 = Array(4);
          const p2 = Array(4);

          p1[fixedAxis] = side;
          p2[fixedAxis] = side;

          otherAxes.forEach((axis, i) => {
            p1[axis] = GRID[indices[i]];
            p2[axis] = GRID[nextIndices[i]];
          });

          const k1 = pointKey(p1);
          const k2 = pointKey(p2);
          const key = [k1, k2].sort().join("|");

          edges.set(key, [p1, p2]);
        }
      }
    }
  }
}

}

return {
vertices: [...vertices.values()],
edges: [...edges.values()],
};
}

