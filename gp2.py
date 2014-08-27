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
scan_history = []
crossreference = []
initial_motifs = []
final_motifs = []
inter_motif_distance = []
initial_seq = []
final_seq = []

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
        try:
            update_date = parts[1].lstrip( 'UPDATE ' );
            update_date = datetime.strptime(update_date, '%d-%b-%Y')
            update_date = datetime.date(update_date)
        except:
            update_date = False #there is no update date
    elif l[0] == 'gt':
        title = l[1]
    # databases (crossreference)
    elif l[0] == 'gp':
        crossreference.append(l[1])
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
        falsepartialpositives[falsepartialpositive_code] = falsepartialpositive_description
    elif l[0] == 'dn':
        scan_history.append(l[1])
    elif l[0] == 'ic': #initial motifs
        initial_motif = l[1]
    elif l[0] == 'il': #length of the initial motif
        initial_motif_length = l[1] 
    elif l[0] == 'it': #title of the initial motif
        initial_motif_title = l[1]
        initial_motifs.append([initial_motif,initial_motif_length,initial_motif_title])
    elif l[0] == 'id': #initial sequences
        initial_sequences_parts = l[1].split()
    elif l[0] == 'fc': #final motifs
        final_motif = l[1]
    elif l[0] == 'fl': #length of the final motif
        final_motif_length = l[1] 
    elif l[0] == 'ft': #title of the initial motif
        final_motif_title = l[1]
    elif l[0] == 'fd': #final sequences
        final_sequences_parts = l[1].split()
        final_seq.append([final_motif,final_sequences_parts])
    elif l[0] == 'KD': #intermotif distance
        inter_motif_distance_parts = re.search('INTER_MOTIF_DISTANCE REGION=(?P<region>.*);\s+MIN=(?P<min>.*);\s+MAX=(?P<max>.*)', l[1] ).groupdict()
        # Finally compose the final motif
        final_motifs.append([final_motif,final_motif_length,final_motif_title, inter_motif_distance_parts['region'],inter_motif_distance_parts['min'],inter_motif_distance_parts['max']])

# Before creating the fingerprint apply some fixes
summary = '\n'.join(summary)
# annotation
annotation = '\n'.join(annotation)
# cfi
cfi = '\n'.join(cfi)
# join the reference part and preserve the new lines
reference = '\n'.join(reference)

# SQL Part 
# Create the fingerprint
try:
    cur.execute("INSERT INTO fingerprint (identifier, accession, no_motifs, creation_date, title, annotation, cfi, summary) VALUES (%s,%s,%s,%s,%s,%s,%s,%s) RETURNING id",(identifier, accession, no_motifs, creation_date, title, annotation, cfi, summary ))
    fingerprint_id = cur.fetchone()[0]
    print "Populating info for fingerprint ", identifier, " with id ", fingerprint_id
except psycopg2.DatabaseError, e:
    print 'Error %s' % e

# Set update date if there is such

if update_date:
    try:
        cur.execute("UPDATE fingerprint SET update_date = %s WHERE id = %s",(update_date, fingerprint_id))
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e 

# Split reference entries by new lines
reference_entry = re.split('\n\s*\n', reference)
for l in reference_entry:
    reference_parts = re.search('(?P<number>\w*)\. (?P<author>.*\n?[A-Z]{2,}.*)\n(?P<title>(.|\n)*)\n(?P<journal>.*)\((?P<year>\d\d\d\d)\)', l, re.MULTILINE ).groupdict()
    try:
        cur.execute("INSERT INTO reference(fingerprint_id, author, title, journal, year) VALUES (%s,%s,%s,%s,%s)", (fingerprint_id, reference_parts['author'].rstrip('\n'), reference_parts['title'], reference_parts['journal'], reference_parts['year'])) 
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e
        
