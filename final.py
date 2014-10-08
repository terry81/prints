#!/usr/bin/python
import sys
import string
import re
from datetime import datetime
import psycopg2

fingerprints_file = open( "prints42_0.kdat", "r" )
fingerprints_content = fingerprints_file.read()
fingerprints = fingerprints_content.split('---custom_delimiter_for_fingerprint---')

# db part
try:
    conn=psycopg2.connect("dbname='prints_2' host='localhost' user='anatoliyd' password='adimitrov'")
except:
    print "I am unable to connect to the database."
    sys.exit('Exiting...')

cur = conn.cursor()
conn.autocommit = True #in case we want to commit automatically

for entry in fingerprints:
    if not entry: #skip empty entry
            continue

    try:
        lines = []
        reference = []
        annotation = []
        summary = []
        cfi  = [] #composite fingerprint index
        proteins = {}
        truepartialpositives = {}
        true_positives = []
        motifs = []
        scan_history = []
        crossreference = []
        initial_motifs = []
        final_motifs = []
        inter_motif_distance = []
        initial_seq = []
        final_seq = []
        
        for l in entry.splitlines(False):
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
                try:
                    no_motifs = re.search('COMPOUND\((\d+)\)', l[1]).group(1)
                except:
                    no_motifs = ''
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
                try:
                    reference.append(l[1])
                except:
                    reference = 0 
            elif l[0] == 'gd':
                annotation.append(l[1])
            elif l[0] == 'sd':
                summary.append(l[1])
            elif l[0] == 'cd':
                cfi.append(l[1])
            elif l[0] == 'tt':
                if not l[1]: #skip empty lines
                    continue
                try:
                    protein_parts = re.split('\s{4,}', l[1])
                    protein_code = protein_parts[0]
                    protein_description = protein_parts[1].lstrip()
                    proteins[protein_code] = protein_description
                except:
                    print 'Problem with falsepartialpositive line(empty?): ', l[1]
            elif l[0] == 'tp': #true positives
                tp_entry = l[1].split()
                for i in tp_entry:
                    true_positives.append(i)
            elif l[0] == 'sn': #true partial positives number of elements
                tpp_number_of_elements = re.search(r'Codes involving (\d+) elements', l[1]).group(1)
            elif l[0] == 'st':
                true_partial_entry = l[1].split()
                for i in true_partial_entry:
                    truepartialpositives[i] = tpp_number_of_elements 
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
                initial_seq.append([initial_motif,initial_sequences_parts])
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
            print 'Fingerprint ', 'Error %s' % e

        # Set update date if there is such

        if update_date:
            try:
                cur.execute("UPDATE fingerprint SET update_date = %s WHERE id = %s",(update_date, fingerprint_id))
            except psycopg2.DatabaseError, e:
                print 'Update ','Error %s' % e 

        # Split reference entries by new lines
        reference_entry = re.split('\n\s*\n', reference)

        for l in reference_entry:
            try:
                reference_parts = re.search('(?P<number>\w*)\. (?P<author>.*\n?[A-Z]{2,}.*)\n(?P<title>.*[a-z]{2,}.*\n?.*[a-z]{2,}.*)\n(?P<journal>.*)\((?P<year>\d\d\d\d)\)', l, re.MULTILINE ).groupdict()
            except: 'Cannot parse reference for ', identifier, " with id ", fingerprint_id, l
            try:
                cur.execute("INSERT INTO reference(fingerprint_id, author, title, journal, year) VALUES (%s,%s,%s,%s,%s)", (fingerprint_id, reference_parts['author'].rstrip('\n'), reference_parts['title'], reference_parts['journal'], reference_parts['year'])) 
            except psycopg2.DatabaseError, e:
                print 'Reference ','Error %s' % e
                print reference_entry
                
        for key, value in proteins.items():
            try:
                cur.execute("INSERT INTO protein(fingerprint_id, code, description) VALUES (%s,%s,%s)", (fingerprint_id, key, value)) 
            except psycopg2.DatabaseError, e:
                print 'Falsepartialpositives ','Error %s' % e

        for l in scan_history:
            scan_history_parts = l.split()
            sh_database = scan_history_parts[0]
            sh_iterations = scan_history_parts[1]
            sh_hitlist_length = scan_history_parts[2] 
            sh_scanning_method = scan_history_parts[3]
            try:
                cur.execute("INSERT INTO scanhistory(database, iterations_number, hitlist_length, scanning_method, fingerprint_id) VALUES (%s,%s,%s,%s,%s)", (sh_database, sh_iterations, sh_hitlist_length, sh_scanning_method, fingerprint_id))
            except psycopg2.DatabaseError, e:
                print 'Scan history ','Error %s' % e

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
                            print 'Crossreference case 1', 'Error %s' % e
                    else:
                        #print 'Database:\t%s\nAccession:\t%s\nTitle:\t\t%s\n' % (db, pp[0], pp[1])
                        try:
                            cur.execute("INSERT INTO crossreference(fingerprint_id,name,accession, identifier) VALUES (%s,%s,%s,%s)", (fingerprint_id, db, pp[0],pp[1]))
                        except psycopg2.DatabaseError, e:
                            print 'Crossreference case 2','Error %s' % e
               
        for l in initial_motifs:
            try:
                cur.execute("INSERT INTO motif(fingerprint_id,code,length,title,position) VALUES (%s,%s,%s,%s,%s)", (fingerprint_id, l[0], l[1], l[2], 'initial'))
            except psycopg2.DatabaseError, e:
                print 'Initial motifs ','Error %s' % e

        for l in inter_motif_distance:
            inter_motif_distance_parts = re.search('INTER_MOTIF_DISTANCE REGION=(?P<region>\d+\-\d+);\s+MIN=(?P<min>\d+);\s+MAX=(?P<max>\d+)', l ).groupdict()
                
        for l in final_motifs:
            # create the motif
            try:
                cur.execute("INSERT INTO motif(fingerprint_id,code,length,title,position) VALUES (%s,%s,%s,%s,%s) RETURNING motif_id", (fingerprint_id, l[0], l[1], l[2], 'final'))
                id_of_new_motif = cur.fetchone()[0]
            except psycopg2.DatabaseError, e:
                print 'Motif ','Error %s' % e        
            # insert the intermotif distance
            try:
                cur.execute("INSERT INTO intermotifdistance(motif_id,region,min,max) VALUES (%s,%s,%s,%s)", (id_of_new_motif, l[3], l[4], l[5]))
            except psycopg2.DatabaseError, e:
                print 'Intermotifdistance ', 'Error %s' % e 

        for l in initial_seq:
            try:
                #get the corresponding motif_id first
                cur.execute("SELECT motif_id FROM motif WHERE code = %s and position = 'initial'", (l[0],))
                motif_id = cur.fetchone()[0]
                cur.execute("INSERT INTO seq(motif_id,sequence,pcode,start,interval) VALUES (%s,%s,%s,%s,%s)", (motif_id, l[1][0], l[1][1], l[1][2], l[1][3]))
            except psycopg2.DatabaseError, e:
                print 'Initial seq', 'Error %s' % e

        for l in final_seq:
            try:
                #get the corresponding motif_id first
                cur.execute("SELECT motif_id FROM motif WHERE code = %s and position = 'final'", (l[0],))        
                try:
                    motif_id = cur.fetchone()[0]
                except:
                    print "Seqs cannot be inserted for final motifs for fingerprint ", identifier
                    continue
                cur.execute("INSERT INTO seq(motif_id,sequence,pcode,start,interval) VALUES (%s,%s,%s,%s,%s)", (motif_id, l[1][0], l[1][1], l[1][2], l[1][3]))
            except psycopg2.DatabaseError, e:
                print 'Final seq ', 'Error %s' % e
        for i in true_positives:
            try:
                cur.execute("select id from protein where fingerprint_id= %s and code= %s", (fingerprint_id,i))
                protein_id = cur.fetchone()[0]
                cur.execute("INSERT INTO truepositives(fingerprint_id,protein_id) VALUES (%s,%s)", (fingerprint_id, protein_id))
            except psycopg2.DatabaseError, e:
                print 'True positives ', 'Error %s' % e
        for key, value in truepartialpositives.items():
            try:
                cur.execute("select id from protein where fingerprint_id= %s and code= %s", (fingerprint_id,key))
                protein_id = cur.fetchone()[0]
                cur.execute("INSERT INTO truepartialpositives(fingerprint_id, protein_id, numberofelements) VALUES (%s,%s,%s)", (fingerprint_id, protein_id, value)) 
            except psycopg2.DatabaseError, e:
                print 'Falsepartialpositives ','Error %s' % e
    except:
        print "Problem with FP ", entry