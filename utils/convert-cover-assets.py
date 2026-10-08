#!/usr/bin/env python3
"""Convert the bundled SGDF SVGs to black vector PDFs (developer tool only)."""

from pathlib import Path
import re
import xml.etree.ElementTree as ET

import cairo
import gi
from PIL import Image, ImageOps

gi.require_version("Rsvg", "2.0")
from gi.repository import Rsvg


ROOT = Path(__file__).resolve().parents[1]
COVER = ROOT / "img" / "cover"


def main():
    for source in sorted((COVER / "src").glob("*.svg")):
        # Recolour a copy in memory; upstream source files stay intact.
        svg = re.sub(r"#[0-9A-Fa-f]{6}\b", "#000000", source.read_text())
        handle = Rsvg.Handle.new_from_data(svg.encode())
        # Illustrator exports viewBox-only SVGs without absolute dimensions.
        _, _, width, height = map(float, ET.fromstring(svg).attrib["viewBox"].split())
        surface = cairo.PDFSurface(str(COVER / f"{source.stem}.pdf"), width, height)
        context = cairo.Context(surface)
        viewport = Rsvg.Rectangle()
        viewport.x = viewport.y = 0
        viewport.width, viewport.height = width, height
        handle.render_document(context, viewport)
        surface.finish()

    # Keep smooth edges while mapping the dark blue logo to black.
    with Image.open(ROOT / "img" / "JB_Gerland.png") as original:
        rgba = original.convert("RGBA")
        white = Image.new("RGBA", rgba.size, "white")
        white.alpha_composite(rgba)
        gray = ImageOps.grayscale(white.convert("RGB"))
        gray.point(lambda value: max(0, min(255, round((value - 180) * 255 / 75)))).save(
            COVER / "JB_Gerland-nb.png"
        )


if __name__ == "__main__":
    main()
