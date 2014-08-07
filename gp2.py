#!/usr/bin/python

import string
import re

content = """
gp; PRINTS; PR00209 GLIADIN; PR00208 GLIADGLUTEN; PR00210 GLUTENIN
gp; PRINTS; PR00551 2SGLOBULIN
gp; INTERPRO; IPR006044
gp; PROSITE; PS00305 11S_SEED_STORAGE
gp; PDB; 2E9Q; 2EVX; 1OD5; 1UD1; 1UCX
bb;
gr; 1. OGATA, C., HATADA, M., TOMLINSON, G., SHIN, W.C. AND KIM, S.H.
gr; Crystal structure of the intensely sweet protein monellin.
gr; More description
gr; And Even more description
gr; NATURE 328 739-42 (1987).
gr;
gr; 2. KOHMURA, M., NIO, N. AND ARIYOSHI, Y.
gr; Complete amino acid sequence of the sweet protein monellin.
gr; AGRIC.BIOL.CHEM. 54 2219-24 (1990).
gr;
"""

lines = []
literature = []


# Core text parsing part
for l in content.split('\n'):
    tag, sep, contents = l.partition(';')
    contents = contents.lstrip()
    lines.append( (tag, contents) )

for l in lines:
    # databases
    if l[0] == 'gp':
        parts = l[1].split(';')
        db = parts[0]
        for el in parts[1:]:
            pp = string.lstrip(el).split(' ')
            if len(pp) < 2:
                print 'Database:\t%s\nAccession:\t%s\n' % (db, pp[0])
            else:
                print 'Database:\t%s\nAccession:\t%s\nTitle:\t\t%s\n' % (db, pp[0], pp[1])
    elif l[0] == 'gr':
        literature.append(l[1])

# Post text processing part
# join the literature part and preserve the new lines
literature = '\n'.join(literature)

#Split literature entries by new lines
literature_entry = re.split('\n\s*\n', literature)
for l in literature_entry:
    parts = re.search('(?P<number>\w*)\. (?P<authors>.*)\n(?P<description>(.|\n)*)\n(?P<source>.*)\((?P<year>\d\d\d\d)\)', l, re.MULTILINE ).groupdict()

    print parts