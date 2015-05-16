#!/usr/bin/python

import sys
import string
import psycopg2


# db part
try:
    conn=psycopg2.connect("dbname='prints_2' host='localhost' user='anatoliyd' password='adimitrov'")
except:
    print "I am unable to connect to the database."
    sys.exit('Exiting...')

cur = conn.cursor()
conn.autocommit = True #in case we want to commit automatically

fingerprint=sys.argv[1]

# confirm fingerprint identifier

print 'Looking up fingerprint: ', fingerprint

# determine the fingerprint id number

try:
	cur.execute("SELECT id FROM fingerprint WHERE identifier = %s", (fingerprint,))
	if cur.rowcount == 0:
		print 'No fingerprints found by that identifier.'
		sys.exit()
	elif cur.rowcount > 1:
		print 'More than one fingerprint matches this condition. Exiting...'
		sys.exit()
	else:
		fingerprint_id = cur.fetchone()[0]
		print 'Deleting fingerprint with id: ', fingerprint_id
except psycopg2.DatabaseError, e:
	print 'Problems finding fingerprint id: ', 'Error %s' % e
	

# find out all motifs for this fingerprint
try:
	cur.execute("SELECT motif_id FROM motif WHERE fingerprint_id = %s", (fingerprint_id,))
	motifs = cur.fetchall()
except psycopg2.DatabaseError, e:
	print 'Problems finding motifs id: ', 'Error %s' % e
	
for motif_id in motifs:
	try:
		cur.execute("delete from intermotifdistance where motif_id = %s", (motif_id[0],))
		cur.execute("delete from seq where motif_id = %s", (motif_id[0],))
	except psycopg2.DatabaseError, e:
		print 'Problems deleting... ', 'Error %s' % e

try:
	cur.execute("delete from crossreference where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from reference where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from scanhistory where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from truepartialpositives where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from truepositives where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from protein where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from motif where fingerprint_id = %s", (fingerprint_id,))
	cur.execute("delete from fingerprint where id = %s", (fingerprint_id,))
except psycopg2.DatabaseError, e:
	print 'Problems deleting... ', 'Error %s' % e
	

	
# delete from crossreference where fingerprint_id=
### delete from intermotifdistance where motif_id=(select motif_id from motif where fingerprint_id=(select id from fingerprint where identifier='PHEHYDRXLASETT'));
# delete from protein where fingerprint_id=
# delete from reference where fingerprint_id=
# delete from scanhistory where fingerprint_id=
### delete from seq where motif_id=
# delete from truepartialpositives where fingerprint_id=
# delete from truepositives where fingerprint_id=
# delete from motif where fingerprint_id=
# delete from fingerprint where fingerprint_id=
