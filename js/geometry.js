export const PLANES = {
1: [0, 1], // XY
2: [0, 2], // XZ
3: [0, 3], // XW
4: [1, 2], // YZ
5: [1, 3], // YW
6: [2, 3], // ZW
};

export const PLANE_NAMES = {
1: "XY",
2: "XZ",
3: "XW",
4: "YZ",
5: "YW",
6: "ZW",
};

export function rotate(point, plane, angle) {
const [i, j] = PLANES[plane];
const result = [...point];

const c = Math.cos(angle);
const s = Math.sin(angle);

const a = point[i];
const b = point[j];

result[i] = a * c - b * s;
result[j] = a * s + b * c;

return result;
}

export function rotateAll(point, angles) {
let result = [...point];

for (const [plane, angle] of angles) {
result = rotate(result, plane, angle);
}

return result;
}

export function project4D(point, distance = 4.0) {
const [x, y, z, w] = point;
const denominator = distance - w;

if (denominator <= 0.01) return null;

const scale = distance / denominator;

return [x * scale, y * scale, z * scale];
}

export function project3D(
point,
width,
height,
scale = 115.0,
) {
const [x, y, z] = point;

return [
width / 2 + scale * (x - 0.5 * z),
height / 2 - scale * (y - 0.35 * z),
];
}

export function project(
point,
width,
height,
distance = 4.0,
scale = 115.0,
) {
const point3D = project4D(point, distance);

if (!point3D) return null;

return project3D(point3D, width, height, scale);
}