for key, value in falsepartialpositives.items():
    try:
        cur.execute("INSERT INTO falsepartialpositives(fingerprint_id, code, description) VALUES (%s,%s,%s)", (fingerprint_id, key, value)) 
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e

for l in scan_history:
    scan_history_parts = l.split()
    sh_database = scan_history_parts[0]
    sh_iterations = scan_history_parts[1]
    sh_hitlist_length = scan_history_parts[2] 
    sh_scanning_method = scan_history_parts[3]
    try:
        cur.execute("INSERT INTO scanhistory(database, iterations_number, hitlist_length, scanning_method, fingerprint_id) VALUES (%s,%s,%s,%s,%s)", (sh_database, sh_iterations, sh_hitlist_length, sh_scanning_method, fingerprint_id))
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e

for l in crossreference:
        parts = l.split(';')
        db = parts[0]
        for el in parts[1:]:
            pp = string.lstrip(el).split(' ')
            if len(pp) < 2:
                #print 'Database:\t%s\nAccession:\t%s\n' % (db, pp[0])
                try:
                    cur.execute("INSERT INTO crossreference(fingerprint_id,name,accession) VALUES (%s,%s,%s)", (fingerprint_id, db, pp[0]))
                except psycopg2.DatabaseError, e:
                    print 'Error %s' % e
            else:
                #print 'Database:\t%s\nAccession:\t%s\nTitle:\t\t%s\n' % (db, pp[0], pp[1])
                try:
                    cur.execute("INSERT INTO crossreference(fingerprint_id,name,accession, identifier) VALUES (%s,%s,%s,%s)", (fingerprint_id, db, pp[0],pp[1]))
                except psycopg2.DatabaseError, e:
                    print 'Error %s' % e
       
for l in initial_motifs:
    try:
        cur.execute("INSERT INTO motif(fingerprint_id,code,length,title,position) VALUES (%s,%s,%s,%s,%s)", (fingerprint_id, l[0], l[1], l[2], 'initial'))
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e

for l in inter_motif_distance:
    inter_motif_distance_parts = re.search('INTER_MOTIF_DISTANCE REGION=(?P<region>\d+\-\d+);\s+MIN=(?P<min>\d+);\s+MAX=(?P<max>\d+)', l ).groupdict()
    #print inter_motif_distance_parts['region'] + '    ' + inter_motif_distance_parts['min'] + '    ' + inter_motif_distance_parts['max']
        
for l in final_motifs:
    # create the motif
    try:
        cur.execute("INSERT INTO motif(fingerprint_id,code,length,title,position) VALUES (%s,%s,%s,%s,%s) RETURNING motif_id", (fingerprint_id, l[0], l[1], l[2], 'final'))
        id_of_new_motif = cur.fetchone()[0]
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e        
    # insert the intermotif distance
    try:
        cur.execute("INSERT INTO intermotifdistance(motif_id,region,min,max) VALUES (%s,%s,%s,%s)", (id_of_new_motif, l[3], l[4], l[5]))
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e 

for l in initial_seq:
    try:
        #get the corresponding motif_id first
        cur.execute("SELECT motif_id FROM motif WHERE code = %s and position = 'initial'", (l[0],))
        motif_id = cur.fetchone()[0]
        cur.execute("INSERT INTO seq(motif_id,sequence,pcode,start,interval) VALUES (%s,%s,%s,%s,%s)", (motif_id, l[1][0], l[1][1], l[1][2], l[1][3]))
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e

for l in final_seq:
    try:
        #get the corresponding motif_id first
        cur.execute("SELECT motif_id FROM motif WHERE code = %s and position = 'final'", (l[0],))
        motif_id = cur.fetchone()[0]
        cur.execute("INSERT INTO seq(motif_id,sequence,pcode,start,interval) VALUES (%s,%s,%s,%s,%s)", (motif_id, l[1][0], l[1][1], l[1][2], l[1][3]))
    except psycopg2.DatabaseError, e:
        print 'Error %s' % e        