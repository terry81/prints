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
gr; NATURE 328 739-42 (1987).
gr;
gr; 2. KOHMURA, M., NIO, N. AND ARIYOSHI, Y.
gr; Complete amino acid sequence of the sweet protein monellin.
gr; AGRIC.BIOL.CHEM. 54 2219-24 (1990).
gr;
gr; 3. BOHAK, Z. AND LI, S.L. 
gr; The structure of monellin and its relation to the sweetness of the protein.
gr; BIOCHIM.BIOPHYS.ACTA 427 153-70 (1976).
bb;
bb;
gd; Monellin is an intensely sweet-tasting protein derived from African berries.
gd; The protein has a very high specificity for the sweet receptors, making it
gd; ~100,000 times sweeter than sugar on a molar basis and several thousand 
gd; times sweeter on a weight basis [1]. Like the sweet-tasting protein
gd; thaumatin, it neither contains carbohydrates nor modified amino acids [1].
gd; Although there is no sequence similarity between the proteins, antibodies
gd; for thaumatin compete for monellin (and other sweet compounds, but not for 
gd; chemically modified non-sweet monellin) and vice versa [1]. It is thought
gd; that native conformations are important for the sweet taste.
gd;
gd; Monellin is a heterodimer, comprising an A chain of 44 amino acid residues, 
gd; and a B chain of 50 residues [2]. The individual subunits are not sweet, 
gd; nor do they block the sweet sensation of sucrose or monellin. However, 
gd; blocking the single SH of monellin abolishes its sweetness, as does reaction 
gd; of its methionyl residue with CNBr [2]. The cysteinyl and methionyl residues
gd; are adjacent, and it has therefore been suggested that this part of the 
gd; molecule is essential for its sweetness [3]. 
gd;
gd; The structure of monellin belongs to the alpha/beta class, a 5-stranded
gd; beta-sheet sequestering a single alpha-helix. The B chain contributes 2
gd; strands to the sheet and provides the helix.
gd;
gd; MONELLINB is a 3-element fingerprint that provides a signature for the
gd; monellin B chain. The fingerprint was derived from an initial alignment
gd; of 2 sequences: the motifs span the full chain length - motif 1 encompasses
gd; the first small strand and the N-terminal portion of the helix; motif 2
gd; spans the C-terminal part of the helix; and motif 3 spans the second strand,
gd; which includes the reactive cysteinyl and methionyl residues. A single
gd; iteration on OWL29.0 was required to reach convergence, no further sequences
gd; being identified beyond the starting point.
gd;
gd; An update on OWL31_3 identified a true set of 2 sequences.
bb;
bb;
"""

lines = []
literature = []
description = []


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
    elif l[0] == 'gd':
        description.append(l[1])

# Post text processing part
# join the literature part and preserve the new lines
literature = '\n'.join(literature)

#Split literature entries by new lines
literature_entry = re.split('\n\s*\n', literature)
for l in literature_entry:
    parts = re.search('(?P<number>\w*)\. (?P<authors>.*)\n(?P<description>(.|\n)*)\n(?P<source>.*)\((?P<year>\d\d\d\d)\)', l, re.MULTILINE ).groupdict()

    print parts
    
# description
description = '\n'.join(description)
description = description.replace('\n','')

print description
