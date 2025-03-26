## ImageMagick Sharpness-Related Commands

This document lists and describes all the core ImageMagick commands/options directly related to image sharpening or edge enhancement, presented in alphabetical order by command name.

---

### 1. `-adaptive-sharpen`
```
-adaptive-sharpen geometry
```
- **Purpose:** Similar to `-sharpen` but adapts locally to image features, allowing it to sharpen small details more aggressively while minimizing artifacts in smoother areas.
- **Parameters:**
  - Geometry takes the form `radiusxsigma` (e.g., `0x1.5`).
    - `radius=0` tells ImageMagick to pick an optimal radius automatically.
    - `sigma` sets how broad or narrow the sharpen effect is.
- **Example usage:**
  ```bash
  magick input.jpg -adaptive-sharpen 0x1.5 output.jpg
  ```

---

### 2. `-edge`
```
-edge radius
```
- **Purpose:** Performs edge detection rather than a direct “sharpen,” but the resulting edge map can be composited with the original image to enhance edges selectively.
- **Parameters:**
  - **radius** – The radius for the edge operator.
- **Example usage:**
  ```bash
  magick input.jpg -edge 1 output.jpg
  ```

---

### 3. `-enhance`
```
-enhance
```
- **Purpose:** An older method that attempts to reduce noise and enhance edges. It’s less controllable than the unsharp or adaptive methods.
- **Example usage:**
  ```bash
  magick input.jpg -enhance output.jpg
  ```
- While it does add some sharpness, most users prefer `-unsharp` or `-adaptive-sharpen` for more refined control.

---

### 4. `-morphology Convolve` (with a custom sharpen kernel)
```
-morphology Convolve Matrix:...
```
- **Purpose:** Allows arbitrary convolution kernels, including classic Laplacian or custom sharpen matrices.
- **Example usage (3×3 sharpen kernel):**
  ```bash
  magick input.jpg \
     -morphology Convolve '3x3: 0 -1 0  -1 5 -1  0 -1 0' \
     output.jpg
  ```
  This simple matrix boosts edges and subdues neighboring pixels.

---

### 5. `-sharpen`
```
-sharpen radius[,sigma]
```
- **Purpose:** Applies a basic Gaussian-based sharpen filter.
- **Parameters:**
  - **radius** – The size of the Gaussian operator (0 = “auto”).
  - **sigma** – Standard deviation of the Gaussian (if omitted, ImageMagick picks a default).
- **Example usage:**
  ```bash
  magick input.jpg -sharpen 0x1.0 output.jpg
  ```

---

### 6. `-unsharp`
```
-unsharp radius[,sigma[,amount[,threshold]]]
```
- **Purpose:** Implements unsharp masking, a common technique to enhance apparent sharpness by subtracting a blurred copy from the original.
- **Parameters (in order):**
  1. **radius** – Blur radius (0 = “auto”).
  2. **sigma** – Blur standard deviation.
  3. **amount** – Strength of the sharpening (e.g., 0.5–2.0, though it can go higher).
  4. **threshold** – Threshold to ignore low-contrast areas (e.g., 0.0–0.05).
- **Example usage:**
  ```bash
  magick input.jpg -unsharp 0x1+1.0+0.02 output.jpg
  ```
  This means `radius=0`, `sigma=1`, `amount=1.0`, and `threshold=0.02`.

---

## Notes on Usage

- **Radius = 0** often tells ImageMagick to automatically determine an optimal radius.
- **Sigma** determines the spread of the Gaussian. A small sigma targets finer edges, whereas a large sigma targets broader edges.
- **Amount** (with `-unsharp`) multiplies the effect to increase or decrease the sharpening intensity.
- **Threshold** (with `-unsharp`) helps avoid sharpening noise or very low-contrast detail.

---

## Other Commands That Affect Perceived Sharpness
Options such as `-contrast`, `-brightness-contrast`, `-sigmoidal-contrast`, or `-contrast-stretch` can increase local contrast but do **not** directly sharpen edges. They are not included in this list since they do not strictly perform sharpening in the traditional sense.

---

## Summary
ImageMagick’s official sharpening or edge-enhancement options are:

1. **`-adaptive-sharpen`**
2. **`-edge`**
3. **`-enhance`**
4. **`-morphology Convolve`** (with a sharpen kernel)
5. **`-sharpen`**
6. **`-unsharp`**

These commands cover all commonly recognized sharpen-related functionality in ImageMagick.
