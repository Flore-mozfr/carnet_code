#!/usr/bin/env python3
"""Convert image/PDF -> Audiveris -> MusicXML -> music21 round-trip.

See utils/score-to-musicxml.md for setup and examples.
"""

import argparse
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import sys
import tempfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Score PDF/image, or existing .mxl/.musicxml/.xml")
    parser.add_argument("--audiveris", default="audiveris", help="Audiveris executable path")
    parser.add_argument("--sheets", nargs="+", help="PDF pages, e.g. --sheets 1 3-5")
    parser.add_argument("--single-score", action="store_true", help="Ignore indentation as a movement boundary")
    parser.add_argument("--output-dir", type=Path, default=Path("dist/omr-tests"))
    args = parser.parse_args()
    source = args.input.expanduser().resolve()
    if not source.is_file():
        parser.error(f"Input does not exist: {source}")
    if args.sheets and any(
        not re.fullmatch(r"[1-9]\d*(?:-[1-9]\d*)?", page)
        or ("-" in page and int(page.split("-")[0]) > int(page.split("-")[1]))
        for page in args.sheets
    ):
        parser.error("Sheets must be positive page numbers or ascending ranges (e.g. 1 3-5).")

    is_xml = source.suffix.lower() in {".mxl", ".musicxml", ".xml"}
    if is_xml and args.sheets:
        parser.error("--sheets applies to Audiveris input, not existing MusicXML.")
    executable = None
    if not is_xml:
        executable = shutil.which(str(Path(args.audiveris).expanduser()))
        if not executable:
            parser.error("Audiveris not found. Install it or supply --audiveris /path/to/bin/Audiveris.")
    try:
        from music21 import converter
    except ImportError:
        parser.error(f"music21 is missing. Install with: {shlex.quote(sys.executable)} -m pip install music21")

    args.output_dir.mkdir(parents=True, exist_ok=True)
    run_dir = Path(tempfile.mkdtemp(prefix="score-", dir=args.output_dir.resolve()))
    print(f"Output: {run_dir}", flush=True)
    if is_xml:
        inputs = [source]
    else:
        raw_dir = run_dir / "audiveris"
        raw_dir.mkdir()
        command = [executable, "-batch", "-transcribe", "-export", "-save", "-output", str(raw_dir)]
        if args.single_score:
            command.extend(["-constant", "org.audiveris.omr.sheet.ProcessingSwitches.indentations=false"])
        if args.sheets:
            command.extend(["-sheets", *args.sheets])
        command.extend(["--", str(source)])
        print(f"Running: {shlex.join(command)}", flush=True)
        log_path = run_dir / "audiveris.log"
        print(f"Audiveris may take several minutes. Log: {log_path}", flush=True)
        with log_path.open("w") as log:
            result = subprocess.run(command, stdout=log, stderr=subprocess.STDOUT, check=False)
        if result.returncode:
            raise RuntimeError(f"Audiveris exited with code {result.returncode}; inspect {log_path}")
        inputs = sorted(raw_dir.rglob("*.mxl")) + sorted(raw_dir.rglob("*.musicxml"))
        if not inputs:
            raise RuntimeError(f"Audiveris produced no MusicXML; inspect {log_path}")

    for index, xml_input in enumerate(inputs, start=1):
        score = converter.parse(xml_input)
        output = run_dir / f"{index:02d}-{xml_input.stem}.musicxml"
        score.write("musicxml", fp=output)
        # Confirm that the exported file can be read back.
        reread = converter.parse(output, forceSource=True)
        print(f"MusicXML: {output}")
        print(f"  Parts: {len(reread.parts)}; note/chord events: {len(reread.recurse().notes)}")
    print("Done. Compare the result with the original score: recognition errors may remain.")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(130)
    except Exception as exc:
        print(f"Error: {exc}", file=sys.stderr)
        sys.exit(1)
