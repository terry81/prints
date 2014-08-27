#!/usr/bin/python

import sys
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
    sys.exit('Exiting...')

cur = conn.cursor()
conn.autocommit = True #in case we want to commit automatically


lines = []
reference = []
annotation = []
summary = []
cfi  = [] #composite fingerprint index
falsepartialpositives = {}
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
        reference.append(l[1])
    elif l[0] == 'gd':
        annotation.append(l[1])
    elif l[0] == 'sd':
        summary.append(l[1])
    elif l[0] == 'cd':
        cfi.append(l[1])
    elif l[0] == 'tt':
        falsepartialpositive_parts = l[1].split('      ')
        falsepartialpositive_code = falsepartialpositive_parts[0]
        falsepartialpositive_description = falsepartialpositive_parts[1]
        #print falsepartialpositive_code + falsepartialpositive_description
        falsepartialpositives[falsepartialpositive_code] = falsepartialpositive_description
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


############## SQL Part #############

# Create the fingerprint
try:
    print cur.execute("""INSERT INTO fingerprint (identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)""",(identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary ))
except psycopg2.DatabaseError, e:
    print 'Error %s' % e
#    sys.exit('Exiting...')

# Get the id of the fingerprint
try:
    cur.execute("SELECT id FROM fingerprint WHERE identifier = %s", (identifier,))
    fingerprint_id = cur.fetchone()[0]
    print "Populating info for fingerprint " + identifier + "with id " + str(fingerprint_id)
except psycopg2.DatabaseError, e:
    print 'Error %s' % e
    sys.exit('Exiting...')
        
#########################################################        
# Post text processing part
# join the reference part and preserve the new lines
reference = '\n'.join(reference)

# Split reference entries by new lines
reference_entry = re.split('\n\s*\n', reference)
for l in reference_entry:
    reference_parts = re.search('(?P<number>\w*)\. (?P<author>.*\n?.*[A-Z]?)\n(?P<title>(.|\n)*)\n(?P<journal>.*)\((?P<year>\d\d\d\d)\)', l, re.MULTILINE ).groupdict()
#    print reference_parts
    cur.execute("INSERT INTO reference(fingerprint_id, author, title, journal, year) VALUES (%s,%s,%s,%s,%s)", (fingerprint_id, reference_parts['author'].rstrip('\n'), reference_parts['title'], reference_parts['journal'], reference_parts['year'])) 

# falsepartialpositives    

print '##############'
for key, value in falsepartialpositives.items():
    #print key + '#####' + value
    cur.execute("INSERT INTO falsepartialpositives(fingerprint_id, code, description) VALUES (%s,%s,%s)", (fingerprint_id, key, value)) 

print '##############'    
    
# annotation
annotation = '\n'.join(annotation)
#annotation = description.replace('\n','') #remove the new lines in description. not sure if needed.

# summary 
summary = '\n'.join(summary)

# cfi
cfi = '\n'.join(cfi)


    
# commit when all is fine    
# conn.commit()	


#########################################################        
# sanity checks and prints

#print reference	
#print identifier
#print no_motifs
#print accession
#print creation_date
#print update_date

#print title
#print description
#print summary
#print cfi
#print falsepartialpositives
