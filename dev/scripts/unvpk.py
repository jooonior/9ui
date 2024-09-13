"""Extract a single file from a VPK archive and print it to standard output.

usage: unvpk.py VPK FILE

arguments:
  VPK                   VPK archive
  FILE                  file to extract from the archive
"""

import sys

from srctools.vpk import VPK


def log(*args, **kwargs) -> None:
    kwargs["file"] = sys.stderr
    print(*args, **kwargs)


def main() -> int:
    if len(sys.argv) != 3:
        log(__doc__.replace("unvpk.py", sys.argv[0]).strip())
        return 2

    archive_name = sys.argv[1]
    file_name = sys.argv[2]

    try:
        with VPK(archive_name, mode="r") as archive:
            file = archive[file_name]
            sys.stdout.buffer.write(file.read())
    except KeyError:
        # Default error message sucks.
        log(f"No such file in the archive: '{file_name}'")
    except Exception as e:
        log(e)
    else:
        return 0

    return 1


if __name__ == "__main__":
    sys.exit(main())
