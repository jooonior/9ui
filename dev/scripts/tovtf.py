"""Convert an image to VTF and print it to standard output.

usage: tovtf.py IMAGE FORMAT

arguments:
  IMAGE                 input image file
  FORMAT                output VTF image format
"""

import sys
from io import BytesIO

from srctools.vtf import ImageFormats, VTF, VTFFlags
from PIL import Image


def log(*args, **kwargs) -> None:
    kwargs["file"] = sys.stderr
    print(*args, **kwargs)


def main() -> int:
    if len(sys.argv) != 3:
        log(__doc__.replace("tovtf.py", sys.argv[0]).strip())
        return 2

    image_path = sys.argv[1]
    image_format = sys.argv[2]

    try:
        fmt = ImageFormats[image_format.upper()]
    except KeyError:
        log(f"Unsupported VTF image format: '{image_format}'")
        log(f"Expected one of:", *ImageFormats.__members__)
        return 1

    flags = VTFFlags.NO_MIP | VTFFlags.NO_LOD

    r, g, b, a, size, _ = fmt.value
    match a:
        case 0:
            pass
        case 1:
            flags |= VTFFlags.ONEBITALPHA
        case 8:
            flags |= VTFFlags.EIGHTBITALPHA
        case _:
            errmsg = "unexpected alpha channel width"
            raise AssertionError(errmsg)

    try:
        with (
            Image.open(image_path).convert("RGBA") as image,
            VTF(
                width=image.width,
                height=image.height,
                flags=flags,
                fmt=fmt,
            ) as vtf,
        ):
            frame = vtf.get()
            frame.copy_from(image.tobytes(), ImageFormats.RGBA8888)

            data = BytesIO()
            vtf.save(data, version=(7, 2))
            sys.stdout.buffer.write(data.getvalue())

    except Exception as e:
        log(e)
    else:
        return 0

    return 1


if __name__ == "__main__":
    sys.exit(main())
