--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: prints; Type: SCHEMA; Schema: -; Owner: anatoliy
--

CREATE SCHEMA prints;


ALTER SCHEMA prints OWNER TO anatoliy;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: enum_position; Type: TYPE; Schema: public; Owner: anatoliy
--

CREATE TYPE enum_position AS ENUM (
    'initial',
    'final'
);


ALTER TYPE public.enum_position OWNER TO anatoliy;

--
-- Name: position; Type: TYPE; Schema: public; Owner: anatoliy
--

CREATE TYPE "position" AS ENUM (
    'initial',
    'secondary'
);


ALTER TYPE public."position" OWNER TO anatoliy;

--
-- Name: seq_position; Type: TYPE; Schema: public; Owner: anatoliy
--

CREATE TYPE seq_position AS ENUM (
    'initial',
    'final'
);


ALTER TYPE public.seq_position OWNER TO anatoliy;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: crossreference; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE crossreference (
    fingerprint_id integer,
    name character varying(15),
    accession character varying(15),
    identifier character varying(15),
    reference_id integer NOT NULL
);


ALTER TABLE public.crossreference OWNER TO anatoliy;

--
-- Name: falsepartialpositives; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE falsepartialpositives (
    id integer NOT NULL,
    fingerprint_id integer,
    code character varying(20),
    description character varying(100)
);


ALTER TABLE public.falsepartialpositives OWNER TO anatoliy;

--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE falsepartialpositives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.falsepartialpositives_id_seq OWNER TO anatoliy;

--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE falsepartialpositives_id_seq OWNED BY falsepartialpositives.id;


--
-- Name: fingerprint; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE fingerprint (
    id integer NOT NULL,
    identifier character varying(15),
    accession character varying(15),
    no_motifs character varying(100),
    creation_date date,
    update_date date,
    title character varying(50),
    annotation text,
    cfi text,
    summary text
);


ALTER TABLE public.fingerprint OWNER TO anatoliy;

--
-- Name: fingerprint_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE fingerprint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fingerprint_id_seq OWNER TO anatoliy;

--
-- Name: fingerprint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE fingerprint_id_seq OWNED BY fingerprint.id;


--
-- Name: intermotifdistance; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE intermotifdistance (
    imd_id integer NOT NULL,
    motif_id integer,
    region character varying(10),
    min integer,
    max integer
);


ALTER TABLE public.intermotifdistance OWNER TO anatoliy;

--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE intermotifdistance_imd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intermotifdistance_imd_id_seq OWNER TO anatoliy;

--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE intermotifdistance_imd_id_seq OWNED BY intermotifdistance.imd_id;


--
-- Name: reference; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE reference (
    fingerprint_id integer,
    author character varying(100),
    title character varying(100),
    journal character varying(100),
    literature_id integer NOT NULL,
    year smallint
);


ALTER TABLE public.reference OWNER TO anatoliy;

--
-- Name: literature_literature_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE literature_literature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.literature_literature_id_seq OWNER TO anatoliy;

--
-- Name: literature_literature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE literature_literature_id_seq OWNED BY reference.literature_id;


--
-- Name: motif; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE motif (
    motif_id integer NOT NULL,
    fingerprint_id integer,
    code character varying(15),
    length integer,
    title character varying(100)
);


ALTER TABLE public.motif OWNER TO anatoliy;

--
-- Name: motif_motif_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE motif_motif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motif_motif_id_seq OWNER TO anatoliy;

--
-- Name: motif_motif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE motif_motif_id_seq OWNED BY motif.motif_id;


--
-- Name: reference_reference_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE reference_reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_reference_id_seq OWNER TO anatoliy;

--
-- Name: reference_reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE reference_reference_id_seq OWNED BY crossreference.reference_id;


--
-- Name: scanhistory; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE scanhistory (
    sh_id integer NOT NULL,
    database character varying(15),
    iterations_number integer,
    hitlist_length integer,
    scanning_method character varying(15),
    fingerprint_id integer
);


