"""Concatenate strings and files.

usage: cat.py (STRING | @FILE) ...

arguments:
  STRING                print STRING, followed by a newline
  FILE                  print contents of FILE
"""

import os
import sys


def log(*args, **kwargs) -> None:
    kwargs["file"] = sys.stderr
    print(*args, **kwargs)


def main() -> int:
    if len(sys.argv) < 2:
        log(__doc__.replace("cat.py", sys.argv[0]).strip())
        return 2

    for arg in sys.argv[1:]:
        if arg.startswith("@"):
            try:
                with open(arg[1:], "rb") as file:
                    while chunk := file.read(4096):
                        sys.stdout.buffer.write(chunk)
            except Exception as e:
                log(e)
                return 1
        else:
            sys.stdout.buffer.write(os.fsencode(arg))
            sys.stdout.buffer.write(b"\n")

    return 0


if __name__ == "__main__":
    sys.exit(main())
