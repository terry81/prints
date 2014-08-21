#!/usr/bin/python

import string
import re

file = open('MONELLINB.txt', 'r')
content = file.read()

lines = []
literature = []
description = []
summary = []
cfi  = [] #composite fingerprint index
falsepartialpositives = []
motifs = []

#########################################################        
# Core text parsing part
for l in content.split('\n'):
    tag, sep, contents = l.partition(';')
    contents = contents.lstrip()
    lines.append( (tag, contents) )

for l in lines:
    # identifier
    if l[0] == 'gc':
        identifier = l[1]
    # accession    
    elif l[0] == 'gx':
        accession = l[1]
    # no_motifs
    elif l[0] == 'gn':
        no_motifs = l[1]
    # dates
    elif l[0] == 'ga':
        parts = l[1].split(';')
        creation_date = parts[0]
        update_date = parts[1].lstrip( 'UPDATE ' );
    elif l[0] == 'gt':
        title = l[1]
    # databases
    elif l[0] == 'gp':
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
    elif l[0] == 'sd':
        summary.append(l[1])
    elif l[0] == 'cd':
        cfi.append(l[1])
    elif l[0] == 'tt':
        falsepartialpositive_parts = l[1].split('     ')
        falsepartialpositive_code = falsepartialpositive_parts[0]
        falsepartialpositive_description = falsepartialpositive_parts[1]
        #print falsepartialpositive_code + falsepartialpositive_description
    elif l[0] == 'dn':
        #scan_history.append(l[1])
        scan_history_parts = l[1].split()
        sh_database = scan_history_parts[0]
        sh_iterations = scan_history_parts[1]
        sh_hitlist_length = scan_history_parts[2] 
        sh_scanning_method = scan_history_parts[3]
        #print sh_database + ' ' + sh_iterations + ' ' + sh_hitlist_length + ' ' + sh_scanning_method
    elif l[0] == 'ic': #initial motifs
        print l[1] # print the motif
    elif l[0] == 'il': #length of the initial motif
        print l[1] 
    elif l[0] == 'it': #title of the initial motif
        print l[1]
    elif l[0] == 'id': #initial sequences
        # GRLTFNKVIRPCMKKTIYE              MONB_DIOCU     30    -1
        initial_sequences_parts = l[1].split()
        sequence = initial_sequences_parts[0]
        pcode = initial_sequences_parts[1]
        start = initial_sequences_parts[2]
        interval = initial_sequences_parts[3]
        #print sequence + '---' + pcode + '---' + start + '---' + interval 
    elif l[0] == 'fc': #final motifs
        print l[1]
    elif l[0] == 'fl': #length of the final motif
        print l[1]
    elif l[0] == 'ft': #title of the initial motif
        print l[1]
    elif l[0] == 'fd': #final sequences
        final_sequences_parts = l[1].split()
        sequence = initial_sequences_parts[0]
        pcode = initial_sequences_parts[1]
        start = initial_sequences_parts[2]
        interval = initial_sequences_parts[3]
        #print sequence + '---' + pcode + '---' + start + '---' + interval
        
#########################################################        
# Post text processing part
# join the literature part and preserve the new lines
literature = '\n'.join(literature)

#Split literature entries by new lines
literature_entry = re.split('\n\s*\n', literature)
for l in literature_entry:
    literature_parts = re.search('(?P<number>\w*)\. (?P<authors>.*)\n(?P<description>(.|\n)*)\n(?P<source>.*)\((?P<year>\d\d\d\d)\)', l, re.MULTILINE ).groupdict()

# description
description = '\n'.join(description)
#description = description.replace('\n','') #remove the new lines in description. not sure if needed.

# summary 
summary = '\n'.join(summary)

# cfi
cfi = '\n'.join(cfi)


#########################################################        
# sanity checks and prints

#print no_motifs
#print identifier
#print accession
#print creation_date
#print update_date
#print literature_parts
#print title
#print description
#print summary
#print cfi
