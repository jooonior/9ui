"""Create a font from individual glyph outlines.

usage: mkfont.py NAME PATH CODEPOINT=GLYPH ...

arguments:
  NAME                  name of the font
  PATH                  output path (extension determines format)
  CODEPOINT             codepoint of the next glyph in hexadecimal
  GLYPH                 file containing the glyph's outlines
"""

import sys

import fontforge


def log(*args, **kwargs) -> None:
    kwargs["file"] = sys.stderr
    print(*args, **kwargs)


def main() -> int:
    argc = len(sys.argv)

    if argc < 4:
        log(__doc__.replace("mkfont.py", sys.argv[0]).strip())
        return 2

    fontname = sys.argv[1]
    outpath = sys.argv[2]

    font = fontforge.font()

    font.fontname = fontname
    font.familyname = fontname
    font.fullname = fontname

    for arg in sys.argv[3:]:
        if "=" not in arg:
            log(f"Invalid argument '{arg}'")
            return 1

        codepoint, glyphfile = arg.split("=", 2)

        try:
            index = int(codepoint, 16)
        except ValueError:
            log(f"Invalid codepoint '{codepoint}'")
            return 1

        glyph = font.createChar(index)
        glyph.importOutlines(glyphfile)

    font.generate(outpath)
    return 0


if __name__ == "__main__":
    try:
        status = main()
    except Exception as e:
        log(e)
        status = 1

    sys.exit(status)
