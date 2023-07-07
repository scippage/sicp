import argparse
import nbformat
import os
import sys

# seeds a notebook with markdown cells
def create_nb():
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", type=int, required=True, help="chapter number")
    parser.add_argument("-q", type=int, required=True, help="number of questions")
    parser.add_argument("-f", type=str, required=True, help="filename")
    parser.add_argument("-o", action="store_true", help="overwrite?")
    args = parser.parse_args()
    
    if os.path.isfile(args.f) and not args.o:
        sys.exit("file already exists, overwrite with -o")
    
    nb = nbformat.v4.new_notebook()
    nb.cells = list(map(lambda q: nbformat.v4.new_markdown_cell(source=f"## Q{args.c}.{q}"), range(1, args.q+1)))
    nbformat.write(nb, args.f, 4)

if __name__ == "__main__":
    create_nb()