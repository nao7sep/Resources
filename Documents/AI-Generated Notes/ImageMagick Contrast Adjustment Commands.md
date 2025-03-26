## ImageMagick Contrast Adjustment Commands

This document provides a comprehensive reference for ImageMagick commands commonly used to adjust and enhance image contrast. Each command includes:

- **Description**: What the command does and when to use it
- **Parameters**: Explanation of possible settings or arguments
- **Usage Example(s)**: Practical demonstration of how to apply the command
- **Notes**: Additional tips, best practices, and clarifications

Below is an **alphabetically** organized list of commands.

---

### `-auto-gamma`

**Description:**
- Automatically adjusts an image’s gamma based on the average brightness of the image.
- Typically used to quickly correct images that appear too dark or too light.
- It calculates and applies an ideal gamma value so that mid-tones appear more natural.

**Parameters & Behavior:**
- No manual numeric parameter.
- It works independently on each channel unless the image type or colorspace enforces a different behavior.

**Usage Example:**
```bash
magick input.jpg -auto-gamma output.jpg
```

**Notes:**
- Often used alongside `-auto-level` or `-contrast-stretch` for automatic color/contrast corrections.
- Results may vary depending on the overall brightness and color distribution of the input image.

---

### `-auto-level`

**Description:**
- Expands (stretches) the darkest and brightest pixel values of each channel to the full available range (0–255 for 8-bit images).
- Useful as a quick, channel-by-channel contrast enhancement.

**Parameters & Behavior:**
- No manual numeric parameter.
- Each color channel (Red, Green, Blue) is processed independently, which can cause color shifts if the channel distributions differ significantly.

**Usage Example:**
```bash
magick input.jpg -auto-level output.jpg
```

**Notes:**
- Sometimes combined with `-auto-gamma` or `-normalize` for an easy, fully automated correction.
- Can be too aggressive if an image’s color distribution is already close to the full range.

---

### `-brightness-contrast`

**Description:**
- Adjusts both brightness and contrast in a single step.
- Accepts two values in the form `[brightness]x[contrast]`.
- Each parameter ranges from `-100` (minimum) to `+100` (maximum).

**Parameters & Behavior:**
- **Brightness**: Shifts pixel values up or down.
  - Positive values brighten the image; negative values darken it.
- **Contrast**: Expands or contracts the difference between lighter and darker areas.
  - Positive values boost contrast; negative values flatten the image.

**Usage Example:**
```bash
magick input.jpg -brightness-contrast 10x30 output.jpg
```
- **Brightness: 10%** increase
- **Contrast: 30%** increase

**Notes:**
- If only brightness or contrast is desired, set the other parameter to `0` (e.g., `-brightness-contrast 0x20`).
- Good for fine-tuning after more global operations like `-auto-level`.

---

### `-clahe`

**Description:**
- Stands for *Contrast Limited Adaptive Histogram Equalization*.
- Enhances local contrast in different regions of the image, rather than uniformly across the entire image.
- Useful for revealing details in both bright and dark regions simultaneously.

**Parameters & Behavior:**
- Syntax: `-clahe widthxheight+bins+clip-limit`
  - **widthxheight**: Defines the tile size for subdividing the image (e.g., `8x8`).
  - **bins**: Number of histogram bins used for equalization (e.g., `128`).
  - **clip-limit**: Limits the contrast enhancement to avoid over-amplifying noise (e.g., `3`).

**Usage Example:**
```bash
magick input.jpg -clahe 8x8+128+3 output.jpg
```
- **Tile size**: `8x8`
- **Histogram bins**: `128`
- **Clip limit**: `3`

**Notes:**
- Lower clip limits reduce noise but may diminish overall contrast gains.
- Increasing tile size or bins can significantly slow down processing on large images.

---

### `-contrast`

**Description:**
- Increases the contrast of the image using a simple nonlinear function.
- Issuing `-contrast` multiple times amplifies the effect incrementally.

**Parameters & Behavior:**
- No numeric parameters.
- Each application of `-contrast` yields a small step up in contrast.

**Usage Example:**
```bash
magick input.jpg -contrast output.jpg
```
- To apply a stronger effect, repeat:
  ```bash
  magick input.jpg -contrast -contrast -contrast output.jpg
  ```

**Notes:**
- Because it applies a fixed algorithm, repeated usage can lead to overly harsh contrast if not monitored.
- For more controlled contrast changes, consider `-brightness-contrast` or `-sigmoidal-contrast`.

---

### `-contrast-stretch`

**Description:**
- Clips a specified percentage of the darkest and brightest pixels, then stretches the remaining pixels to the full range.
- Similar to `-auto-level` but provides manual control over how many pixels are clipped.

**Parameters & Behavior:**
- Syntax: `-contrast-stretch black_clip%xwhite_clip%`
  - Clips the darkest `black_clip%` of pixels and the brightest `white_clip%` of pixels.
  - Stretches the rest across the image’s dynamic range.

**Usage Example:**
```bash
magick input.jpg -contrast-stretch 0.5%x0.5% output.jpg
```
- Clips **0.5%** of the darkest and **0.5%** of the brightest pixels

**Notes:**
- Very useful for removing extreme outliers (e.g., very bright specular highlights, very dark shadows).
- Choose clip values carefully to avoid losing important detail.

---

### `-equalize`

