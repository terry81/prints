#!/usr/bin/python

import string

content = """
gp; PRINTS; PR00209 GLIADIN; PR00208 GLIADGLUTEN; PR00210 GLUTENIN
gp; PRINTS; PR00551 2SGLOBULIN
gp; INTERPRO; IPR006044
gp; PROSITE; PS00305 11S_SEED_STORAGE
gp; PDB; 2E9Q; 2EVX; 1OD5; 1UD1; 1UCX
"""

lines = []

for l in content.split('\n'):
	tag, sep, contents = l.partition(';')
	contents = contents.lstrip()
	lines.append( (tag, contents) )

print lines

for l in lines:
	if l[0] != 'gp':
		continue

	parts = l[1].split(';')

	db = parts[0]
	for el in parts[1:]:
		pp = string.lstrip(el).split(' ')
		if len(pp) < 2:
			print 'Database:\t%s\nAccession:\t%s\n' % (db, pp[0])
		else:
			print 'Database:\t%s\nAccession:\t%s\nTitle:\t\t%s\n' % (db, pp[0], pp[1])

