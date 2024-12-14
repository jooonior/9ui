"""Generate a blank bitmap font with zero width and height.

Based on `CBitmapFont::Create` from the TF2 source code leak.
"""

import enum
import re
import sys
from ctypes import Structure, c_char, c_int, c_short, c_ubyte, sizeof
from glob import glob

from PIL import Image


def is_ctype(cls):
    try:
        sizeof(cls)
    except TypeError:
        return False
    else:
        return True


def cstruct(cls):
    # Get class attributes annotated with ctypes.
    fields = [
        (name, annotation)
        for name, annotation in cls.__annotations__.items()
        if is_ctype(annotation)
    ]

    cls_dict = cls.__dict__.copy()
    cls_dict["_fields_"] = fields

    # Remove field attributes.
    for name, _ in fields:
        cls_dict.pop(name, None)

    # `@dataclass` does this.
    cls_dict.pop("__dict__", None)
    cls_dict.pop("__weakref__", None)

    return type(cls)(cls.__name__, (Structure, *cls.__bases__), cls_dict)


@cstruct
class BitmapGlyph:
    _pack_ = 1

    x: c_short
    y: c_short
    w: c_short
    h: c_short
    a: c_short
    b: c_short
    c: c_short


@cstruct
class BitmapFont:
    _pack_ = 1

    id: c_char * 4
    version: c_int
    page_width: c_short
    page_height: c_short
    max_char_width: c_short
    max_char_height: c_short
    flags: c_short
    accent: c_short
    num_glyphs: c_short
    translate_table: c_ubyte * 256


class BitmapFlag(enum.IntFlag):
    BOLD = 0x1
    ITALIC = 0x2
    OUTLINED = 0x4
    DROPSHADOW = 0x8
    BLURRED = 0x10
    SCANLINES = 0x20
    ANTIALIASED = 0x40
    CUSTOM = 0x80


def main():
    # Find font texture.
    image_path_pattern = re.sub(r"\.[^/\\]*$", ".*.png", __file__)
    image_paths = glob(image_path_pattern)
    if len(image_paths) != 1:
        print("cannot find font texture", file=sys.stderr)
        return 1

    # Get font texture dimensions.
    with Image.open(image_paths[0]) as image:
        width = image.width
        height = image.height

    # VBF width and height must match its texture.
    font = BitmapFont(
        id=b"VFNT",
        version=3,
        page_width=width,
        page_height=height,
        max_char_width=0,
        max_char_height=1,
        flags=BitmapFlag.CUSTOM,
        accent=0,
        num_glyphs=0,
    )

    sys.stdout.buffer.write(bytes(font))


if __name__ == "__main__":
    main()
