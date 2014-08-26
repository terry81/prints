#!/usr/bin/python

import string
import re
from datetime import datetime
import psycopg2

# file part
file = open('bigfp.txt', 'r')
content = file.read()

# db part
try:
    conn=psycopg2.connect("dbname='prints_2' host='192.168.100.104' user='anatoliy' password='1a1a@S@S'")
except:
    print "I am unable to connect to the database."
cur = conn.cursor()


lines = []
literature = []
annotation = []
summary = []
cfi  = [] #composite fingerprint index
falsepartialpositives = []
motifs = []
initial_motif = 'default'
#########################################################        
# Core text parsing part
for l in content.splitlines(False):
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
        # convert date from a string to proper date format ready to be inserted in the database
        creation_date = datetime.strptime(parts[0], '%d-%b-%Y')
        creation_date = datetime.date(creation_date)
        # the same convertion for update date 
        update_date = parts[1].lstrip( 'UPDATE ' );
        update_date = datetime.strptime(update_date, '%d-%b-%Y')
        update_date = datetime.date(update_date)
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
        annotation.append(l[1])
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
        initial_motif = (l[1]) + 'YYYYY'
        print 'XXXX' + initial_motif # print the motif
    elif l[0] == 'il': #length of the initial motif
        print l[1] 
    elif l[0] == 'it': #title of the initial motif
        print l[1]
    elif l[0] == 'id': #initial sequences
        initial_sequences_parts = l[1].split()
        sequence = initial_sequences_parts[0]
        pcode = initial_sequences_parts[1]
        start = initial_sequences_parts[2]
        interval = initial_sequences_parts[3]
        #print initial_motif + ': ' + '---' + pcode + '---' + start + '---' + interval 
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
    #print literature_parts
# annotation
annotation = '\n'.join(annotation)
#annotation = description.replace('\n','') #remove the new lines in description. not sure if needed.

# summary 
summary = '\n'.join(summary)

# cfi
cfi = '\n'.join(cfi)


#########################################################        
# sanity checks and prints

try:
    cur.execute("""INSERT INTO fingerprint (identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)""",(identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary ))
#   id_of_fingerprint = cur.fetchone()[0]

except:
    print "Cannot execute insert..."
    print e.pgerror
    print e.diag.message_detail

	
conn.commit()
	
#print identifier
#print no_motifs
#print accession
#print creation_date
#print update_date

#print title
#print description
#print summary
#print cfi