**Description:**
- Redistributes the brightness values of pixels so the histogram becomes more uniform.
- Globally enhances contrast, especially for images with uneven or skewed luminance distributions.

**Parameters & Behavior:**
- No direct numeric parameters.
- Equalizes the histogram of each channel separately unless you convert the image to a different color space (e.g., HSL) prior to equalizing.

**Usage Example:**
```bash
magick input.jpg -equalize output.jpg
```

**Notes:**
- May introduce color shifts if channels are heavily unbalanced.
- For a local version of histogram equalization, use `-clahe`.

---

### `-level`

**Description:**
- Manually sets black and white points, and optionally applies a gamma adjustment.
- Gives finer control compared to automated commands like `-auto-level`.

**Parameters & Behavior:**
- Syntax: `-level black_point[,white_point][,gamma]`
  - Values typically expressed as percentages (e.g., `5%,95%`) or absolute intensities (e.g., `10,240`).
  - The optional gamma is applied after black/white levels are set.

**Usage Example:**
```bash
magick input.jpg -level 5%,95% output.jpg
```
- **Black point**: 5%
- **White point**: 95%

**Notes:**
- Use exact values when you know specific pixel intensities that should be mapped to black/white.
- To combine gamma correction, use something like `-level 5%,95%,1.2`.

---

### `-linear-stretch`

**Description:**
- Similar to `-contrast-stretch` but instead specifies percentages of pixels to clip for black and white, which it then stretches across the full range in a linear fashion.
- Often used for images with extreme shadows or highlights.

**Parameters & Behavior:**
- Syntax: `-linear-stretch black_clip%xwhite_clip%`
  - The darkest `black_clip%` of pixels become black; the brightest `white_clip%` become white.

**Usage Example:**
```bash
magick input.jpg -linear-stretch 2%x98% output.jpg
```
- Clips **2%** of the darkest pixels and **2%** of the brightest pixels

**Notes:**
- Useful for systematic processing of large batches when you know typical clipping percentages for your images.
- Similar effect to `-contrast-stretch`; naming is more descriptive of the linear mapping process.

---

### `-normalize`

**Description:**
- Expands the image’s full range so the darkest pixel becomes black and the brightest pixel becomes white.
- Equivalent to stretching from the current minimum/maximum pixel values to the full available range.

**Parameters & Behavior:**
- No numeric parameters.
- Differs from `-auto-level` in that it considers the extreme darkest/brightest pixels across all channels together rather than separately.

**Usage Example:**
```bash
magick input.jpg -normalize output.jpg
```

**Notes:**
- If your image has only a few extremely bright or dark pixels, `-normalize` can drastically affect overall exposure.
- For more controlled stretching, `-contrast-stretch` or `-linear-stretch` may be preferable.

---

### `-sigmoidal-contrast`

**Description:**
- Applies a sigmoidal (S-curve) contrast transformation, which can preserve more detail in shadows and highlights compared to linear methods.
- Especially popular for photographic editing to boost contrast in midtones without destroying highlights/shadows.

**Parameters & Behavior:**
- Syntax: `-sigmoidal-contrast factor{x|X}midpoint%[+channel]`
  - **factor**: Controls the steepness of the S-curve (higher = stronger contrast).
  - **midpoint%**: Specifies the midpoint around which contrast is expanded or compressed.

**Usage Example:**
```bash
magick input.jpg -sigmoidal-contrast 5x50% output.jpg
```
- **factor**: `5`
- **midpoint**: `50%`

**Notes:**
- If your image is too bright or dark overall, adjust midpoint away from `50%`.
- Can be combined with channel-specific operations (e.g., `-sigmoidal-contrast 3x40% +red` to apply only on the red channel).

---

### Additional Tips & Best Practices

1. **Color Space Considerations**
   - By default, commands often operate on the image’s current color space (usually sRGB).
   - Converting to `Lab`, `XYZ`, or `HSL` space before applying certain enhancements can yield more natural-looking results, especially when dealing with `-equalize` or `-clahe`.
   - Example:
     ```bash
     magick input.jpg -colorspace Lab -equalize -colorspace sRGB output.jpg
     ```

2. **Combining Commands**
   - You can chain multiple commands together, but be mindful of the order.
   - Example:
     ```bash
     magick input.jpg \
       -auto-gamma \
       -brightness-contrast 10x20 \
       -sigmoidal-contrast 3x50% \
       output.jpg
     ```
   - Each command modifies the image before the next one starts.

3. **Version Differences**
   - ImageMagick 7 uses `magick` as the primary executable, while ImageMagick 6 often uses `convert`.
   - Command syntax generally remains the same, but some defaults (like colorspace handling) can vary slightly between versions.

4. **Preventing Over-Processing**
   - Too many aggressive corrections can lead to posterization (loss of detail) or unnatural looks.
   - It’s often best to adjust parameters incrementally and preview your results.

5. **Batch Processing**
   - ImageMagick can process many images at once using wildcards or simple scripting.
   - Example:
     ```bash
     magick *.jpg -auto-level -contrast-stretch 0.5%x0.5% out_%d.jpg
     ```

6. **Performance Notes**
   - Certain operations like `-clahe` can be computationally expensive on large images.
   - Use smaller tile sizes or fewer bins if performance is an issue, or consider resizing for preview/testing.
