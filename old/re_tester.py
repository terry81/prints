#!/usr/bin/python

import sys
import string
import re
from datetime import datetime
import psycopg2

lines = []
reference = []
annotation = []
summary = []
cfi  = [] #composite fingerprint index
protein = {}
truepartialpositives = []
motifs = []
scan_history = []
crossreference = []
initial_motifs = []
final_motifs = []
inter_motif_distance = []
initial_seq = []
final_seq = []
true_positives = []
accession_entries = []
tp_acc_combo = {}
tpp_acc_combo = {}
tpp_number_of_elevements = {}
a_entries = []
a1_entries = []
tppa_entries = []
reference_parts = {}


# file part
file = open('FMOXYGENASE4.txt', 'r')
content = file.read()

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
	#COMPOUND(6)
	try:
    	    no_motifs = re.search('COMPOUND\((\d+)\)', l[1]).group(1)
            #print no_motifs
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
            falsepartialpositive_parts = re.split('\s{4,}', l[1])
            falsepartialpositive_code = falsepartialpositive_parts[0]
            falsepartialpositive_description = falsepartialpositive_parts[1].lstrip()
            protein[falsepartialpositive_code] = falsepartialpositive_description
        except:
            print 'Problem with falsepartialpositive line(empty?): ', l[1]
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
    elif l[0] == 'tp': #true positives
        tp_entry = l[1].split()
        for i in tp_entry:
            true_positives.append(i)
    elif l[0] == 'KA': #true positives accession number
        entries = re.findall('([A-Z0-9]*)\s*[M|D]+1', l[1])
        a_entries += entries
    elif l[0] == 'sn': #true partial positives number of elements
        tpp_number_of_elements = re.search(r'Codes involving (\d+) elements', l[1]).group(1)
    elif l[0] == 'st':
        true_partial_entry = l[1].split()
        for i in true_partial_entry:
            truepartialpositives.append(i)
            tpp_number_of_elevements[i] = tpp_number_of_elements
    elif l[0] == 'K1': #true partial positives accession number
        entries_1 = re.findall('([A-Z0-9]*)\s*[M|D]+1', l[1])
        tppa_entries += entries_1
            

# Split reference entries by new lines

reference = '\n'.join(reference)

reference_entry = re.split('\n\s*\n', reference)

for l in reference_entry:
    #create a new temporary list to take the literature from its last entry
    temp_list = l.splitlines()
    reference_parts['literature'] = temp_list.pop(-1)
    reference_parts['authors'] = temp_list.pop(0)
    reference_parts['title'] = ''
    # in the most simple way we have only one row remaining for the title
    print len(temp_list)
    if len(temp_list) == 1:
        print 'simple literature'
        reference_parts['title'] = temp_list[0]
    else:
        for line in temp_list:
            if re.search('[a-z]',line):
                reference_parts['title'] += line
            else:
                reference_parts['authors'] += line    
    #reference_parts = re.search('(?P<number>^\d+)\. (?P<author>.*([A-Z]{2,}.*\n?)+\.)\n(?P<title>[A-Z]+(.*[a-z]{2,}.*\n?)+\n?.*)\n.*', l, re.MULTILINE ).groupdict()    
    print reference_parts

        
        
        
        