ALTER TABLE public.scanhistory OWNER TO anatoliy;

--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE scanhistory_sh_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scanhistory_sh_id_seq OWNER TO anatoliy;

--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE scanhistory_sh_id_seq OWNED BY scanhistory.sh_id;


--
-- Name: seq; Type: TABLE; Schema: public; Owner: anatoliy; Tablespace: 
--

CREATE TABLE seq (
    seq_id integer NOT NULL,
    motif_id integer,
    sequence character varying(30),
    pcode character varying(10),
    start integer,
    "interval" smallint,
    "position" seq_position
);


ALTER TABLE public.seq OWNER TO anatoliy;

--
-- Name: seq_seq_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliy
--

CREATE SEQUENCE seq_seq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_seq_id_seq OWNER TO anatoliy;

--
-- Name: seq_seq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliy
--

ALTER SEQUENCE seq_seq_id_seq OWNED BY seq.seq_id;


--
-- Name: reference_id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY crossreference ALTER COLUMN reference_id SET DEFAULT nextval('reference_reference_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY falsepartialpositives ALTER COLUMN id SET DEFAULT nextval('falsepartialpositives_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY fingerprint ALTER COLUMN id SET DEFAULT nextval('fingerprint_id_seq'::regclass);


--
-- Name: imd_id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY intermotifdistance ALTER COLUMN imd_id SET DEFAULT nextval('intermotifdistance_imd_id_seq'::regclass);


--
-- Name: motif_id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY motif ALTER COLUMN motif_id SET DEFAULT nextval('motif_motif_id_seq'::regclass);


--
-- Name: literature_id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY reference ALTER COLUMN literature_id SET DEFAULT nextval('literature_literature_id_seq'::regclass);


--
-- Name: sh_id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY scanhistory ALTER COLUMN sh_id SET DEFAULT nextval('scanhistory_sh_id_seq'::regclass);


--
-- Name: seq_id; Type: DEFAULT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY seq ALTER COLUMN seq_id SET DEFAULT nextval('seq_seq_id_seq'::regclass);


--
-- Data for Name: crossreference; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY crossreference (fingerprint_id, name, accession, identifier, reference_id) FROM stdin;
1	PROSITE	PS00305	11S_SEED_STORAG	1
1	PDB	2E9Q	\N	2
1	SCOP	1OD5	\N	3
1	SCOP	1UD1	\N	4
1	SCOP	1UCX	\N	5
1	PRINTS	PR00209	GLIADIN	6
1	PRINTS	PR00208	GLIADGLUTEN	7
1	PRINTS	PR00210	GLUTENIN	8
1	PRINTS	PR00551	2SGLOBULIN	9
3	INTERPRO	IPR002095	\N	13
3	PDB	1MOL	\N	14
3	SCOP	1MOL	\N	15
3	CATH	1MOL	\N	16
3	PRINTS	PR00347	THAUMATIN	17
3	PRINTS	PR00630	MONELLINA	12
\.


--
-- Data for Name: falsepartialpositives; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY falsepartialpositives (id, fingerprint_id, code, description) FROM stdin;
1	3	MONB_DIOCU	MONELLIN, CHAIN B (CHAIN II) - DIOSCOREOPHYLLUM CUMMINSII (SERENDIPITY BERRY).
2	3	NRL_1MOLA	Monellin (single-chain, fused), chain A - serendipity berry
\.


--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('falsepartialpositives_id_seq', 2, true);


--
-- Data for Name: fingerprint; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY fingerprint (id, identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary) FROM stdin;
1	11SGLOBULIN	PR00439	COMPOUND(6)	1995-11-16	2010-03-05	11-S seed storage protein family signature	Plant seed storage proteins that provide the major nitrogen source for\r\ndeveloping plants may be classified into a number of different families.\r\nThe 11-S family are non-glycosylated proteins that form hexameric\r\nstructures [1,2]. Each of the constituent subunits comprises an acidic and\r\na basic chain derived from a single precursor and linked by a disulphide\r\nbond. Members of the 11-S family include pea and broad bean legumins; rape\r\ncruciferin; rice glutelins; cotton beta-globulins; soybean glycinins;\r\npumpkin 11-S globulin; oat globulin; and so on.\r\n11SGLOBULIN is a 6-element fingerprint that provides a signature for the\r\n11-S family of plant seed storage proteins. The fingerprint was derived \r\nfrom an initial alignment of 7 sequences: the motifs were drawn from\r\nconserved regions spanning the basic, C-terminal portion of the alignment,\r\nmotif 1 including the region encoded by PROSITE pattern 11S_SEED_STORAGE\r\n(PS00305), which contains both the cleavage site between the acidic and\r\nbasic chains, and the proximal Cys involved in interchain disulphide bond\r\nformation. Three iterations on OWL26.0 were required to reach convergence,\r\nat which point a true set comprising 90 sequences was identified. Twenty\r\npartial matches were also found, all of which are fragments and related\r\nplant storage proteins. \r\nAn update on SPTR57.15_40.15f identified a true set of 197 sequences.\r\nNumerous partial matches were also found, all of which are related plant\r\nstorage proteins and translated genomic sequences that fail to match one or\r\nmore motifs.	 6| 197  197  197  197  197  197  \r\n 5|  10   14   13   11   14    8  \r\n 4|   1    1    7    6    6    7  \r\n 3|   0    0    4    4    4    0  \r\n 2|   5    6    2   18   15    0  \r\n --+-------------------------------\r\n  |   1    2    3    4    5    6 	\N
3	MONELLINB	PR00631	COMPOUND(3)	1996-12-06	1999-06-30	Monellin B chain signature	Monellin is an intensely sweet-tasting protein derived from African berries.\r\nThe protein has a very high specificity for the sweet receptors, making it\r\n~100,000 times sweeter than sugar on a molar basis and several thousand \r\ntimes sweeter on a weight basis [1]. Like the sweet-tasting protein\r\nthaumatin, it neither contains carbohydrates nor modified amino acids [1].\r\nAlthough there is no sequence similarity between the proteins, antibodies\r\nfor thaumatin compete for monellin (and other sweet compounds, but not for \r\nchemically modified non-sweet monellin) and vice versa [1]. It is thought\r\nthat native conformations are important for the sweet taste.\r\n\r\nMonellin is a heterodimer, comprising an A chain of 44 amino acid residues, \r\nand a B chain of 50 residues [2]. The individual subunits are not sweet, \r\nnor do they block the sweet sensation of sucrose or monellin. However, \r\nblocking the single SH of monellin abolishes its sweetness, as does reaction \r\nof its methionyl residue with CNBr [2]. The cysteinyl and methionyl residues\r\nare adjacent, and it has therefore been suggested that this part of the \r\nmolecule is essential for its sweetness [3]. \r\n\r\nThe structure of monellin belongs to the alpha/beta class, a 5-stranded\r\nbeta-sheet sequestering a single alpha-helix. The B chain contributes 2\r\nstrands to the sheet and provides the helix.\r\n\r\nMONELLINB is a 3-element fingerprint that provides a signature for the\r\nmonellin B chain. The fingerprint was derived from an initial alignment\r\nof 2 sequences: the motifs span the full chain length - motif 1 encompasses\r\nthe first small strand and the N-terminal portion of the helix; motif 2\r\nspans the C-terminal part of the helix; and motif 3 spans the second strand,\r\nwhich includes the reactive cysteinyl and methionyl residues. A single\r\niteration on OWL29.0 was required to reach convergence, no further sequences\r\nbeing identified beyond the starting point.\r\n\r\nAn update on OWL31_3 identified a true set of 2 sequences.	  3|   2    2    2  \r\n  2|   0    0    0  \r\n  --+----------------\r\n   |   1    2    3	2 codes involving  3 elements\r\n0 codes involving  2 elements
\.


--
-- Name: fingerprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('fingerprint_id_seq', 3, true);


--
-- Data for Name: intermotifdistance; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY intermotifdistance (imd_id, motif_id, region, min, max) FROM stdin;
1	3	0-1	2	2
2	4	1-2	1	-1
3	5	2-3	-1	-1
\.


--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('intermotifdistance_imd_id_seq', 3, true);


--
-- Name: literature_literature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('literature_literature_id_seq', 5, true);


--
-- Data for Name: motif; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY motif (motif_id, fingerprint_id, code, length, title) FROM stdin;
1	1	11SGLOBULIN1	18	11-S seed storage protein family motif I - 1
2	1	11SGLOBULIN2	21	11-S seed storage protein family motif II - 1
3	3	MONELLINB1	15	Monellin B chain motif I - 1
4	3	MONELLINB2	15	Monellin B chain motif II
5	3	MONELLINB3	19	Monellin B chain motif III
\.


--
-- Name: motif_motif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('motif_motif_id_seq', 5, true);


--
-- Data for Name: reference; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY reference (fingerprint_id, author, title, journal, literature_id, year) FROM stdin;
1	 HAYASHI, M., MORI, H., NISHIMURA, M., AKAZAWA, T. AND HARA-NISHIMURA, I.	Nucleotide sequence of cloned cDNA coding for pumpkin 11-S globulin beta-subunit	EUR.J.BIOCHEM. 172(3) 627-632 (1988).	1	1998
1	SHOTWELL, M.A., AFONSO, C., DAVIES, E., CHESNUT, R.S. AND LARKINS, B.A.	Molecular characterisation of oat seed globulins.	PLANT PHYSIOL. 87(3) 698-704 (1988).	2	1998
3	OGATA, C., HATADA, M., TOMLINSON, G., SHIN, W.C. AND KIM, S.H.	Crystal structure of the intensely sweet protein monellin.	NATURE 328 739-42	3	1987
3	KOHMURA, M., NIO, N. AND ARIYOSHI, Y.	Complete amino acid sequence of the sweet protein monellin.	AGRIC.BIOL.CHEM. 54 2219-24	4	1990
3	BOHAK, Z. AND LI, S.L.	 The structure of monellin and its relation to the sweetness of the protein.	BIOCHIM.BIOPHYS.ACTA 427 153-70	5	1976
\.


--
-- Name: reference_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('reference_reference_id_seq', 17, true);


--
-- Data for Name: scanhistory; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY scanhistory (sh_id, database, iterations_number, hitlist_length, scanning_method, fingerprint_id) FROM stdin;
1	OWL29_0	1	100	NSINGLE	3
2	OWL31_3	2	100	NSINGLE	3
\.


--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('scanhistory_sh_id_seq', 2, true);


--
-- Data for Name: seq; Type: TABLE DATA; Schema: public; Owner: anatoliy
--

COPY seq (seq_id, motif_id, sequence, pcode, start, "interval", "position") FROM stdin;
7	1	RLNIENPSHADTYNPRAG	GLU5_ORYSA	315	315	\N
8	2	NTQNFPILSLVQMSAVKVNLY	GLU1_ORYSA	341	5	\N
9	2	NTQNFPILSLVQMSAVKVNLY	GLU2_ORYSA	341	5	\N
11	2	NSQKFPILNLIQMSATRVNLY	GLU4_ORYSA	337	5	\N
12	2	NSQKFPILNLIQMSATRVNLY	GLUB_ORYSA	337	5	\N
13	2	NSQKFPILNLIQMDATRVNLY	GLUC_ORYSA	333	5	\N
14	2	NSQKFPILNLVQLSATRVNLY	GLU5_ORYSA	338	5	\N
1	1	RQNIDNPNRADTYNPRAG	GLU1_ORYSA	318	318	\N
3	1	RQNIDNPNRADTYNPRAG	GLU3_ORYSA	318	318	final
10	2	NSQNFPILNLVQMSAVKVNLY	GLU3_ORYSA	341	5	final
5	1	RVNIENPSRADSYNPRAG	GLUB_ORYSA	314	314	initial
4	1	RVNIENPSRADSYNPRAG	GLU4_ORYSA	314	314	final
15	1	\N	\N	\N	\N	final
16	1	444	4	4	4	\N
2	1	RQNIDNPNRADTYNPRAG	GLU2_ORYSA	318	318	initial
6	1	RVNIENPSRADSYNPRAG	GLUC_ORYSA	310	310	initial
17	3	EWEIIDIGPFTQNLG	MONB_DIOCU	2	2	initial
18	4	EWEIIDIGPFTQNLG	NRL_1MOLA	2	2	initial
19	4	GKFAVDEENKIGQYG	MONB_DIOCU	16	-1	initial
20	4	GKFAVDEENKIGQYG	NRL_1MOLA	16	-1	initial
21	5	GRLTFNKVIRPCMKKTIYE	MONB_DIOCU	30	-1	initial
22	5	GRLTFNKVIRPCMKKTIYE	NRL_1MOLA	30	-1	initial
23	3	EWEIIDIGPFTQNLG	MONB_DIOCU	2	2	final
24	4	EWEIIDIGPFTQNLG	NRL_1MOLA	2	2	final
25	3	EWEIIDIGPFTQNLG	MONB_DIOCU	2	2	final
26	1	EWEIIDIGPFTQNLG	NRL_1MOLA	2	2	final
27	3	GKFAVDEENKIGQYG	MONB_DIOCU	16	-1	final
28	4	GKFAVDEENKIGQYG	NRL_1MOLA	16	-1	final
29	5	GRLTFNKVIRPCMKKTIYE	MONB_DIOCU	30	-1	final
30	5	GRLTFNKVIRPCMKKTIYE	NRL_1MOLA	30	-1	final
\.


--
-- Name: seq_seq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliy
--

SELECT pg_catalog.setval('seq_seq_id_seq', 30, true);


--
-- Name: InterMotifDistance_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY intermotifdistance
    ADD CONSTRAINT "InterMotifDistance_pkey" PRIMARY KEY (imd_id);


--
-- Name: falsepartialpositives_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY falsepartialpositives
    ADD CONSTRAINT falsepartialpositives_pkey PRIMARY KEY (id);


--
-- Name: fingerprint_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY fingerprint
    ADD CONSTRAINT fingerprint_pkey PRIMARY KEY (id);


--
-- Name: literature_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT literature_pkey PRIMARY KEY (literature_id);


--
-- Name: motif_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY motif
    ADD CONSTRAINT motif_pkey PRIMARY KEY (motif_id);


--
-- Name: reference_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY crossreference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (reference_id);


--
-- Name: scanhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY scanhistory
    ADD CONSTRAINT scanhistory_pkey PRIMARY KEY (sh_id);


--
-- Name: seq_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_pkey PRIMARY KEY (seq_id);


--
-- Name: seq_seq_id_key; Type: CONSTRAINT; Schema: public; Owner: anatoliy; Tablespace: 
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_seq_id_key UNIQUE (seq_id);


--
-- Name: falsepartialpositives_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY falsepartialpositives
    ADD CONSTRAINT falsepartialpositives_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: intermotifdistance_motif_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY intermotifdistance
    ADD CONSTRAINT intermotifdistance_motif_id_fkey FOREIGN KEY (motif_id) REFERENCES motif(motif_id);


--
-- Name: literature_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT literature_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: motif_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY motif
    ADD CONSTRAINT motif_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: reference_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY crossreference
    ADD CONSTRAINT reference_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: scanhistory_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY scanhistory
    ADD CONSTRAINT scanhistory_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: seq_motif_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliy
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_motif_id_fkey FOREIGN KEY (motif_id) REFERENCES motif(motif_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

