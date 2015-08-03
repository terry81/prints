#!/usr/bin/python
from bs4 import BeautifulSoup
import urllib2
import re
import psycopg2
import time

try:
    conn=psycopg2.connect("dbname='prints_2' host='localhost' user='anatoliyd' password='REMOVED'")
except:
    print "I am unable to connect to the database."
    sys.exit('Exiting...')

cur = conn.cursor()
conn.autocommit = True #in case we want to commit automatically

# fetch all the accession numbers

cur.execute('select accession from fingerprint')

accessions = cur.fetchall()

for i in accessions:
	time.sleep(5)
	url = urllib2.urlopen("http://www.bioinf.manchester.ac.uk/cgi-bin/dbbrowser/sprint/getfamilytree.cgi?query="+i[0])
	html = url.read()
	try:
		parent = re.search('</font></td><td><font color=\'#7a46ee\'>([A-Z0-9]+)</font>', html).group(1)
		if parent:
			cur.execute("UPDATE fingerprint SET parented = %s WHERE accession = %s",(parent, i[0]))
	except:
		print i[0],' ->  no parent'
