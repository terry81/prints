--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: prints; Type: SCHEMA; Schema: -; Owner: anatoliyd
--

CREATE SCHEMA prints;


ALTER SCHEMA prints OWNER TO anatoliyd;

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
-- Name: enum_position; Type: TYPE; Schema: public; Owner: anatoliyd
--

CREATE TYPE enum_position AS ENUM (
    'initial',
    'final'
);


ALTER TYPE public.enum_position OWNER TO anatoliyd;

--
-- Name: position; Type: TYPE; Schema: public; Owner: anatoliyd
--

CREATE TYPE "position" AS ENUM (
    'initial',
    'secondary'
);


ALTER TYPE public."position" OWNER TO anatoliyd;

--
-- Name: seq_position; Type: TYPE; Schema: public; Owner: anatoliyd
--

CREATE TYPE seq_position AS ENUM (
    'initial',
    'final'
);


ALTER TYPE public.seq_position OWNER TO anatoliyd;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: crossreference; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE crossreference (
    fingerprint_id integer,
    name character varying(15),
    accession character varying(15),
    identifier character varying(25),
    reference_id integer NOT NULL
);


ALTER TABLE public.crossreference OWNER TO anatoliyd;

--
-- Name: protein; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE protein (
    id integer NOT NULL,
    fingerprint_id integer,
    code character varying(20),
    description character varying(2000)
);


ALTER TABLE public.protein OWNER TO anatoliyd;

--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE falsepartialpositives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.falsepartialpositives_id_seq OWNER TO anatoliyd;

--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE falsepartialpositives_id_seq OWNED BY protein.id;


--
-- Name: fingerprint; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE fingerprint (
    id integer NOT NULL,
    identifier character varying(15) NOT NULL,
    accession character varying(40),
    no_motifs integer,
    creation_date date,
    update_date date,
    title character varying(100),
    annotation text,
    cfi text,
    summary text
);


ALTER TABLE public.fingerprint OWNER TO anatoliyd;

--
-- Name: fingerprint_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE fingerprint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fingerprint_id_seq OWNER TO anatoliyd;

--
-- Name: fingerprint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE fingerprint_id_seq OWNED BY fingerprint.id;


--
-- Name: intermotifdistance; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE intermotifdistance (
    imd_id integer NOT NULL,
    motif_id integer,
    region character varying(10),
    min integer,
    max character varying(10)
);


ALTER TABLE public.intermotifdistance OWNER TO anatoliyd;

--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE intermotifdistance_imd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intermotifdistance_imd_id_seq OWNER TO anatoliyd;

--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE intermotifdistance_imd_id_seq OWNED BY intermotifdistance.imd_id;


--
-- Name: reference; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE reference (
    fingerprint_id integer,
    author character varying(500) NOT NULL,
    title character varying(500),
    journal character varying(100),
    literature_id integer NOT NULL,
    year smallint,
    reference_number integer
);


ALTER TABLE public.reference OWNER TO anatoliyd;

--
-- Name: literature_literature_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE literature_literature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.literature_literature_id_seq OWNER TO anatoliyd;

--
-- Name: literature_literature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE literature_literature_id_seq OWNED BY reference.literature_id;


--
-- Name: motif; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE motif (
    motif_id integer NOT NULL,
    fingerprint_id integer,
    title character varying(100),
    code character varying(15) NOT NULL,
    length integer,
    "position" character varying(7) NOT NULL
);


ALTER TABLE public.motif OWNER TO anatoliyd;

--
-- Name: motif_motif_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE motif_motif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motif_motif_id_seq OWNER TO anatoliyd;

--
-- Name: motif_motif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE motif_motif_id_seq OWNED BY motif.motif_id;


--
-- Name: reference_reference_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE reference_reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_reference_id_seq OWNER TO anatoliyd;

--
-- Name: reference_reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE reference_reference_id_seq OWNED BY crossreference.reference_id;


--
-- Name: scanhistory; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE scanhistory (
    sh_id integer NOT NULL,
    database character varying(30),
    iterations_number integer,
    hitlist_length integer,
    scanning_method character varying(15),
    fingerprint_id integer
);


ALTER TABLE public.scanhistory OWNER TO anatoliyd;

--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE scanhistory_sh_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scanhistory_sh_id_seq OWNER TO anatoliyd;

--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE scanhistory_sh_id_seq OWNED BY scanhistory.sh_id;


--
-- Name: seq; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE seq (
    seq_id integer NOT NULL,
    motif_id integer,
    sequence character varying(30),
    pcode character varying(20),
    start integer,
    "interval" smallint
);


ALTER TABLE public.seq OWNER TO anatoliyd;

--
-- Name: seq_seq_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE seq_seq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_seq_id_seq OWNER TO anatoliyd;

--
-- Name: seq_seq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anatoliyd
--

ALTER SEQUENCE seq_seq_id_seq OWNED BY seq.seq_id;


--
-- Name: true_positives_tp_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE true_positives_tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.true_positives_tp_id_seq OWNER TO anatoliyd;

--
-- Name: truepositives_tp_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE truepositives_tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.truepositives_tp_id_seq OWNER TO anatoliyd;

--
-- Name: truepartialpositives; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE truepartialpositives (
    tpp_id integer DEFAULT nextval('truepositives_tp_id_seq'::regclass) NOT NULL,
    fingerprint_id integer,
    protein_id integer,
    numberofelements integer,
    accession_number character varying(20)
);


ALTER TABLE public.truepartialpositives OWNER TO anatoliyd;

--
-- Name: truepartialpositives_tpp_id_seq; Type: SEQUENCE; Schema: public; Owner: anatoliyd
--

CREATE SEQUENCE truepartialpositives_tpp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.truepartialpositives_tpp_id_seq OWNER TO anatoliyd;

--
-- Name: truepositives; Type: TABLE; Schema: public; Owner: anatoliyd; Tablespace: 
--

CREATE TABLE truepositives (
    tp_id integer DEFAULT nextval('truepositives_tp_id_seq'::regclass) NOT NULL,
    fingerprint_id integer,
    protein_id integer,
    accession_number character varying(20)
);


ALTER TABLE public.truepositives OWNER TO anatoliyd;

--
-- Name: reference_id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY crossreference ALTER COLUMN reference_id SET DEFAULT nextval('reference_reference_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY fingerprint ALTER COLUMN id SET DEFAULT nextval('fingerprint_id_seq'::regclass);


--
-- Name: imd_id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY intermotifdistance ALTER COLUMN imd_id SET DEFAULT nextval('intermotifdistance_imd_id_seq'::regclass);


--
-- Name: motif_id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY motif ALTER COLUMN motif_id SET DEFAULT nextval('motif_motif_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY protein ALTER COLUMN id SET DEFAULT nextval('falsepartialpositives_id_seq'::regclass);


--
-- Name: literature_id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY reference ALTER COLUMN literature_id SET DEFAULT nextval('literature_literature_id_seq'::regclass);


--
-- Name: sh_id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY scanhistory ALTER COLUMN sh_id SET DEFAULT nextval('scanhistory_sh_id_seq'::regclass);


--
-- Name: seq_id; Type: DEFAULT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY seq ALTER COLUMN seq_id SET DEFAULT nextval('seq_seq_id_seq'::regclass);


--
-- Data for Name: crossreference; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY crossreference (fingerprint_id, name, accession, identifier, reference_id) FROM stdin;
8431	PRINTS	PR00209	GLIADIN	62334
8431	PRINTS	PR00208	GLIADGLUTEN	62335
8431	PRINTS	PR00210	GLUTENIN	62336
8431	PRINTS	PR00551	2SGLOBULIN	62337
8431	INTERPRO	IPR006044	\N	62338
8431	PROSITE	PS00305	11S_SEED_STORAGE	62339
8431	PDB	2E9Q	\N	62340
8431	PDB	2EVX	\N	62341
8431	PDB	1OD5	\N	62342
8431	PDB	1UD1	\N	62343
8431	PDB	1UCX	\N	62344
8431	SCOP	1OD5	\N	62345
8431	SCOP	1UD1	\N	62346
8431	SCOP	1UCX	\N	62347
8431	CATH	2E9Q	\N	62348
8431	CATH	2EVX	\N	62349
8431	CATH	1OD5	\N	62350
8431	CATH	1UD1	\N	62351
8431	CATH	1UCX	\N	62352
8432	INTERPRO	IPR000308	\N	62353
8432	PROSITE	PS00796	1433_1	62354
8432	PROSITE	PS00797	1433_2	62355
8432	PFAM	PF00244	14-3-3	62356
8433	PRINTS	PR00705	PAPAIN	62357
8433	PRINTS	PR00704	CALPAIN	62358
8433	PRINTS	PR00966	NIAPOTYPTASE	62359
8433	PRINTS	PR00703	ADVENDOPTASE	62360
8433	PRINTS	PR00797	STREPTOPAIN	62361
8433	PRINTS	PR00707	UBCTHYDRLASE	62362
8433	PRINTS	PR00776	HEMOGLOBNASE	62363
8433	PRINTS	PR00706	PYROGLUPTASE	62364
8433	PRINTS	PR00864	PREPILPTASE	62365
8433	PRINTS	PR00917	SRSVCYSPTASE	62366
8433	INTERPRO	IPR000317	\N	62367
8434	PRINTS	PR00352	3FE4SFRDOXIN	62368
8434	PRINTS	PR00353	4FE4SFRDOXIN	62369
8434	PRINTS	PR00354	7FE8SFRDOXIN	62370
8434	PRINTS	PR00355	ADRENODOXIN	62371
8434	PRINTS	PR00374	HIPIPFRDOXIN	62372
8434	PRINTS	PR00397	SIROHAEM	62373
8434	INTERPRO	IPR000564	\N	62374
8434	PROSITE	PS00197	2FE2S_FERREDOXIN	62375
8434	PFAM	PF00111	fer2	62376
8434	PDB	1FXA	\N	62377
8434	PDB	2PIA	\N	62378
8434	SCOP	1FXA	\N	62379
8434	SCOP	2PIA	\N	62380
8434	CATH	1FXA	\N	62381
8434	CATH	2PIA	\N	62382
\.


--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('falsepartialpositives_id_seq', 462071, true);


--
-- Data for Name: fingerprint; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY fingerprint (id, identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary) FROM stdin;
8431	11SGLOBULIN	PR00439	6	1995-11-16	2010-03-05	11-S seed storage protein family signature	Plant seed storage proteins that provide the major nitrogen source for\ndeveloping plants may be classified into a number of different families.\nThe 11-S family are non-glycosylated proteins that form hexameric\nstructures [1,2]. Each of the constituent subunits comprises an acidic and\na basic chain derived from a single precursor and linked by a disulphide\nbond. Members of the 11-S family include pea and broad bean legumins; rape\ncruciferin; rice glutelins; cotton beta-globulins; soybean glycinins;\npumpkin 11-S globulin; oat globulin; and so on.\n\n11SGLOBULIN is a 6-element fingerprint that provides a signature for the\n11-S family of plant seed storage proteins. The fingerprint was derived \nfrom an initial alignment of 7 sequences: the motifs were drawn from\nconserved regions spanning the basic, C-terminal portion of the alignment,\nmotif 1 including the region encoded by PROSITE pattern 11S_SEED_STORAGE\n(PS00305), which contains both the cleavage site between the acidic and\nbasic chains, and the proximal Cys involved in interchain disulphide bond\nformation. Three iterations on OWL26.0 were required to reach convergence,\nat which point a true set comprising 90 sequences was identified. Twenty\npartial matches were also found, all of which are fragments and related\nplant storage proteins. \n\nAn update on SPTR57.15_40.15f identified a true set of 197 sequences.\nNumerous partial matches were also found, all of which are related plant\nstorage proteins and translated genomic sequences that fail to match one or\nmore motifs.	6| 197  197  197  197  197  197  \n5|  10   14   13   11   14    8  \n4|   1    1    7    6    6    7  \n3|   0    0    4    4    4    0  \n2|   5    6    2   18   15    0  \n--+-------------------------------\n|   1    2    3    4    5    6  	197 codes involving  6 elements\n14 codes involving  5 elements\n7 codes involving  4 elements\n4 codes involving  3 elements\n23 codes involving  2 elements
8432	1433ZETA	PR00305	6	1994-10-07	1999-06-06	14-3-3 protein zeta signature	The 14-3-3 proteins are a family of related proteins found in mammalian\nbrain cells, preferentially in neurons, although similar proteins have been\nidentified in all eukaryotic species studied to date. They are homodimeric,\nacidic proteins [1] with multiple biological activities: they act as\nprotein kinase-dependent activators of tyrosine and tryptophan hydroxy-\nlases, key enzymes in the biosynthetic pathway of neurotransmitters such\nas dopamine and serotonin; some act as inhibitors of protein kinase C; and \nsome display phospholipase A2 activity on choline and ethanolamine glycero-\nphospholipids [1-3]. In yeast, a 14-3-3-like protein is involved in growth\nregulation. Although the proteins have different biological functions, their\nsequences are well conserved.\n\n1433ZETA is a 6-element fingerprint that provides a signature for 14-3-3\nzeta proteins. The fingerprint was derived from an initial alignment of 7\nsequences: the motifs were drawn from conserved regions spanning virtually\nthe full alignment length, motifs 1 and 6 including the perfectly conserved\nregions encoded by PROSITE patterns 1433_1 (PS00796) and 1433_2 (PS00797).\nTwo iterations on OWL24.0 were required to reach convergence, at which\npoint a true set comprising 37 sequences was identified. Eight partial\nmatches were also found, all of which are 14-3-3 protein fragments. \n\nAn update on SPTR37_9f identified a true set of 92 sequences, and 2\npartial matches.	6|  92   92   92   92   92   92  \n5|   1    0    1    1    1    1  \n4|   0    0    0    0    0    0  \n3|   0    0    0    0    0    0  \n2|   0    0    0    1    1    0  \n--+-------------------------------\n|   1    2    3    4    5    6  	92 codes involving  6 elements\n1 codes involving  5 elements\n0 codes involving  4 elements\n0 codes involving  3 elements\n1 codes involving  2 elements
8433	2CENDOPTASE	PR00916	4	1998-06-29	1999-06-06	2C endopeptidase (C24) cysteine protease family signature	Cysteine protease activity is dependent on an active dyad of cysteine and\nhistidine, the order and spacing of these residues varing in the known \nfamilies. Nearly half of all cysteine proteases are found exclusively\nin viruses [1]. Cysteine protease families have been grouped into five \nclans (designated CA, CB, CC, CD and CE) on the basis of structural and\nfunctional similarity. Families C1, C2 and C10, which belong to the CA clan,\nhave a Cys/His catalytic diad, and are loosely termed papain-like. Families\nin the CB clan have a His/Cys diad, and contain enzymes from RNA viruses\ndistantly related to chymotrypsin. Enzymes in clan CC are also from RNA\nviruses, but have a papain-like Cys/His active site. The remaining two\nclans, CD and CE, contain only one family each [2]. Some families have not\nyet been asigned to a clan. \n\nTwo additional clans (PA and PB) have been identified, these containing a\nmixture of serine, cysteine and threonine proteases. Clan PA contains a\ncatalytically-active serine or cysteine nucleophilic residue as part of the\nordered triad His, Asp, Ser (or Cys). Clan PB contains a serine, cysteine or\nthreonine active residue at the N-terminus of the mature protease [3]. \n\nCaliciviruses are positive-stranded ssRNA viruses that cause gastroenteritis\n[4]. The calicivirus genome contains two open reading frames, ORF1 and ORF2.\nORF1 encodes a non-structural polypeptide, which has RNA helicase, cysteine\nprotease and RNA polymerase activity. The regions of the polyprotein in \nwhich these activities lie are similar to proteins produced by the picorna-\nviruses. ORF2 encodes a structural protein [5]. Two different families of\ncaliciviruses can be distinguished on the basis of sequence similarity, \nnamely those classified as small round structured viruses (SRSVs) and those\nclassed as non-SRSVs. \n\nCalicivirus proteases from the non-SRSV group, which are members of the PA\nprotease clan, constitute family C24 of the cysteine proteases (proteases \nfrom SRSVs belong to the C37 family). As mentioned above, the protease \nactivity resides within a polyprotein. The enzyme cleaves the polyprotein\nat sites N-terminal to itself, liberating the polyprotein helicase.\n\n2CENDOPTASE is a 4-element fingerprint that provides a signature for the \ncysteine protease (C24) of non-SRSV caliciviruses. The fingerprint was \nderived from an initial alignment of 4 sequences: the motifs were drawn \nfrom conserved regions spanning the full length of the polyprotein protease,\nfocusing on those regions that characterise members of the C24 family but\ndistinguish them from the C37 proteases - motif 1 includes the active site\nhistidine residue; and motif 3 contains the catalytic cysteine. Two \niterations on OWL30.2 were required to reach convergence, at which point\na true set comprising 14 sequences was identified. \n\nAn update on SPTR37_9f identified a true set of 12 sequences.	4|  12   12   12   12  \n3|   0    0    0    0  \n2|   0    0    0    0  \n--+---------------------\n|   1    2    3    4  	12 codes involving  4 elements\n0 codes involving  3 elements\n0 codes involving  2 elements
8434	2FE2SFRDOXIN	PR00159	2	1995-04-28	1999-06-06	2Fe-2S ferredoxin signature	Ferredoxins [1,2] are iron-sulphur proteins that mediate electron transfer\nin a range of metabolic reactions; they fall into several subgroups\naccording to the nature of their iron-sulphur cluster(s). One group,\noriginally found in chloroplast membranes, has been termed "chloroplast-\ntype" or "plant-type". Here, the active centre is a 2Fe-2S cluster, where\nthe irons are tetrahedrally coordinated by both inorganic sulphurs and\nsulphurs provided by 4 conserved Cys residues [3], as shown in the\nfollowing scheme:\n\n|   Cys308 |\n\\_____x___/  /\n|     /\nHS     |\n:  H  |\n\\      S''Fe..S--x Cys280  \n|      :   :     |\nCys272 x--S...Fe..S     |   \n|  H   :         |\n|      SH        |\n|      |         /\n\\______x________/\nCys277\n\nIn chloroplasts, 2Fe-2S ferredoxins function as electron carriers in the\nphotosynthetic electron transport chain and as electron donors to various\ncellular proteins, such as nitrate reductase, sulphite reductase and\nglutamate synthase [4]. In hydroxylating bacterial dioxygenase systems,\nthey serve as intermediate electron-transfer carriers between reductase\nflavoproteins and oxygenase [2].\n\nSeveral oxidoreductases contain redox domains similar to 2Fe-2S\nferredoxins, including ferredoxin/ferredoxin reductase components of\nseveral bacterial aromatic di- and monooxygenases, phenol hydroxylase,\nmethane monooxygenase, vanillate demethylase oxidoreductase, phthalate\ndioxygenase reductase, bacterial fumarate reductase iron-sulphur protein,\neukaryotic succinate dehydrogenase and xanthine dehydrogenase. \n\n3D structures are known for a number of 2Fe-2S ferredoxins [3] and for\nthe ferredoxin reductase/ferredoxin fusion protein phthalate dioxygenase\nreductase [5]. The fold belongs to the alpha + beta class, with 3 helices\nand 4 strands forming a barrel-like structure, and an extruded loop\ncontaining 3 of the 4 cysteinyl residues of the iron-sulphur cluster.\n\n2FE2SFRDOXIN is a 2-element fingerprint that provides a signature for the \nplant ferredoxins. The fingerprint was derived from an initial alignment \nof 25 sequences: the motifs span the region encoded by PROSITE pattern\n2FE2S_FERREDOXIN (PS00197), which contains 3 of the 4 Cys residues of the\ncluster. Two iterations on OWL25.2 were required to reach convergence, at\nwhich point a true set comprising 126 sequences was identified. \n\nAn update on SPTR37_9f identified a true set of 86 sequences.	2|  86   86  \n--+-----------\n|   1    2  	86 codes involving  2 elements
\.


--
-- Name: fingerprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('fingerprint_id_seq', 8434, true);


--
-- Data for Name: intermotifdistance; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY intermotifdistance (imd_id, motif_id, region, min, max) FROM stdin;
42621	85219	0-1	4	618
42622	85220	1-2	5	7
42623	85221	2-3	24	26
42624	85222	3-4	1	1
42625	85223	4-5	1	3
42626	85224	5-6	0	3
42627	85231	0-1	35	48
42628	85232	1-2	16	20
42629	85233	2-3	5	8
42630	85234	3-4	11	13
42631	85235	4-5	0	2
42632	85236	5-6	0	1
42633	85241	0-1	997	1208
42634	85242	1-2	24	32
42635	85243	2-3	25	36
42636	85244	3-4	0	0
42637	85247	0-1	34	95
42638	85248	1-2	-1	-1
\.


--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('intermotifdistance_imd_id_seq', 42638, true);


--
-- Name: literature_literature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('literature_literature_id_seq', 25660, true);


--
-- Data for Name: motif; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY motif (motif_id, fingerprint_id, title, code, length, "position") FROM stdin;
85213	8431	11-S seed storage protein family motif I - 1	11SGLOBULIN1	18	initial
85214	8431	11-S seed storage protein family motif II - 1	11SGLOBULIN2	21	initial
85215	8431	11-S seed storage protein family motif III - 1	11SGLOBULIN3	17	initial
85216	8431	11-S seed storage protein family motif IV - 1	11SGLOBULIN4	16	initial
85217	8431	11-S seed storage protein family motif V - 1	11SGLOBULIN5	19	initial
85218	8431	11-S seed storage protein family motif VI - 1	11SGLOBULIN6	18	initial
85219	8431	11-S seed storage protein family motif I - 7	11SGLOBULIN1	18	final
85220	8431	11-S seed storage protein family motif II - 7	11SGLOBULIN2	21	final
85221	8431	11-S seed storage protein family motif III - 7	11SGLOBULIN3	17	final
85222	8431	11-S seed storage protein family motif IV - 7	11SGLOBULIN4	16	final
85223	8431	11-S seed storage protein family motif V - 7	11SGLOBULIN5	19	final
85224	8431	11-S seed storage protein family motif VI - 7	11SGLOBULIN6	18	final
85225	8432	1433 protein motif I - 1	1433ZETA1	30	initial
85226	8432	1433 protein motif II - 1	1433ZETA2	25	initial
85227	8432	1433 protein motif III - 1	1433ZETA3	23	initial
85228	8432	1433 protein motif IV - 1	1433ZETA4	27	initial
85229	8432	1433 protein motif V - 1	1433ZETA5	27	initial
85230	8432	1433 protein motif VI - 1	1433ZETA6	30	initial
85231	8432	1433 protein motif I - 2	1433ZETA1	30	final
85232	8432	1433 protein motif II - 2	1433ZETA2	25	final
85233	8432	1433 protein motif III - 2	1433ZETA3	23	final
85234	8432	1433 protein motif IV - 2	1433ZETA4	27	final
85235	8432	1433 protein motif V - 2	1433ZETA5	27	final
85236	8432	1433 protein motif VI - 2	1433ZETA6	30	final
85237	8433	2C endopeptidase calicivirus protease motif I - 1	2CENDOPTASE1	18	initial
85238	8433	2C endopeptidase calicivirus protease motif II - 1	2CENDOPTASE2	17	initial
85239	8433	2C endopeptidase calicivirus protease motif III - 1	2CENDOPTASE3	12	initial
85240	8433	2C endopeptidase calicivirus protease motif IV - 1	2CENDOPTASE4	11	initial
85241	8433	2C endopeptidase calicivirus protease motif I - 2	2CENDOPTASE1	18	final
85242	8433	2C endopeptidase calicivirus protease motif II - 2	2CENDOPTASE2	17	final
85243	8433	2C endopeptidase calicivirus protease motif III - 2	2CENDOPTASE3	12	final
85244	8433	2C endopeptidase calicivirus protease motif IV - 2	2CENDOPTASE4	11	final
85245	8434	2Fe2S ferredoxin motif I - 1	2FE2SFRDOXIN1	9	initial
85246	8434	2Fe2S ferredoxin motif II - 1	2FE2SFRDOXIN2	8	initial
85247	8434	2Fe2S ferredoxin motif I - 2	2FE2SFRDOXIN1	9	final
85248	8434	2Fe2S ferredoxin motif II - 2	2FE2SFRDOXIN2	8	final
\.


--
-- Name: motif_motif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('motif_motif_id_seq', 85248, true);


--
-- Data for Name: protein; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY protein (id, fingerprint_id, code, description) FROM stdin;
461635	8431	B5U8K2_LOTJA	Legumin storage protein 3 - Lotus japonicus 
461636	8431	B7SLJ1_PISVE	Pis v 5.0101 allergen 11S globulin precusor - Pistacia vera 
461637	8431	C0L8H2_ORYSJ	GluB-5 short variant - Oryza sativa subsp. japonica 
461638	8431	Q0Z945_9ORYZ	Glutelin - Zizania latifolia 
461639	8431	Q41128_QUERO	Legumin - Quercus robur 
461640	8431	A3A5D6_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461641	8431	B9GS11_POPTR	Predicted protein - Populus trichocarpa 
461642	8431	13S1_FAGES	13S globulin seed storage protein 1 - Fagopyrum esculentum 
461643	8431	Q6Q384_CHEQI	11S seed storage globulin - Chenopodium quinoa 
461644	8431	Q39770_GINBI	Legumin; 11S-globulin - Ginkgo biloba 
461645	8431	B9S9Q7_RICCO	11S globulin subunit beta, putative - Ricinus communis 
461646	8431	B9SF37_RICCO	Legumin A, putative - Ricinus communis 
461647	8431	Q56WH8_ARATH	Putative cruciferin 12S seed storage protein - Arabidopsis thaliana 
461648	8431	Q39722_EPHGE	Legumin; 11S globulin - Ephedra gerardiana 
461649	8431	C0ILQ2_COFCA	Protein - Coffea canephora 
461650	8431	SSG1_AVESA	12S seed storage globulin 1 - Avena sativa 
461651	8431	A1DZF0_ARAHY	Arachin 6 - Arachis hypogaea 
461652	8431	A2WZN8_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461653	8431	Q948J8_MAIZE	Uncleaved legumin-1 - Zea mays 
461654	8431	B8AEZ0_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461655	8431	Q38697_ASAEU	Legumin-like protein - Asarum europaeum 
461656	8431	A2XZQ4_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461657	8431	O04691_METGY	Legumin - Metasequoia glyptostroboides 
461658	8431	Q41676_VICNA	Legumin A - Vicia narbonensis 
461659	8431	P93559_SAGSA	Pre-pro-legumin - Sagittaria sagittifolia 
461660	8431	Q41017_PINST	Pine globulin-1 - Pinus strobus 
461661	8431	Q56YY3_ARATH	12S cruciferin seed storage protein - Arabidopsis thaliana 
461662	8431	A1E0V6_FICAW	11S globulin isoform 2B - Ficus awkeotsang 
461663	8431	B9F952_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461664	8431	B5KVH5_CARIL	11S legumin protein - Carya illinoinensis 
461665	8431	C5YYX1_SORBI	Putative uncharacterized protein Sb09g001680 - Sorghum bicolor 
461666	8431	B9F4T1_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461667	8431	LEGA2_PEA	Legumin A2 - Pisum sativum 
461668	8431	A1E0V4_FICAW	11S globulin isoform 1A - Ficus awkeotsang 
461669	8431	Q84ND2_BEREX	11S globulin - Bertholletia excelsa 
461670	8431	11S2_SESIN	11S globulin seed storage protein 2 - Sesamum indicum 
461671	8431	Q40689_ORYSA	Glutelin - Oryza sativa 
461672	8431	B9T5E6_RICCO	Legumin B, putative - Ricinus communis 
461673	8431	Q3HW60_SOYBN	Glycinin subunit G7 - Glycine max 
461674	8431	B6SLE7_MAIZE	Legumin-like protein - Zea mays 
461675	8431	A2WVB9_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461676	8431	Q8LKN1_ARAHY	Allergen Arah3/Arah4 - Arachis hypogaea 
461677	8431	A9NJG2_FAGTA	Allergenic protein - Fagopyrum tataricum 
461678	8431	A3KEY8_GLYSO	Glycinin A3B4 subunit - Glycine soja 
461679	8431	Q39694_9LILI	Legumin-like protein - Dioscorea caucasica 
461680	8431	B9SF35_RICCO	Legumin A, putative - Ricinus communis 
461681	8431	B9P6C0_POPTR	Predicted protein - Populus trichocarpa 
461682	8431	B9T1B8_RICCO	Legumin A, putative - Ricinus communis 
461683	8431	Q2TLV9_SINAL	11S globulin - Sinapis alba 
461684	8431	B9H8M5_POPTR	Predicted protein - Populus trichocarpa 
461685	8431	Q9T0P5_PEA	LegA class - Pisum sativum 
461686	8431	B9EZT3_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461687	8431	C6TGN6_SOYBN	Putative uncharacterized protein - Glycine max 
461688	8431	11SB_CUCMA	11S globulin subunit beta - Cucurbita maxima 
461689	8431	Q40870_PICGL	Legumin-like storage protein - Picea glauca 
461690	8431	A2X399_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461691	8431	Q8RX74_ARATH	AT4g28520/F20O9_210 - Arabidopsis thaliana 
461692	8431	Q9SNZ2_ELAGV	Glutelin - Elaeis guineensis var. tenera 
461693	8431	GLUB5_ORYSJ	Glutelin type-B 5 - Oryza sativa subsp. japonica 
461694	8431	CRU1_RAPSA	Cruciferin PGCRURSE5 - Raphanus sativus 
461695	8431	Q9FZ11_ARAHY	Gly1 - Arachis hypogaea 
461696	8431	B9FM56_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461697	8431	Q6K7K6_ORYSJ	Os02g0453600 protein - Oryza sativa subsp. japonica 
461698	8431	A1E0V8_FICAW	11S globulin isoform 3B - Ficus awkeotsang 
461699	8431	B7P073_PISVE	Pis v 2.0101 allergen11S globulin precusor - Pistacia vera 
461700	8431	P93707_SOYBN	Glycinin - Glycine max 
461701	8431	Q9SB11_SOYBN	Glycinin - Glycine max 
461702	8431	Q6DR94_SOYBN	Glycinin subunit G7 - Glycine max 
461703	8431	A2XZP5_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461704	8431	CRU2_BRANA	Cruciferin BnC2 - Brassica napus 
461705	8431	Q6ZK46_ORYSJ	Os08g0127900 protein - Oryza sativa subsp. japonica 
461706	8431	Q2XSW7_SESIN	11S globulin isoform 3 - Sesamum indicum 
461707	8431	A9P9T4_POPTR	Predicted protein - Populus trichocarpa 
461708	8431	Q9FEC5_SOYBN	Glycinin subunit G7 - Glycine max 
461709	8431	C7EA91_SOYBN	Mutant glycinin subunit A1aB1b - Glycine max 
461710	8431	Q10JA8_ORYSJ	Os03g0427300 protein - Oryza sativa subsp. japonica 
461711	8431	Q9SE84_PERFR	Legumin-like protein - Perilla frutescens 
461712	8431	Q39922_GLYSO	Gy5 protein - Glycine soja 
461713	8431	A2X3A0_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461714	8431	Q946V2_MAIZE	Putative uncharacterized protein - Zea mays 
461715	8431	B9EZT7_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461716	8431	A1E0V5_FICAW	11S globulin isoform 1B - Ficus awkeotsang 
461717	8431	C9WC98_LUPAN	Seed storage protein - Lupinus angustifolius 
461718	8431	LEGB4_VICFA	Legumin type B - Vicia faba 
461719	8431	B2CGM5_WHEAT	Triticin - Triticum aestivum 
461720	8431	B9PAX0_POPTR	Predicted protein - Populus trichocarpa 
461721	8431	Q0JJ36_ORYSJ	Os01g0762500 protein - Oryza sativa subsp. japonica 
461722	8431	O24294_PEA	Legumin (Minor small) - Pisum sativum 
461723	8431	B9H8M2_POPTR	Predicted protein - Populus trichocarpa 
461724	8431	B6TFX9_MAIZE	Legumin-like protein - Zea mays 
461725	8431	LEGJ_PEA	Legumin J - Pisum sativum 
461726	8431	CRU1_BRANA	Cruciferin BnC1 - Brassica napus 
461727	8431	Q8LA49_ARATH	Globulin-like protein - Arabidopsis thaliana 
461728	8431	Q84MJ4_FAGES	13S globulin - Fagopyrum esculentum 
461729	8431	Q1WAB8_9FABA	Glycinin - Glycine microphylla 
461730	8431	Q39775_GNEGN	Legumin; 11S globulin - Gnetum gnemon 
461731	8431	Q2TPW5_9ROSI	Seed storage protein - Juglans regia 
461732	8431	B9SW14_RICCO	Putative uncharacterized protein - Ricinus communis 
461733	8431	Q549Z4_SOYBN	Proglycinin A2B1 - Glycine max 
461734	8431	CRU3_BRANA	Cruciferin CRU1 - Brassica napus 
461735	8431	Q6K508_ORYSJ	Os02g0249000 protein - Oryza sativa subsp. japonica 
461736	8431	A1YQH6_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461737	8431	B9SDX6_RICCO	Legumin B, putative - Ricinus communis 
461738	8431	B9SKF4_RICCO	Nutrient reservoir, putative - Ricinus communis 
461739	8431	Q9SQH7_ARAHY	Glycinin - Arachis hypogaea 
461740	8431	B9SF36_RICCO	Legumin A, putative - Ricinus communis 
461741	8431	Q6Q385_CHEQI	11S seed storage globulin - Chenopodium quinoa 
461742	8431	Q40933_PSEMZ	Legumin-like storage protein - Pseudotsuga menziesii 
461743	8431	A5B7S5_VITVI	Putative uncharacterized protein - Vitis vinifera 
461744	8431	Q41018_PINST	Pine globulin-2 - Pinus strobus 
461745	8431	13S2_FAGES	13S globulin seed storage protein 2 - Fagopyrum esculentum 
461746	8431	Q43452_SOYBN	Glycinin - Glycine max 
461747	8431	GLUA2_ORYSJ	Glutelin type-A 2 - Oryza sativa subsp. japonica 
461748	8431	C7EA92_SOYBN	Mutant glycinin subunit A1aB1b - Glycine max 
461749	8431	Q6T726_ORYSJ	Glutelin C - Oryza sativa subsp. japonica 
461750	8431	Q40348_MAGSL	Legumin - Magnolia salicifolia 
461751	8431	Q43671_VICFA	Storage protein - Vicia faba var. minor 
461752	8431	Q40347_MAGSL	Globulin - Magnolia salicifolia 
461753	8431	LEGA_PEA	Legumin A - Pisum sativum 
461754	8431	A1YQH5_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461755	8431	A0EM47_ACTCH	11S globulin-like protein - Actinidia chinensis 
461756	8431	B9SW16_RICCO	11S globulin subunit beta, putative - Ricinus communis 
461757	8431	Q647H3_ARAHY	Arachin Ahy-2 - Arachis hypogaea 
461758	8431	Q53I54_LUPAL	Legumin-like protein - Lupinus albus 
461759	8431	A2X2Z8_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461760	8431	Q6T2T4_ARAHY	Storage protein - Arachis hypogaea 
461761	8431	B7P074_PISVE	Pis v 2.0201 allergen 11S globulin precusor - Pistacia vera 
461762	8431	A3KEY9_GLYSO	Glycinin A5A4B3 subunit - Glycine soja 
461763	8431	Q84X93_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461764	8431	P93079_COFAR	11S storage globulin - Coffea arabica 
461765	8431	A2X2V1_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461766	8431	13SB_FAGES	13S globulin basic chain - Fagopyrum esculentum 
461767	8431	Q8LK20_CASCR	Castanin - Castanea crenata 
461768	8431	Q2TLW0_SINAL	11S globulin - Sinapis alba 
461769	8431	A3A224_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461770	8431	B5TYU1_ARAHY	Arachin Arah3 isoform - Arachis hypogaea 
461771	8431	12S2_ARATH	12S seed storage protein CRB - Arabidopsis thaliana 
461772	8431	C5YY38_SORBI	Putative uncharacterized protein Sb09g000830 - Sorghum bicolor 
461773	8431	GLUB2_ORYSJ	Glutelin type-B 2 - Oryza sativa subsp. japonica 
461774	8431	11S3_HELAN	11S globulin seed storage protein G3 - Helianthus annuus 
461775	8431	Q41714_WELMI	Legumin; 11S globulin - Welwitschia mirabilis 
461776	8431	Q84TL7_MAIZE	Legumin-like protein - Zea mays 
461777	8431	Q0Z870_9ORYZ	Glutelin - Zizania latifolia 
461778	8431	Q96318_ARATH	12S cruciferin seed storage protein - Arabidopsis thaliana 
461779	8431	LEGA_GOSHI	Legumin A - Gossypium hirsutum 
461780	8431	A2X301_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461781	8431	P93560_SAGSA	Pre-pro-legumin - Sagittaria sagittifolia 
461782	8431	B2CGM6_WHEAT	Triticin - Triticum aestivum 
461783	8431	Q647H1_ARAHY	Conarachin - Arachis hypogaea 
461784	8431	Q84X94_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461785	8431	C0KG62_SOYBN	Mutant glycinin A3B4 - Glycine max 
461786	8431	Q41702_VICSA	Legumin A - Vicia sativa 
461787	8431	Q647H4_ARAHY	Arachin Ahy-1 - Arachis hypogaea 
461788	8431	B9N2L3_POPTR	Predicted protein - Populus trichocarpa 
461789	8431	Q39521_CRYJA	Legumin - Cryptomeria japonica 
461790	8431	Q0GM57_ARAHY	Iso-Ara h3 - Arachis hypogaea 
461791	8431	Q0E2D2_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461792	8431	GLYG5_SOYBN	Glycinin - Glycine max 
461793	8431	B9N2L2_POPTR	Predicted protein - Populus trichocarpa 
461794	8431	B8AH68_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461795	8431	B8AH66_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461796	8431	LEG_CICAR	Legumin - Cicer arietinum 
461797	8431	Q43607_PRUDU	Prunin - Prunus dulcis 
461798	8431	Q7GC77_SOYBN	Glycinin A3B4 subunit - Glycine max 
461799	8431	C5WQC0_SORBI	Putative uncharacterized protein Sb01g012530 - Sorghum bicolor 
461800	8431	A8MRV6_ARATH	Uncharacterized protein At4g28520.4 - Arabidopsis thaliana 
461801	8431	Q9SB12_SOYBN	Glycinin - Glycine max 
461802	8431	Q39772_GINBI	Ginnacin - Ginkgo biloba 
461803	8431	A1E0V3_FICAW	11S globulin isoform 2A - Ficus awkeotsang 
461886	8432	1433_FUCVE	14-3-3-LIKE PROTEIN - FUCUS VESICULOSUS.
461804	8431	Q6T725_ORYSJ	Os02g0248800 protein - Oryza sativa subsp. japonica 
461805	8431	Q84TL6_MAIZE	Legumin-like protein - Zea mays 
461806	8431	B9F4T2_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461807	8431	Q39627_CITSI	Citrin - Citrus sinensis 
461808	8431	Q9M4R4_ELAGV	Glutelin - Elaeis guineensis var. tenera 
461809	8431	Q43673_VICFA	Legumin; legumin-related high molecular weight polypeptide - Vicia faba var. minor 
461810	8431	A2YQV0_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461811	8431	LEGB_GOSHI	Legumin B - Gossypium hirsutum 
461812	8431	Q9ZWA9_ARATH	F21M11.18 protein - Arabidopsis thaliana 
461813	8431	GLUA3_ORYSJ	Glutelin type-A 3 - Oryza sativa subsp. japonica 
461814	8431	GLYG2_SOYBN	Glycinin G2 - Glycine max 
461815	8431	Q38780_AVESA	11S globulin - Avena sativa 
461816	8431	Q8W1C2_CORAV	11S globulin-like protein - Corylus avellana 
461817	8431	Q94CS6_ORYSJ	Os01g0976200 protein - Oryza sativa subsp. japonica 
461818	8431	A1YQG5_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461819	8431	Q38698_ASAEU	Legumin-like protein - Asarum europaeum 
461820	8431	P93708_SOYBN	Glycinin - Glycine max 
461821	8431	Q99304_VICFA	Legumin A2 primary translation product - Vicia faba var. minor 
461822	8431	CRU4_BRANA	Cruciferin CRU4 - Brassica napus 
461823	8431	A3A527_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461824	8431	GLYG4_SOYBN	Glycinin G4 - Glycine max 
461825	8431	GLYG1_SOYBN	Glycinin G1 - Glycine max 
461826	8431	B6TDD3_MAIZE	Legumin-like protein - Zea mays 
461827	8431	Q0E2D5_ORYSJ	Os02g0249600 protein - Oryza sativa subsp. japonica 
461828	8431	Q9AXL9_BRANA	Cruciferin subunit - Brassica napus 
461829	8431	Q6ESW6_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461830	8431	B5U8K1_LOTJA	Legumin storage protein 2 - Lotus japonicus 
461831	8431	O82437_COFAR	11S storage globulin - Coffea arabica 
461832	8431	O49257_AVESA	12s globulin - Avena sativa 
461833	8431	B9N2L4_POPTR	Predicted protein - Populus trichocarpa 
461834	8431	A1YQH4_ORYSJ	Glutelin - Oryza sativa subsp. japonica 
461835	8431	Q0E261_ORYSJ	Os02g0268300 protein - Oryza sativa subsp. japonica 
461836	8431	B5KVH4_CARIL	11S legumin protein - Carya illinoinensis 
461837	8431	SSG2_AVESA	12S seed storage globulin 2 - Avena sativa 
461838	8431	A2X2Z1_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461839	8431	Q65XA1_ORYSJ	Os05g0116000 protein - Oryza sativa subsp. japonica 
461840	8431	B2KN55_PISVE	11S globulin - Pistacia vera 
461841	8431	Q0E262_ORYSJ	Os02g0268100 protein - Oryza sativa subsp. japonica 
461842	8431	Q852U4_SOYBN	Glycinin A1bB2-784 - Glycine max 
461843	8431	12S1_ARATH	12S seed storage protein CRA1 - Arabidopsis thaliana 
461844	8431	AHY3_ARAHY	Arachin Ahy-3 - Arachis hypogaea 
461845	8431	A2I9A6_AMAHP	11S globulin - Amaranthus hypochondriacus 
461846	8431	B8AKE2_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461847	8431	B6THG1_MAIZE	Legumin-like protein - Zea mays 
461848	8431	Q9M4Q8_RICCO	Legumin B, putative - Ricinus communis 
461849	8431	A1YQG3_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461850	8431	GLUB4_ORYSJ	Glutelin type-B 4 - Oryza sativa subsp. japonica 
461851	8431	B9SYN6_RICCO	Nutrient reservoir, putative - Ricinus communis 
461852	8431	Q5I6T2_ARAHY	Arachin Ahy-4 - Arachis hypogaea 
461853	8431	GLUA1_ORYSJ	Glutelin type-A 1 - Oryza sativa subsp. japonica 
461854	8431	C0L8H1_ORYSJ	GluB-5 long variant - Oryza sativa subsp. japonica 
461855	8431	A5ARE0_VITVI	Putative uncharacterized protein - Vitis vinifera 
461856	8431	CRUA_BRANA	Cruciferin - Brassica napus 
461857	8431	Q9ZWJ8_ORYSA	Glutelin - Oryza sativa 
461858	8431	Q06AW2_CHEQI	11S seed storage globulin A - Chenopodium quinoa 
461859	8431	A1E0V7_FICAW	11S globulin isoform 3A - Ficus awkeotsang 
461860	8431	GLUB1_ORYSJ	Glutelin type-B 1 - Oryza sativa subsp. japonica 
461861	8431	B8AEZ5_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461862	8431	Q06AW1_CHEQI	11S seed storage globulin B - Chenopodium quinoa 
461863	8431	Q39921_GLYSO	A5A4B3 subunit - Glycine soja 
461864	8431	Q41703_VICSA	Legumin B - Vicia sativa 
461865	8431	O04689_METGY	Legumin - Metasequoia glyptostroboides 
461866	8431	Q9AUD2_SESIN	11S globulin - Sesamum indicum 
461867	8431	Q2XSW6_SESIN	11S globulin isoform 4 - Sesamum indicum 
461868	8431	B9F4T3_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461869	8431	A3BP99_ORYSJ	Putative uncharacterized protein - Oryza sativa subsp. japonica 
461870	8431	O49258_AVESA	12s globulin - Avena sativa 
461871	8431	Q38779_AVESA	11S globulin - Avena sativa 
461872	8431	Q9S9D0_SOYBN	Glycinin G4 subunit - Glycine max 
461873	8431	B5U8K6_LOTJA	Legumin storage protein 5 - Lotus japonicus 
461874	8431	Q9ZNY2_COFAR	11S storage protein - Coffea arabica 
461875	8431	Q852U5_SOYBN	Glycinin A1bB2-445 - Glycine max 
461876	8431	B9T5E7_RICCO	Glutelin type-A 3, putative - Ricinus communis 
461877	8431	GLYG3_SOYBN	Glycinin G3 - Glycine max 
461878	8431	A2Z708_ORYSI	Putative uncharacterized protein - Oryza sativa subsp. indica 
461879	8431	13S3_FAGES	13S globulin seed storage protein 3 - Fagopyrum esculentum 
461880	8432	1433_MESCR	14-3-3-LIKE PROTEIN (G-BOX BINDING FACTOR) - MESEMBRYANTHEMUM CRYSTALLINUM (COMMON ICE PLANT).
461881	8432	143C_ARATH	14-3-3-LIKE PROTEIN GF14 CHI - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461882	8432	BMH2_YEAST	BMH2 PROTEIN - SACCHAROMYCES CEREVISIAE (BAKER'S YEAST).
461883	8432	143C_SOYBN	14-3-3-LIKE PROTEIN C (SGF14C) - GLYCINE MAX (SOYBEAN).
461884	8432	143B_RAT	14-3-3 PROTEIN BETA/ALPHA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) (PREPRONERVE GROWTH FACTOR RNH-1) - RATTUS NORVEGICUS (RAT).
461885	8432	143A_HORVU	14-3-3-LIKE PROTEIN A (14-3-3A) - HORDEUM VULGARE (BARLEY).
461887	8432	143B_HUMAN	14-3-3 PROTEIN BETA/ALPHA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) (PROTEIN 1054) - HOMO SAPIENS (HUMAN).
461888	8432	1434_SOLTU	14-3-3-LIKE PROTEIN RA215 - SOLANUM TUBEROSUM (POTATO).
461889	8432	1433_NEOCA	14-3-3 PROTEIN HOMOLOG - NEOSPORA CANINUM.
461890	8432	1433_PEA	14-3-3-LIKE PROTEIN - PISUM SATIVUM (GARDEN PEA).
461891	8432	143Z_SHEEP	14-3-3 PROTEIN ZETA/DELTA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) - OVIS ARIES (SHEEP).
461892	8432	O61131	14-3-3 PROTEIN - PLASMODIUM KNOWLESI.
461893	8432	1431_ENTHI	14-3-3 PROTEIN 1 (14-3-3-1) - ENTAMOEBA HISTOLYTICA.
461894	8432	P93785	14-3-3 PROTEIN - SOLANUM TUBEROSUM (POTATO).
461895	8432	P93787	14-3-3 PROTEIN - SOLANUM TUBEROSUM (POTATO).
461896	8432	143B_BOVIN	14-3-3 PROTEIN BETA/ALPHA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) - BOS TAURUS (BOVINE), AND OVIS ARIES (SHEEP).
461897	8432	1434_LYCES	14-3-3-LIKE PROTEIN 4 (PBLT4) - LYCOPERSICON ESCULENTUM (TOMATO).
461898	8432	1431_LYCES	14-3-3-LIKE PROTEIN 1 - LYCOPERSICON ESCULENTUM (TOMATO).
461899	8432	1436_LYCES	14-3-3-LIKE PROTEIN 6 - LYCOPERSICON ESCULENTUM (TOMATO).
461900	8432	143F_HUMAN	14-3-3 PROTEIN ETA (PROTEIN AS1) - HOMO SAPIENS (HUMAN).
461901	8432	O49082	GF14 PROTEIN - FRITILLARIA AGRESTIS.
461902	8432	O80367	GF14 MU - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461903	8432	143B_TOBAC	14-3-3-LIKE PROTEIN B - NICOTIANA TABACUM (COMMON TOBACCO).
461904	8432	O65352	14-3-3-LIKE PROTEIN - HELIANTHUS ANNUUS (COMMON SUNFLOWER).
461905	8432	1433_TOBAC	14-3-3-LIKE PROTEIN - NICOTIANA TABACUM (COMMON TOBACCO).
461906	8432	1432_MAIZE	14-3-3-LIKE PROTEIN GF14-12 - ZEA MAYS (MAIZE).
461907	8432	143K_ARATH	14-3-3-LIKE PROTEIN GF14 KAPPA - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461908	8432	143H_ARATH	14-3-3-LIKE PROTEIN GF14 PHI - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461909	8432	143O_ARATH	14-3-3-LIKE PROTEIN GF14 OMEGA - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461910	8432	O77642	STRATIFIN - OVIS ARIES (SHEEP).
461911	8432	143E_ARATH	14-3-3-LIKE PROTEIN GF14 EPSILON - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461912	8432	143N_ARATH	14-3-3-LIKE PROTEIN GF14 NU - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461913	8432	O49152	14-3-3 PROTEIN HOMOLOG - MAACKIA AMURENSIS.
461914	8432	143Z_MOUSE	14-3-3 PROTEIN ZETA/DELTA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) (MITOCHONDRIAL IMPORT STIMULATION FACTOR S1 SUBUNIT) - MUS MUSCULUS (MOUSE), AND RATTUS NORVEGICUS (RAT).
461915	8432	143R_ARATH	14-3-3-LIKE PROTEIN RCI2 - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461916	8432	143A_VICFA	14-3-3-LIKE PROTEIN A (VFA-1433A) - VICIA FABA (BROAD BEAN).
461917	8432	143Z_DROME	14-3-3-LIKE PROTEIN (LEONARDO PROTEIN) (14-3-3 ZETA) - DROSOPHILA MELANOGASTER (FRUIT FLY).
461918	8432	143D_TOBAC	14-3-3-LIKE PROTEIN D - NICOTIANA TABACUM (COMMON TOBACCO).
461919	8432	O70457	14-3-3 PROTEIN GAMMA - MUS MUSCULUS (MOUSE).
461920	8432	O70456	14-3-3 PROTEIN SIGMA - MUS MUSCULUS (MOUSE).
461921	8432	O70455	14-3-3 PROTEIN BETA - MUS MUSCULUS (MOUSE).
461922	8432	1434_CAEEL	14-3-3-LIKE PROTEIN 2 - CAENORHABDITIS ELEGANS.
461923	8432	143P_ARATH	14-3-3-LIKE PROTEIN GF14 PSI (14-3-3-LIKE PROTEIN RCI1) - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461924	8432	143B_HORVU	14-3-3-LIKE PROTEIN B (14-3-3B) - HORDEUM VULGARE (BARLEY).
461925	8432	O60955	14-3-3 PROTEIN HOMOLOGUE - TOXOPLASMA GONDII.
461926	8432	O24001	14-3-3 PROTEIN - HORDEUM VULGARE (BARLEY).
461927	8432	143D_SOYBN	14-3-3-LIKE PROTEIN D (SGF14D) - GLYCINE MAX (SOYBEAN).
461928	8432	143G_BOVIN	14-3-3 PROTEIN GAMMA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) - BOS TAURUS (BOVINE), AND OVIS ARIES (SHEEP).
461929	8432	1433_DICDI	14-3-3-LIKE PROTEIN - DICTYOSTELIUM DISCOIDEUM (SLIME MOLD).
461930	8432	143G_RAT	14-3-3 PROTEIN GAMMA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) - RATTUS NORVEGICUS (RAT).
461931	8432	P93786	14-3-3 PROTEIN - SOLANUM TUBEROSUM (POTATO).
461932	8432	143T_HUMAN	14-3-3 PROTEIN TAU (14-3-3 PROTEIN THETA) (14-3-3 PROTEIN T-CELL) (HS1 PROTEIN) - HOMO SAPIENS (HUMAN).
461933	8432	Q21539	M117.3 PROTEIN - CAENORHABDITIS ELEGANS.
461934	8432	1433_CANAL	14-3-3 PROTEIN HOMOLOG - CANDIDA ALBICANS (YEAST).
461935	8432	1435_LYCES	14-3-3-LIKE PROTEIN 5 - LYCOPERSICON ESCULENTUM (TOMATO).
461936	8432	1433_OENHO	14-3-3-LIKE PROTEIN - OENOTHERA HOOKERI (HOOKER'S EVENING PRIMROSE).
461937	8432	143S_HUMAN	14-3-3 PROTEIN SIGMA (STRATIFIN) (EPITHELIAL CELL MARKER PROTEIN 1) - HOMO SAPIENS (HUMAN).
461938	8432	143T_RAT	14-3-3 PROTEIN TAU (14-3-3 PROTEIN THETA) - MUS MUSCULUS (MOUSE), AND RATTUS NORVEGICUS (RAT).
461939	8432	1433_CHLRE	14-3-3-LIKE PROTEIN - CHLAMYDOMONAS REINHARDTII.
461940	8432	143F_TOBAC	14-3-3-LIKE PROTEIN F - NICOTIANA TABACUM (COMMON TOBACCO).
461941	8432	143Z_HUMAN	14-3-3 PROTEIN ZETA/DELTA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) (FACTOR ACTIVATING EXOENZYME S) (FAS) - HOMO SAPIENS (HUMAN), AND BOS TAURUS (BOVINE).
461942	8432	143F_MOUSE	14-3-3 PROTEIN ETA (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) - MUS MUSCULUS (MOUSE), RATTUS NORVEGICUS (RAT), AND BOS TAURUS (BOVINE).
461943	8432	1433_CAEEL	14-3-3-LIKE PROTEIN 1 - CAENORHABDITIS ELEGANS.
461944	8432	143C_TOBAC	14-3-3-LIKE PROTEIN C (14-3-3-LIKE PROTEIN B) - NICOTIANA TABACUM (COMMON TOBACCO).
461945	8432	1433_SOLTU	14-3-3-LIKE PROTEIN - SOLANUM TUBEROSUM (POTATO).
461946	8432	143E_TOBAC	14-3-3-LIKE PROTEIN E - NICOTIANA TABACUM (COMMON TOBACCO).
461947	8432	143A_TOBAC	14-3-3-LIKE PROTEIN A - NICOTIANA TABACUM (COMMON TOBACCO).
461948	8432	143Z_XENLA	14-3-3 PROTEIN ZETA - XENOPUS LAEVIS (AFRICAN CLAWED FROG).
461949	8432	Q24902	EMMA14-3-3.1 - ECHINOCOCCUS MULTILOCULARIS.
461950	8432	143E_HUMAN	14-3-3 PROTEIN EPSILON (MITOCHONDRIAL IMPORT STIMULATION FACTOR L SUBUNIT) (PROTEIN KINASE C INHIBITOR PROTEIN-1) (KCIP-1) (14-3-3E) - HOMO SAPIENS (HUMAN), MUS MUSCULUS (MOUSE), RATTUS NORVEGICUS (RAT), BOS TAURUS (BOVINE), AND OVIS ARIES (SHEEP).
461951	8432	1432_ENTHI	14-3-3 PROTEIN 2 (14-3-3-2) - ENTAMOEBA HISTOLYTICA.
461952	8432	1431_SCHMA	14-3-3 PROTEIN HOMOLOG 1 - SCHISTOSOMA MANSONI (BLOOD FLUKE).
461953	8432	1433_LYCES	14-3-3-LIKE PROTEIN 3 (PBLT3) - LYCOPERSICON ESCULENTUM (TOMATO).
461954	8432	1435_SOLTU	14-3-3-LIKE PROTEIN 16R - SOLANUM TUBEROSUM (POTATO).
461955	8432	143E_DROME	14-3-3 PROTEIN EPSILON (SUPPRESSOR OF RAS1 3-9) - DROSOPHILA MELANOGASTER (FRUIT FLY).
461956	8432	RA25_SCHPO	DNA DAMAGE CHECKPOINT PROTEIN RAD25 - SCHIZOSACCHAROMYCES POMBE (FISSION YEAST).
461957	8432	1432_LYCES	14-3-3-LIKE PROTEIN 2 - LYCOPERSICON ESCULENTUM (TOMATO).
461958	8432	143U_ARATH	14-3-3-LIKE PROTEIN GF14 UPSILON - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461959	8432	O57469	14-3-3 PROTEIN ZETA - XENOPUS LAEVIS (AFRICAN CLAWED FROG).
461960	8432	O57468	14-3-3 PROTEIN EPSILON - XENOPUS LAEVIS (AFRICAN CLAWED FROG).
461961	8432	RA24_SCHPO	DNA DAMAGE CHECKPOINT PROTEIN RAD24 - SCHIZOSACCHAROMYCES POMBE (FISSION YEAST).
461962	8432	1433_ORYSA	14-3-3-LIKE PROTEIN S94 - ORYZA SATIVA (RICE).
461963	8432	BMH1_YEAST	BMH1 PROTEIN - SACCHAROMYCES CEREVISIAE (BAKER'S YEAST).
461964	8432	O24221	GF14-B PROTEIN - ORYZA SATIVA (RICE).
461965	8432	O24223	GF14-D PROTEIN - ORYZA SATIVA (RICE).
461966	8432	O24222	GF14-C PROTEIN - ORYZA SATIVA (RICE).
461967	8432	1431_MAIZE	14-3-3-LIKE PROTEIN GF14-6 - ZEA MAYS (MAIZE).
461968	8432	143L_ARATH	14-3-3-LIKE PROTEIN GF14 LAMBDA (14-3-3-LIKE PROTEIN AFT1) - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461969	8432	Q39558	32KDA ENDONUCLEASE - CUCURBITA PEPO (VEGETABLE MARROW) (SUMMER SQUASH).
461970	8432	1433_TRIHA	14-3-3 PROTEIN HOMOLOG (TH1433) - TRICHODERMA HARZIANUM.
461971	8432	143M_ARATH	14-3-3-LIKE PROTEIN GF14 MU - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
461972	8432	143A_SOYBN	14-3-3-LIKE PROTEIN A (SGF14A) - GLYCINE MAX (SOYBEAN).
461973	8432	143B_VICFA	14-3-3-LIKE PROTEIN B (VFA-1433B) - VICIA FABA (BROAD BEAN).
461974	8433	POLN_FCVF9	NON-STRUCTURAL POLYPROTEIN [CONTAINS: RNA-DIRECTED RNA POLYMERASE (EC 2.7.7.48); THIOL PROTEASE (EC 3.4.22.-); HELICASE (2C LIKE PROTEIN)] - FELINE CALICIVIRUS (STRAIN F9) (FCV).
461975	8433	Q66913	NON-STRUCTURAL PROTEINS - FELINE CALICIVIRUS.
461976	8433	Q66914	POLYPROTEIN - FELINE CALICIVIRUS.
461977	8433	O92368	NON-STRUCTURAL POLYPROTEIN - VESV-LIKE CALICIVIRUS.
461978	8433	POLN_RHDV	NON-STRUCTURAL POLYPROTEIN [CONTAINS: RNA-DIRECTED RNA POLYMERASE (EC 2.7.7.48); THIOL PROTEASE P3C (EC 3.4.22.-); HELICASE (2C LIKE PROTEIN); COAT PROTEIN] - RABBIT HEMORRHAGIC DISEASE VIRUS (RHDV).
461979	8433	Q96725	RNA - EUROPEAN BROWN HARE SYNDROME VIRUS.
461980	8433	POLN_MANCV	GENOME POLYPROTEIN [CONTAINS: RNA-DIRECTED RNA POLYMERASE (EC 2.7.7.48); THIOL PROTEASE 3C (EC 3.4.22.-); HELICASE (2C LIKE PROTEIN); COAT PROTEIN] - MANCHESTER VIRUS (HUMAN ENTERIC CALICIVIRUS).
461981	8433	POLN_FCVC6	NON-STRUCTURAL POLYPROTEIN [CONTAINS: RNA-DIRECTED RNA POLYMERASE (EC 2.7.7.48); THIOL PROTEASE (EC 3.4.22.-); HELICASE (2C LIKE PROTEIN)] - FELINE CALICIVIRUS (STRAIN CFI/68 FIV) (FCV).
461982	8433	Q86114	POLYPROTEIN - RABBIT HEMORRHAGIC DISEASE VIRUS (RHDV).
461983	8433	Q86117	(SD) - RABBIT HEMORRHAGIC DISEASE VIRUS (RHDV).
461984	8433	Q86119	POLYPROTEIN - RABBIT HEMORRHAGIC DISEASE VIRUS (RHDV).
461985	8433	Q89273	POLYPROTEIN - RABBIT HEMORRHAGIC DISEASE VIRUS (RHDV).
461986	8434	FERH_ANASP	FERREDOXIN, HETEROCYST - ANABAENA SP. (STRAIN PCC 7120).
461987	8434	FER1_PHYES	FERREDOXIN I - PHYTOLACCA ESCULENTA (FOOD POKEBERRY).
461988	8434	FER_SYNP4	FERREDOXIN - SYNECHOCOCCUS SP. (STRAIN PCC 7418) (APHANOTHECE HALOPHITICA).
461989	8434	FER_EUGVI	FERREDOXIN - EUGLENA VIRIDIS.
461990	8434	FER2_PHYES	FERREDOXIN II - PHYTOLACCA ESCULENTA (FOOD POKEBERRY).
461991	8434	FER_ARCLA	FERREDOXIN - ARCTIUM LAPPA (GREAT BURDOCK).
461992	8434	FER2_CYACA	FERREDOXIN - CYANIDIUM CALDARIUM (GALDIERIA SULPHURARIA).
461993	8434	FER_BRANA	FERREDOXIN - BRASSICA NAPUS (RAPE).
461994	8434	FER2_EQUTE	FERREDOXIN II - EQUISETUM TELMATEIA (GIANT HORSETAIL).
461995	8434	FER_CHLRE	FERREDOXIN PRECURSOR - CHLAMYDOMONAS REINHARDTII.
461996	8434	FER1_CYACA	FERREDOXIN - CYANIDIUM CALDARIUM (GALDIERIA SULPHURARIA).
461997	8434	O04166	FERREDOXIN - PHYSCOMITRELLA PATENS (MOSS).
461998	8434	FER1_LYCES	FERREDOXIN I PRECURSOR - LYCOPERSICON ESCULENTUM (TOMATO).
461999	8434	FER_PERBI	FERREDOXIN - PERIDINIUM BIPES (DINOFLAGELLATE).
462000	8434	FER1_CYAPA	FERREDOXIN I - CYANOPHORA PARADOXA.
462001	8434	FERB_ALOMA	FERREDOXIN B (FD B) - ALOCASIA MACRORRHIZA (GIANT TARO).
462002	8434	FER_SYNY4	FERREDOXIN - SYNECHOCYSTIS SP. (STRAIN PCC 6714).
462003	8434	FER_SYNY3	FERREDOXIN I - SYNECHOCYSTIS SP. (STRAIN PCC 6803).
462004	8434	FER_WHEAT	FERREDOXIN PRECURSOR - TRITICUM AESTIVUM (WHEAT).
462005	8434	FER1_PHYAM	FERREDOXIN I - PHYTOLACCA AMERICANA (COMMON POKEBERRY) (VIRGINIAN POKEWEED).
462006	8434	FER2_ARATH	FERREDOXIN 2 PRECURSOR - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
462007	8434	FERV_ANAVA	FERREDOXIN, VEGETATIVE - ANABAENA VARIABILIS.
462008	8434	FER3_MAIZE	FERREDOXIN III PRECURSOR (FD III) - ZEA MAYS (MAIZE).
462009	8434	FER1_RAPSA	FERREDOXIN, ROOT R-B1 - RAPHANUS SATIVUS (RADISH).
462010	8434	FER2_PHYAM	FERREDOXIN II - PHYTOLACCA AMERICANA (COMMON POKEBERRY) (VIRGINIAN POKEWEED).
462011	8434	FER1_DUNSA	FERREDOXIN I - DUNALIELLA SALINA.
462012	8434	FER_SYNLI	FERREDOXIN - SYNECHOCOCCUS LIVIDUS.
462013	8434	FER6_MAIZE	FERREDOXIN VI PRECURSOR (FD VI) - ZEA MAYS (MAIZE).
462014	8434	FER_SILPR	FERREDOXIN PRECURSOR - SILENE PRATENSIS (WHITE CAMPION) (LYCHNIS ALBA).
462015	8434	FER_GUITH	FERREDOXIN - GUILLARDIA THETA (CRYPTOMONAS PHI).
462016	8434	FER1_EQUAR	FERREDOXIN I - EQUISETUM ARVENSE (FIELD HORSETAIL) (COMMON HORSETAIL).
462017	8434	O87723	FDX - SYNECHOCOCCUS SP. (STRAIN PCC 8801 / RF-1) (CYANOTHECE PCC 8801).
462018	8434	FER1_MESCR	FERREDOXIN I PRECURSOR - MESEMBRYANTHEMUM CRYSTALLINUM (COMMON ICE PLANT).
462019	8434	FER_MEDSA	FERREDOXIN - MEDICAGO SATIVA (ALFALFA).
462020	8434	FER1_PLEBO	FERREDOXIN I (FDI) - PLECTONEMA BORYANUM.
462021	8434	FER1_ANASP	FERREDOXIN I - ANABAENA SP. (STRAIN PCC 7120).
462022	8434	FER2_NOSMU	FERREDOXIN II - NOSTOC MUSCORUM.
462023	8434	FER3_RAPSA	FERREDOXIN, LEAF L-A - RAPHANUS SATIVUS (RADISH).
462024	8434	FER2_APHSA	FERREDOXIN II - APHANOTHECE SACRUM.
462025	8434	FER1_SPIOL	FERREDOXIN I PRECURSOR - SPINACIA OLERACEA (SPINACH).
462026	8434	FERH_FREDI	FERREDOXIN, HETEROCYST - FREMYELLA DIPLOSIPHON (CALOTHRIX PCC 7601).
462027	8434	O22382	FERREDOXIN - ORYZA SATIVA (RICE).
462028	8434	O30582	PLANT-TYPE - SYNECHOCOCCUS SP. (STRAIN PCC 8801 / RF-1) (CYANOTHECE PCC 8801).
462029	8434	FER_SPIMA	FERREDOXIN - SPIRULINA MAXIMA.
462030	8434	FER_ODOSI	FERREDOXIN - ODONTELLA SINENSIS.
462031	8434	FER_CHLFU	FERREDOXIN - CHLORELLA FUSCA.
462032	8434	FER_CHLFR	FERREDOXIN - CHLOROGLOEOPSIS FRITSCHII.
462033	8434	FER1_APHFL	FERREDOXIN I - APHANIZOMENON FLOS-AQUAE.
462034	8434	FER_SAMNI	FERREDOXIN - SAMBUCUS NIGRA (EUROPEAN ELDER).
462035	8434	Q40684	FERREDOXIN - ORYZA SATIVA (RICE).
462036	8434	Q40683	FERREDOXIN - ORYZA SATIVA (RICE).
462037	8434	FER2_RAPSA	FERREDOXIN, ROOT R-B2 - RAPHANUS SATIVUS (RADISH).
462038	8434	FER_NOSMU	FERREDOXIN - NOSTOC MUSCORUM.
462039	8434	FER_APHSA	FERREDOXIN I - APHANOTHECE SACRUM.
462040	8434	FER_DATST	FERREDOXIN - DATURA STRAMONIUM (JIMSONWEED) (COMMON THORNAPPLE).
462041	8434	FER_RHOPL	FERREDOXIN - RHODYMENIA PALMATA (DULSE).
462042	8434	FER1_EQUTE	FERREDOXIN I - EQUISETUM TELMATEIA (GIANT HORSETAIL).
462043	8434	FER2_EQUAR	FERREDOXIN II - EQUISETUM ARVENSE (FIELD HORSETAIL) (COMMON HORSETAIL).
462044	8434	FER_BUMFI	FERREDOXIN - BUMILLERIOPSIS FILIFORMIS.
462045	8434	FER_GLEJA	FERREDOXIN - GLEICHENIA JAPONICA (URAJIRO) (FERN).
462046	8434	FER_PORPU	FERREDOXIN - PORPHYRA PURPUREA.
462047	8434	FER_ARATH	FERREDOXIN PRECURSOR - ARABIDOPSIS THALIANA (MOUSE-EAR CRESS).
462048	8434	FER5_MAIZE	FERREDOXIN V PRECURSOR (FD V) - ZEA MAYS (MAIZE).
462049	8434	FERA_ALOMA	FERREDOXIN A (FD A) - ALOCASIA MACRORRHIZA (GIANT TARO).
462050	8434	FER_MARPO	FERREDOXIN - MARCHANTIA POLYMORPHA (LIVERWORT).
462051	8434	FERH_ANAVA	FERREDOXIN, HETEROCYST - ANABAENA VARIABILIS.
462052	8434	FER2_DUNSA	FERREDOXIN II - DUNALIELLA SALINA.
462053	8434	FER_BRYMA	FERREDOXIN - BRYOPSIS MAXIMA.
462054	8434	FER_SYNEL	FERREDOXIN I - SYNECHOCOCCUS ELONGATUS, SYNECHOCOCCUS ELONGATUS NAEGELI, AND SYNECHOCOCCUS VULCANUS.
462055	8434	FER_SPIPL	FERREDOXIN - SPIRULINA PLATENSIS.
462056	8434	FER_COLES	FERREDOXIN - COLOCASIA ESCULENTA (ELEPHANT'S EAR) (TARO).
462057	8434	FER1_ANAVA	FERREDOXIN I - ANABAENA VARIABILIS, AND ANABAENA SP. (STRAIN PCC 7937).
462058	8434	FER1_PEA	FERREDOXIN I PRECURSOR - PISUM SATIVUM (GARDEN PEA).
462059	8434	FER1_SYNP2	FERREDOXIN I - SYNECHOCOCCUS SP. (STRAIN PCC 7002) (AGMENELLUM QUADRUPLICATUM).
462060	8434	FER_PORUM	FERREDOXIN - PORPHYRA UMBILICALIS (LAVER).
462061	8434	FER1_SYNP7	FERREDOXIN I - SYNECHOCOCCUS SP. (STRAIN PCC 7942) (ANACYSTIS NIDULANS R2), AND SYNECHOCOCCUS SP. (STRAIN PCC 6301).
462062	8434	FER2_SPIOL	FERREDOXIN II - SPINACIA OLERACEA (SPINACH).
462063	8434	FER1_ORYSA	FERREDOXIN I - ORYZA SATIVA (RICE).
462064	8434	FER_MASLA	FERREDOXIN - MASTIGOCLADUS LAMINOSUS (FISCHERELLA SP.).
462065	8434	O80429	FERREDOXIN - ZEA MAYS (MAIZE).
462066	8434	Q39648	NON-PHOTOSYNTHETIC FERREDOXIN PRECURSOR - CITRUS SINENSIS (SWEET ORANGE).
462067	8434	FER2_PLEBO	FERREDOXIN II (FDII) - PLECTONEMA BORYANUM.
462068	8434	FER1_NOSMU	FERREDOXIN I - NOSTOC MUSCORUM.
462069	8434	FER_SCEQU	FERREDOXIN - SCENEDESMUS QUADRICAUDA.
462070	8434	FER1_MAIZE	FERREDOXIN I PRECURSOR (FD I) - ZEA MAYS (MAIZE).
462071	8434	FER_LEUGL	FERREDOXIN - LEUCAENA GLAUCA (WHITE POPINAC) (LEUCAENA LEUCOCEPHALA).
\.


--
-- Data for Name: reference; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY reference (fingerprint_id, author, title, journal, literature_id, year, reference_number) FROM stdin;
8431	HAYASHI, M., MORI, H., NISHIMURA, M., AKAZAWA, T. AND HARA-NISHIMURA, I.	Nucleotide sequence of cloned cDNA coding for pumpkin 11-S globulin\nbeta-subunit	EUR.J.BIOCHEM. 172(3) 627-632 	25649	1988	1
8431	SHOTWELL, M.A., AFONSO, C., DAVIES, E., CHESNUT, R.S. AND LARKINS, B.A.	Molecular characterisation of oat seed globulins.	PLANT PHYSIOL. 87(3) 698-704 	25650	1988	2
8432	ISOBE, T., ICHIMURA, T., SUNAYA, T., OKUYAMA, T., TAKAHASHI, N.,\nKUWANO, R. AND TAKAHASHI, Y.	Distinct forms of the protein kinase-dependent activator of tyrosine and\ntryptophan hydroxylases.	J.MOL.BIOL. 217 125-132 	25651	1991	1
8432	KIDOU, S., UMEDA, M., KATA, A. AND ICHIMIYA, H.	Isolation and characterization of a rice cDNA similar to the bovine\nbrain-specific 14-3-3 protein gene.	PLANT MOL.BIOL. 21 191-194 	25652	1993	2
8432	ZUPAN, L.A., STEFFENS, D.L., BERRY, C.A., LANDT, M. AND GOSS, R.W.	Cloning and expression of a human 14-3-3 protein mediating phospholipolysis.\nIdentification of an arachidonyl-enzyme intermediate during catalysis.	J.BIOL.CHEM. 267 8707-8710 	25653	1992	3
8433	RAWLINGS, N.D. AND BARRETT, A.J.	Families of cysteine peptidases.	METHODS ENZYMOL. 244 461-486 	25654	1994	1
8433	BARRETT, A.J. AND RAWLINGS, N.D.	Families and clans of cysteine peptidases	PERSPECTIVES DRUG DISCOVERY DESIGN 6 1-11 	25655	1996	2
8433	WIRBLICH, C., THIEL,H. AND MEYERS, G.	Genetic map of the calicivirus rabbit hemorrhagic diesease virus as detected\nfrom in vitro translation studies.	J.VIROL. 70(11) 7974-7983 	25656	1996	5
8434	OTAKA, E. AND OOI, T.	Examination of protein sequence homologies: V. New perspectives on\nevolution between bacterial and chloroplast-type ferredoxins inferred from\nsequence evidence.	J.MOL.EVOL. 29 246-254 	25657	1989	1
8434	MASON, J.R. AND CAMMACK, R.	The electron-transport proteins of hydroxylating bacterial dioxygenases.	ANNU.REV.MICROBIOL. 46 277-305 	25658	1992	2
8434	RYPNIEWSKI, W.R., BREITER, D.R., BENNING, M.M., WESENBERG, G., OH, B.H.,\nMARKLEY, J.L., RAYMENT, I. AND HOLDEN, H.M.	Crystallization and structure determination to 2.5A resolution of the \noxidized [2Fe-2S] ferredoxin isolated from Anabaena 7120. 	BIOCHEMISTRY 30 4126-4131 	25659	1991	3
8434	CORRELL, C.C., BATIE, C.J., BALLOU, D.P. AND LUDWIG, M.L.	Phthalate dioxygenase reductase: a modular structure for electron transfer \nfrom pyridine nucleotides to [2Fe-2S].	SCIENCE 258 1604-1610 	25660	1992	5
\.


--
-- Name: reference_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('reference_reference_id_seq', 62382, true);


--
-- Data for Name: scanhistory; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY scanhistory (sh_id, database, iterations_number, hitlist_length, scanning_method, fingerprint_id) FROM stdin;
12974	OWL26_0	3	150	NSINGLE	8431
12975	SPTR37_9f	2	158	NSINGLE	8431
12976	SPTR57.15_40.15f	7	600	NSINGLE	8431
12977	OWL24_0	2	100	NSINGLE	8432
12978	OWL28_0	1	130	NSINGLE	8432
12979	SPTR37_9f	2	112	NSINGLE	8432
12980	OWL30_2	2	50	NSINGLE	8433
12981	SPTR37_9f	2	13	NSINGLE	8433
12982	OWL25_2	2	300	NSINGLE	8434
12983	SPTR37_9f	2	300	NSINGLE	8434
\.


--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('scanhistory_sh_id_seq', 12983, true);


--
-- Data for Name: seq; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY seq (seq_id, motif_id, sequence, pcode, start, "interval") FROM stdin;
1785729	85213	RQNIDNPNRADTYNPRAG	GLU1_ORYSA	318	318
1785730	85213	RQNIDNPNRADTYNPRAG	GLU2_ORYSA	318	318
1785731	85213	RQNIDNPNRADTYNPRAG	GLU3_ORYSA	318	318
1785732	85213	RVNIENPSRADSYNPRAG	GLU4_ORYSA	314	314
1785733	85213	RVNIENPSRADSYNPRAG	GLUB_ORYSA	314	314
1785734	85213	RVNIENPSRADSYNPRAG	GLUC_ORYSA	310	310
1785735	85213	RLNIENPSHADTYNPRAG	GLU5_ORYSA	315	315
1785736	85214	NTQNFPILSLVQMSAVKVNLY	GLU1_ORYSA	341	5
1785737	85214	NTQNFPILSLVQMSAVKVNLY	GLU2_ORYSA	341	5
1785738	85214	NSQNFPILNLVQMSAVKVNLY	GLU3_ORYSA	341	5
1785739	85214	NSQKFPILNLIQMSATRVNLY	GLU4_ORYSA	337	5
1785740	85214	NSQKFPILNLIQMSATRVNLY	GLUB_ORYSA	337	5
1785741	85214	NSQKFPILNLIQMDATRVNLY	GLUC_ORYSA	333	5
1785742	85214	NSQKFPILNLVQLSATRVNLY	GLU5_ORYSA	338	5
1785743	85215	VQVVNNNGKTVFNGELR	GLU1_ORYSA	387	3
1785744	85215	VQVVNNNGKTVFNGELR	GLU2_ORYSA	387	3
1785745	85215	VQVVNNNGKTVFNGELR	GLU3_ORYSA	387	3
1785746	85215	VQVVSNFGKTVFDGVLR	GLU4_ORYSA	383	3
1785747	85215	VQVVSNFGKTVFDGVLR	GLUB_ORYSA	383	3
1785748	85215	VQVVSNFGKTVFDGVLR	GLUC_ORYSA	379	3
1785749	85215	VQVVSNLGKTVFNGVLR	GLU5_ORYSA	384	3
1785750	85216	GQLLIIPQHYAVVKKA	GLU1_ORYSA	405	1
1785751	85216	GQLLIIPQHYAVVKKA	GLU2_ORYSA	405	1
1785752	85216	GQLLIVPQHYVVVKKA	GLU3_ORYSA	405	1
1785753	85216	AQLLIIPQHYAVLKKA	GLU4_ORYSA	401	1
1785754	85216	GQLLIIPQHYAVLKKA	GLUB_ORYSA	401	1
1785755	85216	GQLLIIPQHYAVLKKA	GLUC_ORYSA	397	1
1785756	85216	GQLLIIPQHYVVLKKA	GLU5_ORYSA	402	1
1785757	85217	EGCAYIAFKTNPNSMVSHI	GLU1_ORYSA	423	2
1785758	85217	EGCAYIAFKTNPNSMVSHI	GLU2_ORYSA	423	2
1785759	85217	EGCAYIAFKTNPNSMVSHI	GLU3_ORYSA	423	2
1785760	85217	EGCQYIAIKTNANAFVSHL	GLU4_ORYSA	419	2
1785761	85217	EGCQYIAIKTNANTFVSHL	GLUB_ORYSA	419	2
1785762	85217	EGCQYIAIKTNANAFVSHL	GLUC_ORYSA	415	2
1785763	85217	EGCQYISFKTNANSMVSHL	GLU5_ORYSA	420	2
1785764	85218	SSIFRALPNDVLANAYRI	GLU1_ORYSA	445	3
1785765	85218	SSIFRALPNDVLANAYRI	GLU2_ORYSA	445	3
1785766	85218	SSIFRALPTDVLANAYRI	GLU3_ORYSA	445	3
1785767	85218	NSVFRALPVDVVANAYRI	GLU4_ORYSA	441	3
1785768	85218	NSVFRALPVDVVANAYRI	GLUB_ORYSA	441	3
1785769	85218	NSVFRALPVDVVANAYRI	GLUC_ORYSA	437	3
1785770	85218	NSIFRAMPVDVIANAYRI	GLU5_ORYSA	442	3
1785771	85219	RVNIENPSRADSYNPRAG	A1YQH4_ORYSJ	310	310
1785772	85219	RVNIENPSRADSYNPRAG	Q0E2D5_ORYSJ	310	310
1785773	85219	RVNIENPSRADSYNPRAG	Q0E2D2_ORYSJ	314	314
1785774	85219	RVNIENPSRADSYNPRAG	GLUB2_ORYSJ	310	310
1785775	85219	RVNIENPSRADSYNPRAG	GLUB1_ORYSJ	314	314
1785776	85219	RVNIENPSRADSYNPRAG	B9F4T3_ORYSJ	292	292
1785777	85219	RVNIENPSRADSYNPRAG	B9F4T2_ORYSJ	74	74
1785778	85219	RVNIENPSRADSYNPRAG	B9F4T1_ORYSJ	288	288
1785779	85219	RVNIENPSRADSYNPRAG	B8AEZ5_ORYSI	292	292
1785780	85219	RVNIENPSRADSYNPRAG	A2X301_ORYSI	201	201
1785781	85219	RVNIENPSRADSYNPRAG	A1YQH6_ORYSJ	310	310
1785782	85219	RVNIENPSRADSYNPRAG	A1YQH5_ORYSJ	310	310
1785783	85219	RENIGDPSRADIYTEEAG	B5KVH4_CARIL	328	328
1785784	85219	RENIGDPSRADIYTEEAG	B5KVH5_CARIL	328	328
1785785	85219	RQNIDNPNRADTYNPRAG	A1YQG3_ORYSJ	318	318
1785786	85219	RQNIDNPNRADTYNPRAG	GLUA2_ORYSJ	318	318
1785787	85219	RQNIDNPNRADTYNPRAG	A2Z708_ORYSI	318	318
1785788	85219	RVNIENPSRADSYNPRAG	A2X2Z8_ORYSI	253	253
1785789	85219	RLNIENPSHADTYNPRAG	A2X399_ORYSI	315	315
1785790	85219	RLNIENPSHADTYNPRAG	Q0E262_ORYSJ	315	315
1785791	85219	RLNIENPSHADTYNPRAG	Q0E261_ORYSJ	315	315
1785792	85219	RLNIENPSHADTYNPRAG	GLUB5_ORYSJ	315	315
1785793	85219	RLNIENPSHADTYNPRAG	GLUB4_ORYSJ	315	315
1785794	85219	RLNIENPSHADTYNPRAG	A2X3A0_ORYSI	134	134
1785795	85219	RENIGDPSRADIYTEEAG	Q2TPW5_9ROSI	327	327
1785796	85219	RQNIDNPNRADTYNPRAG	A2WVB9_ORYSI	318	318
1785797	85219	RQNIDNPNRADTYNPRAG	A1YQG5_ORYSJ	318	318
1785798	85219	RQNIDNPNRADTYNPRAG	Q0JJ36_ORYSJ	318	318
1785799	85219	RQNIDNPNRADTYNPRAG	GLUA1_ORYSJ	318	318
1785800	85219	WQNIDNPNLADTYNPRAG	Q0Z945_9ORYZ	319	319
1785801	85219	RLNIENPNHADTYNPRAG	A2X2V1_ORYSI	311	311
1785802	85219	RLNIENPNHADTYNPRAG	Q84X94_ORYSJ	311	311
1785803	85219	RKNIENPQHADTYNPRAG	Q38780_AVESA	337	337
1785804	85219	TYNIADPTRADVYNPQAG	Q40347_MAGSL	300	300
1785805	85219	GENIGDPSRADVFTPEAG	B9GS11_POPTR	305	305
1785806	85219	RLNIENPNHADTYNPRAG	C0L8H1_ORYSJ	310	310
1785807	85219	RLNIENPNHADTYNPRAG	Q84X93_ORYSJ	311	311
1785808	85219	RLNIENPNHADTYNPRAG	Q6ESW6_ORYSJ	311	311
1785809	85219	RQNIENPKRADTYNPRAG	SSG2_AVESA	329	329
1785810	85219	RQNIDNPNRADTYNPRAG	Q40689_ORYSA	318	318
1785811	85219	RENIGDPSRADVFTPEAG	B9H8M5_POPTR	305	305
1785812	85219	RQNIDNPNLADTYNPKAG	Q0Z870_9ORYZ	327	327
1785813	85219	RKNIENPQHADTYNPRAG	Q38779_AVESA	361	361
1785814	85219	RENIHDPSRADIYNPQAG	Q41128_QUERO	310	310
1785815	85219	RENICTRSRADIYTEQVG	Q8W1C2_CORAV	332	332
1785816	85219	RQNIGNPKRADTHNPRAG	O49258_AVESA	325	325
1785817	85219	RQNIDNPNLADTYNPRAG	B8AKE2_ORYSI	317	317
1785818	85219	RQNIDNPNLADTYNPRAG	Q10JA8_ORYSJ	317	317
1785819	85219	RQNIDNPNLADTYNPRAG	GLUA3_ORYSJ	317	317
1785820	85219	RQNIDNPNLADTYNPRAG	B9F952_ORYSJ	317	317
1785821	85219	RENIHDPSRTDIYNPDAG	Q8LK20_CASCR	365	365
1785822	85219	RQNIENPKRADTYNPRAG	SSG1_AVESA	329	329
1785823	85219	KENIGDPSRADIFTPQAG	A1E0V5_FICAW	334	334
1785824	85219	RENIGDPSRADVFTPQAG	A1E0V7_FICAW	320	320
1785825	85219	KENIHDPSRSDIYTPEVG	B7SLJ1_PISVE	299	299
1785826	85219	KENIGDPSRADIFTPQAG	A1E0V4_FICAW	336	336
1785827	85219	RENIDKPSRADIYNPRAG	Q2XSW6_SESIN	293	293
1785828	85219	RENIGDPSRADVFSPQAG	A1E0V8_FICAW	314	314
1785829	85219	RLNIENPTRADSYDPRAG	B8AEZ0_ORYSI	288	288
1785830	85219	RLNIENPSRADSYDPRAG	A3A527_ORYSJ	288	288
1785831	85219	RLNIENPSRADSYDPRAG	Q6T725_ORYSJ	310	310
1785832	85219	SENIDDPSKADVYSPEAG	Q06AW1_CHEQI	303	303
1785833	85219	SENIDDPSKADVYSPEAG	Q6Q384_CHEQI	303	303
1785834	85219	SVNIDDPSRADIYNPRAG	B2CGM6_WHEAT	394	394
1785835	85219	KQNIENPKRADTYNPRAG	O49257_AVESA	282	282
1785836	85219	HENINRPSRADLYNPRAG	B5U8K2_LOTJA	437	437
1785837	85219	HENINRPSRADLYNPRAG	B5U8K1_LOTJA	406	406
1785838	85219	HENIARPSRADFYNPKAG	A3KEY9_GLYSO	390	390
1785839	85219	HENIARPSRADFYNPKAG	Q9SB11_SOYBN	390	390
1785840	85219	HENIARPSRADFYNPKAG	Q9S9D0_SOYBN	390	390
1785841	85219	HENIARPSRADFYNPKAG	Q43452_SOYBN	389	389
1785842	85219	HENIARPSRADFYNPKAG	Q39921_GLYSO	390	390
1785843	85219	HENIARPSRADFYNPKAG	GLYG4_SOYBN	389	389
1785844	85219	VENIDNPSRADIFNPRAG	A0EM47_ACTCH	290	290
1785845	85219	SVNIDDPSRADIYNPRAG	B2CGM5_WHEAT	394	394
1785846	85219	SENIDEPSKADVYSPEAG	Q06AW2_CHEQI	304	304
1785847	85219	SENIDEPSKADVYSPEAG	Q6Q385_CHEQI	304	304
1785848	85219	KLNINDPEDADVFNPRAG	B9N2L2_POPTR	292	292
1785849	85219	KLNINDPEDADVFNPRAG	B9P6C0_POPTR	322	322
1785850	85219	RENIADPTRADLYNPTAG	C9WC98_LUPAN	319	319
1785851	85219	RENIKSPQEADFYNPKAG	13SB_FAGES	12	12
1785852	85219	RENIANPARADLYNPRAG	Q41703_VICSA	316	316
1785853	85219	RENIDSSRRADVYIPRGG	Q9M4R4_ELAGV	298	298
1785854	85219	KHNINDPERADFFNPRAG	B9N2L3_POPTR	320	320
1785855	85219	KHNINDPERADFFNPRAG	B9N2L4_POPTR	319	319
1785856	85219	SENIGLPQEADVFNPRAG	P93079_COFAR	313	313
1785857	85219	RHNIDRPSQADIFNPRGG	A1E0V3_FICAW	332	332
1785858	85219	KENIADPSRADLFVPEVG	B9SF37_RICCO	304	304
1785859	85219	SENIGLPQEADVFNPRAG	O82437_COFAR	316	316
1785860	85219	SENIGLPQEADVFNPRAG	Q9ZNY2_COFAR	316	316
1785861	85219	KENIADPSRSDVFVPEVG	Q9M4Q8_RICCO	301	301
1785862	85219	KENIADPSRADIFVPEVG	B9SF36_RICCO	334	334
1785863	85219	KENIADPSRSDIFVPEVG	B9SDX6_RICCO	301	301
1785864	85219	RVNIENPNRADYYNPRAG	A2X2Z1_ORYSI	297	297
1785865	85219	RENLDEPARADVYNPHGG	Q9AUD2_SESIN	301	301
1785866	85219	RHNIDKPSHADVYNPRAG	Q39627_CITSI	311	311
1785867	85219	HENIARPSRADFYNPKAG	A3KEY8_GLYSO	352	352
1785868	85219	HENIARPSRADFYNPKAG	Q7GC77_SOYBN	356	356
1785869	85219	HENIARPSRADFYNPKAG	Q39922_GLYSO	356	356
1785870	85219	HENIARPSRADFYNPKAG	P93708_SOYBN	356	356
1785871	85219	HENIARPSRADFYNPKAG	P93707_SOYBN	356	356
1785872	85219	HENIARPSRADFYNPKAG	C0KG62_SOYBN	356	356
1785873	85219	RHNINKPSEADIYNPRAG	B9T5E7_RICCO	328	328
1785874	85219	KLNINDPSRADVYNPRGG	B2KN55_PISVE	299	299
1785875	85219	KLNINDPSRADVYNPRGG	B7P074_PISVE	299	299
1785876	85219	HENIARPSRADFYNPKAG	Q1WAB8_9FABA	386	386
1785877	85219	RHNIDRPSQADIFNPRGG	A1E0V6_FICAW	326	326
1785878	85219	RENIADAARADLYNPRAG	LEGJ_PEA	334	334
1785879	85219	RENIARPSRADLYNSRAG	Q43673_VICFA	395	395
1785880	85219	RQNVNRPSHADVFNPRAG	A9NJG2_FAGTA	332	332
1785881	85219	KENIADPSRADVYVPEVG	B9T1B8_RICCO	289	289
1785882	85219	RENIAQPARADLYNPRAG	LEGB4_VICFA	315	315
1785883	85219	KYNINDPSRADVYNPRGG	B7P073_PISVE	308	308
1785884	85219	IQNIDNPAEADFYNPRAG	Q84ND2_BEREX	291	291
1785885	85219	RVNIENPSRADYYNPRAG	Q6K508_ORYSJ	297	297
1785886	85219	KQNIGRSVRADVFNPRGG	11SB_CUCMA	308	308
1785887	85219	HENIARPSRADFYNPKAG	Q9SB12_SOYBN	356	356
1785888	85219	RVNIENPSRADYYNPRAG	Q6T726_ORYSJ	297	297
1785889	85219	RENIARPSRGDLYNSGAG	O24294_PEA	401	401
1785890	85219	RKNIDNPQSSDIFNPHGG	B8AH66_ORYSI	309	309
1785891	85219	RKNIDNPQSSDIFNPHGG	Q9ZWJ8_ORYSA	330	330
1785892	85219	RKNIDNPQSSDIFNPHGG	Q6K7K6_ORYSJ	330	330
1785893	85219	RKNIDNPQSSDIFNPHGG	B9EZT3_ORYSJ	309	309
1785894	85219	KQNVNRPSRADVFNPRAG	13S1_FAGES	389	389
1785895	85219	HENIARPSRADFYNPKAG	GLYG5_SOYBN	356	356
1785896	85219	KENIGNPERADIFSPRAG	Q43607_PRUDU	379	379
1785897	85219	RQNVNRPSRADVFNPRAG	13S3_FAGES	359	359
1785898	85219	AVNVDDPSKADVYTPEAG	A2I9A6_AMAHP	310	310
1785899	85219	RHNINKPSEADIYNPRAG	B9S9Q7_RICCO	216	216
1785900	85219	HENIDDPARADIYKPNLG	Q2TLW0_SINAL	332	332
1785901	85219	HENIDDPARADVYKPNLG	Q9AXL9_BRANA	311	311
1785902	85219	RENIADPSRADIFVPEVG	B9SF35_RICCO	302	302
1785903	85219	KHSINNPSQADIYNPRAG	B9T5E6_RICCO	224	224
1785904	85219	HENIDDPARADVYKPNLG	CRU1_RAPSA	301	301
1785905	85219	HENIDDPARADVYKPNLG	CRU3_BRANA	331	331
1785906	85219	TDNLDDPSNADVYKPQLG	CRU1_BRANA	312	312
1785907	85219	TDNLDDPSNADVYKPQLG	CRUA_BRANA	310	310
1785908	85219	HENIADPSHADIFNPRAG	Q3HW60_SOYBN	359	359
1785909	85219	HENIADPSHADIFNPRAG	Q9FEC5_SOYBN	359	359
1785910	85219	HENIADPSHADIFNPRAG	Q6DR94_SOYBN	359	359
1785911	85219	HENIDDPARADIYKPNLG	Q2TLV9_SINAL	345	345
1785912	85219	TDNLDDPSNADVYKPQLG	CRU2_BRANA	318	318
1785913	85219	HENIDDPARADVYKPSLG	Q8RX74_ARATH	345	345
1785914	85219	HENIDDPARADVYKPSLG	Q96318_ARATH	345	345
1785915	85219	KMNIGKSTSADIYNPQAG	AHY3_ARAHY	310	310
1785916	85219	TENLDDPSDADVYKPSLG	12S2_ARATH	281	281
1785917	85219	TENLDDPSDADVYKPSLG	Q56WH8_ARATH	4	4
1785918	85219	KENLADPERADIFNPQAG	LEGA_GOSHI	336	336
1785919	85219	TENLDDPSSADVYKPSLG	CRU4_BRANA	288	288
1785920	85219	RENLANPERADVYTARGG	C0ILQ2_COFCA	217	217
1785921	85219	KKNIGRNRSPDIYNPQAG	Q647H4_ARAHY	363	363
1785922	85219	KKNIGRNRSPDIYNPQAG	Q6T2T4_ARAHY	363	363
1785923	85219	TDNLDDPSRADVYKPQLG	12S1_ARATH	294	294
1785924	85219	RRNFNTPTNTYVFNPRAG	13S2_FAGES	325	325
1785925	85219	RQNIGQNSSPDIYNPQAG	GLYG2_SOYBN	312	312
1785926	85219	RQNIGQNSSPDIYNPQAG	Q549Z4_SOYBN	312	312
1785927	85219	KKNIGRNRSPDIYNPQAG	B5TYU1_ARAHY	357	357
1785928	85219	KKNIGRNRSPDIYNPQAG	Q5I6T2_ARAHY	357	357
1785929	85219	KKNIGRNRSPDIYNPQAG	A1DZF0_ARAHY	356	356
1785930	85219	RHNIGQTSSPDIFNPQAG	GLYG3_SOYBN	308	308
1785931	85219	RHNIGQTSSPDIFNPQAG	Q852U5_SOYBN	308	308
1785932	85219	KKNIGRNRSPDIYNPQAG	Q8LKN1_ARAHY	363	363
1785933	85219	KKNIGRNRSPDIYNPQAG	Q647H3_ARAHY	364	364
1785934	85219	RHNIGQTSSPDIFNPQAG	Q852U4_SOYBN	309	309
1785935	85219	RHNIGQTSSPDIYNPQAG	GLYG1_SOYBN	322	322
1785936	85219	RENIEHTAATHSYNPRGG	Q2XSW7_SESIN	319	319
1785937	85219	RLNIGPSSSPDIYNPEAG	LEGA2_PEA	347	347
1785938	85219	RLNIGPSSSPDIYNPEAG	Q9T0P5_PEA	344	344
1785939	85219	RLNIGPSSSPDIYNPEAG	LEGA_PEA	344	344
1785940	85219	KKNIGRNRSPDIYNPQAG	Q9FZ11_ARAHY	356	356
1785941	85219	KVNIGNPIHADVYSREGG	P93559_SAGSA	404	404
1785942	85219	HENIDDPERSDHFSTRAG	Q9ZWA9_ARATH	282	282
1785943	85219	RHSVERLDQADVYSPGAG	C5YY38_SORBI	303	303
1785944	85219	RLNIGSSSSPDIYNPQAG	Q99304_VICFA	327	327
1785945	85219	RVNIGSSPSPDIYNPQAG	Q41676_VICNA	309	309
1785946	85219	KKNLGRSSNPDIYNPQAG	Q0GM57_ARAHY	338	338
1785947	85219	RANIGSSPSPDIYNPQAG	Q41702_VICSA	325	325
1785948	85219	EYNINDPSQADTYNPNAG	B9SW16_RICCO	310	310
1785949	85219	RENVADPMKADLYTPNGG	A2YQV0_ORYSI	338	338
1785950	85219	QSNVGDPRKADVYSRDGG	P93560_SAGSA	618	618
1785951	85219	RHSVERLDQADVYSPGAG	Q946V2_MAIZE	302	302
1785952	85219	RHSVERLDQADAYSPGAG	Q948J8_MAIZE	301	301
1785953	85219	NMYLDNPKEADVYSRQAG	Q38698_ASAEU	290	290
1785954	85219	RENVADPMKADLYTPNGG	A3BP99_ORYSJ	337	337
1785955	85219	RENVADPMKADLYTPNGG	Q6ZK46_ORYSJ	342	342
1785956	85219	RMNIGKSSSPDIFNPQAG	B5U8K6_LOTJA	302	302
1785957	85219	RHNIGESTSPDAYNPQAG	Q53I54_LUPAL	339	339
1785958	85219	NHYMDNPREADIYSRQAG	Q40348_MAGSL	302	302
1785959	85219	RHNADDSEDADVYVRNGG	Q39770_GINBI	285	285
1785960	85219	RHNADNPEDADVFVRDGG	O04689_METGY	326	326
1785961	85219	KHNADNPEDADVYVRDGG	Q40870_PICGL	323	323
1785962	85219	RHNADRPDDADVFVRDGG	Q39521_CRYJA	337	337
1785963	85219	RHNADRPDDADIFVRDGG	O04691_METGY	328	328
1785964	85219	KHNADNPEDADIYVRDGG	Q40933_PSEMZ	327	327
1785965	85219	NQYLDNPREADVYSRQAG	Q38697_ASAEU	287	287
1785966	85219	KQNIELQRETDVYTKQGG	B9H8M2_POPTR	291	291
1785967	85219	RQSLNRADNADIYVRGAG	Q39775_GNEGN	380	380
1785968	85220	NSQKFPILNLIQMSATRVNLY	A1YQH4_ORYSJ	333	5
1785969	85220	NSQKFPILNLIQMSATRVNLY	Q0E2D5_ORYSJ	333	5
1785970	85220	NSQKFPILNLIQMSATRVNLY	Q0E2D2_ORYSJ	337	5
1785971	85220	NSQKFPILNLIQMSATRVNLY	GLUB2_ORYSJ	333	5
1785972	85220	NSQKFPILNLIQMSATRVNLY	GLUB1_ORYSJ	337	5
1785973	85220	NSQKFPILNLIQMSATRVNLY	B9F4T3_ORYSJ	315	5
1785974	85220	NSQKFPILNLIQMSATRVNLY	B9F4T2_ORYSJ	97	5
1785975	85220	NSQKFPILNLIQMSATRVNLY	B9F4T1_ORYSJ	311	5
1785976	85220	NSQKFPILNLIQMSATRVNLY	B8AEZ5_ORYSI	315	5
1785977	85220	NSQKFPILNLIQMSATRVNLY	A2X301_ORYSI	224	5
1785978	85220	NSQKFPILNLIQMSATRVNLY	A1YQH6_ORYSJ	333	5
1785979	85220	NSQKFPILNLIQMSATRVNLY	A1YQH5_ORYSJ	333	5
1785980	85220	NSHNLPILRWLQLSAERGALY	B5KVH4_CARIL	351	5
1785981	85220	NSHNLPILRWLQLSAERGALY	B5KVH5_CARIL	351	5
1785982	85220	NSQNFPILNLVQMSAVKVNLY	A1YQG3_ORYSJ	341	5
1785983	85220	NSQNFPILNLVQMSAVKVNLY	GLUA2_ORYSJ	341	5
1785984	85220	NSQNFPILNLVQMSAVKVNLY	A2Z708_ORYSI	341	5
1785985	85220	NSQKFPILNLIQMSATRVNLY	A2X2Z8_ORYSI	276	5
1785986	85220	NSQKFPILNLVQLSATRVNLY	A2X399_ORYSI	338	5
1785987	85220	NSQKFPILNLVQLSATRVNLY	Q0E262_ORYSJ	338	5
1785988	85220	NSQKFPILNLVQLSATRVNLY	Q0E261_ORYSJ	338	5
1785989	85220	NSQKFPILNLVQLSATRVNLY	GLUB5_ORYSJ	338	5
1785990	85220	NSQKFPILNLVQLSATRVNLY	GLUB4_ORYSJ	338	5
1785991	85220	NSQKFPILNLVQLSATRVNLY	A2X3A0_ORYSI	157	5
1785992	85220	NSHTLPVLRWLQLSAERGALY	Q2TPW5_9ROSI	350	5
1785993	85220	NTQNFPILNLVQMSAVKVNLY	A2WVB9_ORYSI	341	5
1785994	85220	NTQNFPILSLVQMSAVKVNLY	A1YQG5_ORYSJ	341	5
1785995	85220	NTQNFPILSLVQMSAVKVNLY	Q0JJ36_ORYSJ	341	5
1785996	85220	NTQNFPILSLVQMSAVKVNLY	GLUA1_ORYSJ	341	5
1785997	85220	NSQKFPILNLIQMSAVKVNLY	Q0Z945_9ORYZ	342	5
1785998	85220	NSQKFSILNLVQMSATRVNLY	A2X2V1_ORYSI	334	5
1785999	85220	NSQKFSILNLVQMSATRVNLY	Q84X94_ORYSJ	334	5
1786000	85220	NSKNFPILNIVQMSATRVNLY	Q38780_AVESA	360	5
1786001	85220	NSQKFPILNVLQLSAERGVLY	Q40347_MAGSL	323	5
1786002	85220	NSHNLPILRYIQLSAERGVLY	B9GS11_POPTR	328	5
1786003	85220	NSQKFSILNLVQMSATRVNLY	C0L8H1_ORYSJ	333	5
1786004	85220	NSQKFSILNLVQMSATRVNLY	Q84X93_ORYSJ	334	5
1786005	85220	NSQKFSILNLVQMSATRVNLY	Q6ESW6_ORYSJ	334	5
1786006	85220	NSKNFPTLNLVQMSATRVNLY	SSG2_AVESA	352	5
1786007	85220	NTQNFPILNLVQMSAVKVNLY	Q40689_ORYSA	341	5
1786008	85220	NSHNLPILRYIQLSAERGVLY	B9H8M5_POPTR	328	5
1786009	85220	NNQKFPILNLIQMSAVKVNLY	Q0Z870_9ORYZ	350	5
1786010	85220	NSKNFPILNIVQMSATRVNLY	Q38779_AVESA	384	5
1786011	85220	NSHNLPVLRWLQLSAEFGRLQ	Q41128_QUERO	333	5
1786012	85220	NSNTLPVLRWLQLSAERGDLQ	Q8W1C2_CORAV	355	5
1786013	85220	HGQNFPILNLVQMSATRVNLY	O49258_AVESA	348	5
1786014	85220	NGQKFPILNLVQMSAVKVNLY	B8AKE2_ORYSI	340	5
1786015	85220	NGQKFPILNLVQMSAVKVNLY	Q10JA8_ORYSJ	340	5
1786016	85220	NGQKFPILNLVQMSAVKVNLY	GLUA3_ORYSJ	340	5
1786017	85220	NGQKFPILNLVQMSAVKVNLY	B9F952_ORYSJ	340	5
1786018	85220	NSHNLPILRWLQLSAEFGRLQ	Q8LK20_CASCR	388	5
1786019	85220	NSKNFPTLNLVQMSATRVNLY	SSG1_AVESA	352	5
1786020	85220	NSFNLPILRHLRLSAERGVLY	A1E0V5_FICAW	357	5
1786021	85220	NSYNLPILNWLQLSAERGFLY	A1E0V7_FICAW	343	5
1786022	85220	NSLNLPILKWLQLSAERGVLQ	B7SLJ1_PISVE	322	5
1786023	85220	NSFNLPILRHLRLSAERGVLY	A1E0V4_FICAW	359	5
1786024	85220	NSLTLPILSFLQLSAARGVLY	Q2XSW6_SESIN	316	5
1786025	85220	NSYNLPILNWLQLSAERGFLY	A1E0V8_FICAW	337	5
1786026	85220	DSQKFPILNIIQMSATRVNLY	B8AEZ0_ORYSI	311	5
1786027	85220	DSQKFPILNIIQMSATRVNLY	A3A527_ORYSJ	311	5
1786028	85220	DSQKFPILNIIQMSATRVNLY	Q6T725_ORYSJ	333	5
1786029	85220	NSFNLPILSNLRLSAEKGVLY	Q06AW1_CHEQI	326	5
1786030	85220	NSFNLPILSNLRLSAEKGVLY	Q6Q384_CHEQI	326	5
1786031	85220	NSQTFPILNIVQMSATRVHLY	B2CGM6_WHEAT	417	5
1786032	85220	HGQNFPILNLVQMSATRVNLY	O49257_AVESA	305	5
1786033	85220	NSLTLPILRFLGLSAEYVNLY	B5U8K2_LOTJA	460	5
1786034	85220	NSLTLPILRFLGLSAEYVNLY	B5U8K1_LOTJA	429	5
1786035	85220	NSLTLPALRQFQLSAQYVVLY	A3KEY9_GLYSO	413	5
1786036	85220	NSLTLPALRQFQLSAQYVVLY	Q9SB11_SOYBN	413	5
1786037	85220	NSLTLPALRQFQLSAQYVVLY	Q9S9D0_SOYBN	413	5
1786038	85220	NSLTLPALRQFQLSAQYVVLY	Q43452_SOYBN	412	5
1786039	85220	NSLTLPALRQFQLSAQYVVLY	Q39921_GLYSO	413	5
1786040	85220	NSLTLPALRQFQLSAQYVVLY	GLYG4_SOYBN	412	5
1786041	85220	NSFNLPILNYLRLSAEKGVLY	A0EM47_ACTCH	313	5
1786042	85220	NSQTFPILNIVQMSATRVHLY	B2CGM5_WHEAT	417	5
1786043	85220	NSFNLPILSNLRLSAEKGVLY	Q06AW2_CHEQI	327	5
1786044	85220	NSFNLPILSNLRLSAEKGVLY	Q6Q385_CHEQI	327	5
1786045	85220	NSLNLPILRHVQLSAERGVLY	B9N2L2_POPTR	315	5
1786046	85220	NSLNLPILRHVQLSAERGVLY	B9P6C0_POPTR	345	5
1786047	85220	NSLTLPILGWFQLSAEYVNLC	C9WC98_LUPAN	342	5
1786048	85220	NSQKLPALRSLQMSAERGFLY	13SB_FAGES	35	5
1786049	85220	NSLTLPILRYLRLSAEYVRLY	Q41703_VICSA	339	5
1786050	85220	NSQKLPMLSFIQLSAERVVLY	Q9M4R4_ELAGV	321	5
1786051	85220	NSLNLPILRSVQLSVERGVLY	B9N2L3_POPTR	343	5
1786052	85220	NSLNLPILRSVQLSVERGVLY	B9N2L4_POPTR	342	5
1786053	85220	NSQKIPILSSLQLSAERGFLY	P93079_COFAR	336	5
1786054	85220	NNFNLPILRFLRLTAERGVLY	A1E0V3_FICAW	355	5
1786055	85220	NSHNLPILRSLRLSASHVVLR	B9SF37_RICCO	327	5
1786056	85220	NSQKIPILSSLQLSAERGFLY	O82437_COFAR	339	5
1786057	85220	NSQKIPILSSLQLSAERGFLY	Q9ZNY2_COFAR	339	5
1786058	85220	NSHNLPILRWLQLSASHVVLR	Q9M4Q8_RICCO	324	5
1786059	85220	NSHNLPILRSLRLSASHVVLR	B9SF36_RICCO	357	5
1786060	85220	NSHNLPILRWLQLSASHVVLR	B9SDX6_RICCO	324	5
1786061	85220	NNQKFPILNLIGMGAARVNLY	A2X2Z1_ORYSI	320	5
1786062	85220	NSLTLPVLSWLRLSAEKGVLY	Q9AUD2_SESIN	324	5
1786063	85220	NRFNLPILRDLQLSAEKGNLY	Q39627_CITSI	334	5
1786064	85220	NSLTLPALRQFGLSAQYVVLY	A3KEY8_GLYSO	375	5
1786065	85220	NSLTLPALRQFGLSAQYVVLY	Q7GC77_SOYBN	379	5
1786066	85220	NSLTLPALRQFGLSAQYVVLY	Q39922_GLYSO	379	5
1786067	85220	NSLTLPALRQFGLSAQYVVLY	P93708_SOYBN	379	5
1786068	85220	NSLTLPALRQFGLSAQYVVLY	P93707_SOYBN	379	5
1786069	85220	NSLTLPALRQFGLSAQYVVLY	C0KG62_SOYBN	379	5
1786070	85220	NSHNLPILRYLQLSIQKAVLY	B9T5E7_RICCO	351	5
1786071	85220	NALNLPILRFLQLSVEKGVLY	B2KN55_PISVE	322	5
1786072	85220	NALNLPILRFLQLSVEKGVLY	B7P074_PISVE	322	5
1786073	85220	NSLTLPALRQFGFSAQYVVLY	Q1WAB8_9FABA	409	5
1786074	85220	NNFNLPILRFLRLTAERGVLY	A1E0V6_FICAW	349	5
1786075	85220	NSLTLPVLRYLRLSAEYVRLY	LEGJ_PEA	357	5
1786076	85220	NSLTLPILRNLRLSAEYVLLY	Q43673_VICFA	418	5
1786077	85220	NSNNLPILEFLQLSAQHVVLY	A9NJG2_FAGTA	355	5
1786078	85220	NSNNLRILRLLQLSASHVSLS	B9T1B8_RICCO	312	5
1786079	85220	NSLTLPILRYLRLSAEYVRLY	LEGB4_VICFA	338	5
1786080	85220	NALNLPILRFLQLSAKKGVLH	B7P073_PISVE	331	5
1786081	85220	NSLKVPILTFLQLSAMKGVLY	Q84ND2_BEREX	314	5
1786082	85220	NNQKFPILNLIGMGAARVNLY	Q6K508_ORYSJ	320	5
1786083	85220	NYHTLPILRQVRLSAERGVLY	11SB_CUCMA	331	5
1786084	85220	NSLTLPALRQFGLSAQYVVLY	Q9SB12_SOYBN	379	5
1786085	85220	NNQRFPILNLIGMGAARVNLY	Q6T726_ORYSJ	320	5
1786086	85220	NSLTLPILRNLRLSAEYVLLY	O24294_PEA	424	5
1786087	85220	NSQNFPILNIIQMSATRIVLQ	B8AH66_ORYSI	332	5
1786088	85220	NSQNFPILNIIQMSATRIVLQ	Q9ZWJ8_ORYSA	353	5
1786089	85220	NSQNFPILNIIQMSATRIVLQ	Q6K7K6_ORYSJ	353	5
1786090	85220	NSQNFPILNIIQMSATRIVLQ	B9EZT3_ORYSJ	332	5
1786091	85220	NSNNLPILEFIQLSAQHVVLY	13S1_FAGES	412	5
1786092	85220	NSLTLPALRQFGLSAQYVVLY	GLYG5_SOYBN	379	5
1786093	85220	NSHNLPILRFLRLSAERGFFY	Q43607_PRUDU	402	5
1786094	85220	DSNNLPILEFIQLSAQHVVLY	13S3_FAGES	382	5
1786095	85220	NSFNLPILRHLRLSAAKGVLY	A2I9A6_AMAHP	333	5
1786096	85220	NSHYLPILRFLQLSIQKAVLY	B9S9Q7_RICCO	239	5
1786097	85220	NSYTLPILQYIRLSATRGILQ	Q2TLW0_SINAL	355	5
1786098	85220	NSYTLPILQYIRLSATRGILQ	Q9AXL9_BRANA	334	5
1786099	85220	NSHSLPILRWLKLSASHAVLR	B9SF35_RICCO	325	5
1786100	85220	NNHNFPILRYLQLSIQKAVLY	B9T5E6_RICCO	247	5
1786101	85220	NSYTLPILQYIRLSATRGILQ	CRU1_RAPSA	324	5
1786102	85220	NSYTLPILQYIRLSATRGILQ	CRU3_BRANA	354	5
1786103	85220	NSYDLPILRFLRLSALRGSIR	CRU1_BRANA	335	5
1786104	85220	NSYDLPILRFLRLSALRGSIR	CRUA_BRANA	333	5
1786105	85220	NSLTLPVLKLLRLSAQWVKLY	Q3HW60_SOYBN	382	5
1786106	85220	NSLTLPVLKLLRLSAQWVKLY	Q9FEC5_SOYBN	382	5
1786107	85220	NSLTLPVLKLLRLSAQWVKLY	Q6DR94_SOYBN	382	5
1786108	85220	NSYTIPILQYIRLSATRGILQ	Q2TLV9_SINAL	368	5
1786109	85220	NSYDLPILRVLRLSALRGSIR	CRU2_BRANA	341	5
1786110	85220	NSYTLPILEYVRLSATRGVLQ	Q8RX74_ARATH	368	5
1786111	85220	NSYTLPILEYVRLSATRGVLQ	Q96318_ARATH	368	5
1786112	85220	NELDLPILNRLGLSAEYGSIH	AHY3_ARAHY	333	5
1786113	85220	NSYNLPILRLLRLSALRGSIR	12S2_ARATH	304	5
1786114	85220	NSYNLPILRLLRLSALRGSIR	Q56WH8_ARATH	27	5
1786115	85220	NRFNLPILQRLELSAERGVLY	LEGA_GOSHI	359	5
1786116	85220	NSYNLPILRFLRLSALRGSIH	CRU4_BRANA	311	5
1786117	85220	NSMNLPILKYLQLSAGRGFLR	C0ILQ2_COFCA	240	5
1786118	85220	NELNLLILRWLGLSAEYGNLY	Q647H4_ARAHY	386	5
1786119	85220	NELNLLILRWLGLSAEYGNLY	Q6T2T4_ARAHY	386	5
1786120	85220	NSYDLPILRFIRLSALRGSIR	12S1_ARATH	317	5
1786121	85220	NSNSLPILEFLQLSAQHVVLY	13S2_FAGES	348	5
1786122	85220	TSLDFPALWLLKLSAQYGSLR	GLYG2_SOYBN	335	5
1786123	85220	TSLDFPALWLLKLSAQYGSLR	Q549Z4_SOYBN	335	5
1786124	85220	NELNLLILRWLGLSAEYGNLY	B5TYU1_ARAHY	380	5
1786125	85220	NDLNLLILRWLGLSAEYGNLY	Q5I6T2_ARAHY	380	5
1786126	85220	NELNLLILRWLGLSAEYGNLY	A1DZF0_ARAHY	379	5
1786127	85220	TSLDFPALSWLKLSAQFGSLR	GLYG3_SOYBN	331	5
1786128	85220	TSLDFPALSWLKLSAQFGSLR	Q852U5_SOYBN	331	5
1786129	85220	LQLNLLILRWLGLSAEYGNLY	Q8LKN1_ARAHY	388	7
1786130	85220	NDLNLLILRWLGLSAEYGNLY	Q647H3_ARAHY	387	5
1786131	85220	TSLDFPALSWLKLSAQFGSLR	Q852U4_SOYBN	332	5
1786132	85220	TSLDFPALSWLRLSAEFGSLR	GLYG1_SOYBN	345	5
1786133	85220	NSQTLPILSQLRLSAEKGVLY	Q2XSW7_SESIN	342	5
1786134	85220	TSLDLPVLRWLKLSAEHGSLH	LEGA2_PEA	370	5
1786135	85220	TSLDLPVLRWLKLSAEHGSLH	Q9T0P5_PEA	367	5
1786136	85220	TSLDLPVLRWLKLSAEHGSLH	LEGA_PEA	367	5
1786137	85220	NDLNLLILRWLGLSAEYGNLY	Q9FZ11_ARAHY	379	5
1786138	85220	NSFKLPILSYLQLTVEKGHLR	P93559_SAGSA	427	5
1786139	85220	NSLNLPVLRLVRLNALRGYLY	Q9ZWA9_ARATH	305	5
1786140	85220	TSHKFPILNLIQMSAVRVDLY	C5YY38_SORBI	326	5
1786141	85220	TSLDLPVLRWLKLSAEHGSLR	Q99304_VICFA	350	5
1786142	85220	TSLDLPVLRWLKLSAEHGSLR	Q41676_VICNA	332	5
1786143	85220	NELDLPILGWLGLSAQHGTIY	Q0GM57_ARAHY	361	5
1786144	85220	TSLDLPVLRWLKLSAEHGSLH	Q41702_VICSA	348	5
1786145	85220	NSNSLPILAYLRLSVQKGILY	B9SW16_RICCO	333	5
1786146	85220	NSQKLPVLKLIKMSVNRGVMR	A2YQV0_ORYSI	361	5
1786147	85220	NSFKLPILSYLQLTFEKGQLR	P93560_SAGSA	641	5
1786148	85220	TSHKFPVLNLVQMSAVRVDLY	Q946V2_MAIZE	325	5
1786149	85220	TSHKFPVLNLVQMSAVRVDLY	Q948J8_MAIZE	324	5
1786150	85220	NMNKLPILRYMQMSAEKGNLY	Q38698_ASAEU	313	5
1786151	85220	NSQKLPVLKLIKMSVNRGVMR	A3BP99_ORYSJ	360	5
1786152	85220	NSQKLPVLKLIKMSVNRGVMR	Q6ZK46_ORYSJ	365	5
1786153	85220	TGFDFPALRFLKLSAEHGSLN	B5U8K6_LOTJA	325	5
1786154	85220	TSIDFPILGWLGLAAEHGSIY	Q53I54_LUPAL	362	5
1786155	85220	NMNKLPILRMLGMSSEKGYLY	Q40348_MAGSL	325	5
1786156	85220	NRLKLPALRSLRLGAERGILQ	Q39770_GINBI	308	5
1786157	85220	NRFKLHALTHLNLAAERGVLR	O04689_METGY	349	5
1786158	85220	NRFKLPVLKYLRLGAERVVLH	Q40870_PICGL	346	5
1786159	85220	NRFKLPALTHLNLAAERGVLR	Q39521_CRYJA	360	5
1786160	85220	NRFKLHALTHLNLAAERGVLR	O04691_METGY	351	5
1786161	85220	NRFKLPVLKYLGLGAERVILR	Q40933_PSEMZ	350	5
1786162	85220	NMKKLPILRYLEMRDEKGSLY	Q38697_ASAEU	310	5
1786163	85220	NQQKLPILQFIDMSAERGHLM	B9H8M2_POPTR	314	5
1786164	85220	NALKMPALQVVGLAADYVKLE	Q39775_GNEGN	403	5
1786165	85221	VQVVSNFGKTVFDGVLR	A1YQH4_ORYSJ	379	25
1786166	85221	VQVVSNFGKTVFDGVLR	Q0E2D5_ORYSJ	379	25
1786167	85221	VQVVSNFGKTVFDGVLR	Q0E2D2_ORYSJ	383	25
1786168	85221	VQVVSNFGKTVFDGVLR	GLUB2_ORYSJ	379	25
1786169	85221	VQVVSNFGKTVFDGVLR	GLUB1_ORYSJ	383	25
1786170	85221	VQVVSNFGKTVFDGVLR	B9F4T3_ORYSJ	361	25
1786171	85221	VQVVSNFGKTVFDGVLR	B9F4T2_ORYSJ	143	25
1786172	85221	VQVVSNFGKTVFDGVLR	B9F4T1_ORYSJ	357	25
1786173	85221	VQVVSNFGKTVFDGVLR	B8AEZ5_ORYSI	361	25
1786174	85221	VQVVSNFGKTVFDGVLR	A2X301_ORYSI	270	25
1786175	85221	VQVVSNFGKTVFDGVLR	A1YQH6_ORYSJ	379	25
1786176	85221	VQVVSNFGKTVFDGVLR	A1YQH5_ORYSJ	379	25
1786177	85221	VQVVDNFGQTVFDDELR	B5KVH4_CARIL	397	25
1786178	85221	VQVVDNFGQTVFDDELR	B5KVH5_CARIL	397	25
1786179	85221	VQVVNNNGKTVFNGELR	A1YQG3_ORYSJ	387	25
1786180	85221	VQVVNNNGKTVFNGELR	GLUA2_ORYSJ	387	25
1786181	85221	VQVVNNNGKTVFNGELR	A2Z708_ORYSI	387	25
1786182	85221	VQVVSNFGKTVFDGVLR	A2X2Z8_ORYSI	322	25
1786183	85221	VQVVSNLGKTVFNGVLR	A2X399_ORYSI	384	25
1786184	85221	VQVVSNLGKTVFNGVLR	Q0E262_ORYSJ	384	25
1786185	85221	VQVVSNLGKTVFNGVLR	Q0E261_ORYSJ	384	25
1786186	85221	VQVVSNLGKTVFNGVLR	GLUB5_ORYSJ	384	25
1786187	85221	VQVVSNLGKTVFNGVLR	GLUB4_ORYSJ	384	25
1786188	85221	VQVVSNLGKTVFNGVLR	A2X3A0_ORYSI	203	25
1786189	85221	VQVVDNFGQTVFDDELR	Q2TPW5_9ROSI	396	25
1786190	85221	VQVVNNNGKTVFNGELR	A2WVB9_ORYSI	387	25
1786191	85221	VQVVNNNGKTVFNGELR	A1YQG5_ORYSJ	387	25
1786192	85221	VQVVNNNGKTVFNGELR	Q0JJ36_ORYSJ	387	25
1786193	85221	VQVVNNNGKTVFNGELR	GLUA1_ORYSJ	387	25
1786194	85221	VQVVNNNGKTVFNGELR	Q0Z945_9ORYZ	388	25
1786195	85221	VQVVSNHGKAVFNGVLR	A2X2V1_ORYSI	380	25
1786196	85221	VQVVSNHGKAVFNGVLR	Q84X94_ORYSJ	380	25
1786197	85221	VQVVNNNGQTVFNDILR	Q38780_AVESA	406	25
1786198	85221	VQIVGEQGRPVFDGELR	Q40347_MAGSL	369	25
1786199	85221	IQVVDHSGRTVFDGEMR	B9GS11_POPTR	374	25
1786200	85221	VQVVSNHGKAVFNGVLR	C0L8H1_ORYSJ	379	25
1786201	85221	VQVVSNHGKAVFNGVLR	Q84X93_ORYSJ	380	25
1786202	85221	VQVVSNHGKAVFNGVLR	Q6ESW6_ORYSJ	380	25
1786203	85221	VQVVNNHGQTVFNDILR	SSG2_AVESA	398	25
1786204	85221	VQVVNNNGKTVFNGEPR	Q40689_ORYSA	387	25
1786205	85221	VQVVDHSGRTVFDGEMR	B9H8M5_POPTR	374	25
1786206	85221	VQVVNNNGKTVFNGELR	Q0Z870_9ORYZ	396	25
1786207	85221	VQVVNNNGQTVFSDILH	Q38779_AVESA	430	25
1786208	85221	VQVVDDFGQTVFQDELQ	Q41128_QUERO	379	25
1786209	85221	VQVVDDNGNTVFDDELR	Q8W1C2_CORAV	401	25
1786210	85221	VQVVNNNGQTVFNDRLR	O49258_AVESA	394	25
1786211	85221	VQVVNNNGKTVFDGELR	B8AKE2_ORYSI	386	25
1786212	85221	VQVVNNNGKTVFDGELR	Q10JA8_ORYSJ	386	25
1786213	85221	VQVVNNNGKTVFDGELR	GLUA3_ORYSJ	386	25
1786214	85221	VQVVNNNGKTVFDGELR	B9F952_ORYSJ	386	25
1786215	85221	VQVVDNFGLTVFDDELQ	Q8LK20_CASCR	434	25
1786216	85221	VQVVNNHGQTVFNDILR	SSG1_AVESA	398	25
1786217	85221	IQVVDHFGQAFFDGEVR	A1E0V5_FICAW	403	25
1786218	85221	CQVVNSFGQTVFDGELR	A1E0V7_FICAW	389	25
1786219	85221	VQVVDNFGNTVFDGEVS	B7SLJ1_PISVE	368	25
1786220	85221	IQVVDHFGQAFFDGEVR	A1E0V4_FICAW	405	25
1786221	85221	MQIVSHNGQAVFDGRVR	Q2XSW6_SESIN	362	25
1786222	85221	CQVVDDFGRTVFDGHLR	A1E0V8_FICAW	383	25
1786223	85221	VQVVSNLGKTVFDGVLR	B8AEZ0_ORYSI	357	25
1786224	85221	VQVVSNFGKTVFDGVLR	A3A527_ORYSJ	357	25
1786225	85221	VQVVSNFGKTVFDGVLR	Q6T725_ORYSJ	379	25
1786226	85221	IQIVNAQGNSVFDDELR	Q06AW1_CHEQI	372	25
1786227	85221	IQIVNAQGNSVFDDELR	Q6Q384_CHEQI	372	25
1786228	85221	VQVVNDHGRNVFNDLLS	B2CGM6_WHEAT	463	25
1786229	85221	VQVVNNNGQTVFNDRLR	O49257_AVESA	351	25
1786230	85221	VRIVNCQGQAVFNDELR	B5U8K2_LOTJA	506	25
1786231	85221	VRIVNCQGQAVFNDELR	B5U8K1_LOTJA	475	25
1786232	85221	VRVVNCQGNAVFDGELR	A3KEY9_GLYSO	459	25
1786233	85221	VRVVNCQGNAVFDGELR	Q9SB11_SOYBN	459	25
1786234	85221	VRVVNCQGNAVFDGELR	Q9S9D0_SOYBN	459	25
1786235	85221	VRVVNCQGNAVFDGELR	Q43452_SOYBN	458	25
1786236	85221	VRVVNCQGNAVFDGELR	Q39921_GLYSO	459	25
1786237	85221	VRVVNCQGNAVFDGELR	GLYG4_SOYBN	458	25
1786238	85221	MQIVDQRGEAVFNDRIR	A0EM47_ACTCH	359	25
1786239	85221	VQVVNDHGRNVFNDLLS	B2CGM5_WHEAT	463	25
1786240	85221	IQIVNAQGNSVFDDELR	Q06AW2_CHEQI	373	25
1786241	85221	IQIVNAQGNSVFDDELR	Q6Q385_CHEQI	373	25
1786242	85221	IQIVGDNGQAVFDGQVR	B9N2L2_POPTR	361	25
1786243	85221	IQIVGDNGQAVFDGQVR	B9P6C0_POPTR	391	25
1786244	85221	VQVVNSQGNSVFNDDLR	C9WC98_LUPAN	388	25
1786245	85221	VQVVGDEGNKVFDDEVK	13SB_FAGES	81	25
1786246	85221	VRIVNSQGNAVFDNKVR	Q41703_VICSA	385	25
1786247	85221	VQVVDNNGKTVFDGELR	Q9M4R4_ELAGV	367	25
1786248	85221	IQIVGDNGQTIFDGEVR	B9N2L3_POPTR	389	25
1786249	85221	IQIVGDNGQTIFDGEVR	B9N2L4_POPTR	388	25
1786250	85221	IQVVDHKGNKVFDDEVK	P93079_COFAR	382	25
1786251	85221	CQIVDDFGRTVFDGEVQ	A1E0V3_FICAW	401	25
1786252	85221	IQVVDENGNSVFDGNVR	B9SF37_RICCO	373	25
1786253	85221	IQVVDHKGNKVFDDEVK	O82437_COFAR	385	25
1786254	85221	IQVVDHKGNKVFDDEVK	Q9ZNY2_COFAR	385	25
1786255	85221	IQVVDENGNSVFDGNVR	Q9M4Q8_RICCO	370	25
1786256	85221	IQVVDENGRSVFDGNVR	B9SF36_RICCO	403	25
1786257	85221	IQVVDENGNSVFDGNVR	B9SDX6_RICCO	370	25
1786258	85221	VQVANNQGRTVFSGVLH	A2X2Z1_ORYSI	366	25
1786259	85221	FQVVGHTGRSVFDGVVR	Q9AUD2_SESIN	370	25
1786260	85221	MQIVAENGENVFDGQIR	Q39627_CITSI	380	25
1786261	85221	VRVVNCQGNAVFDGELR	A3KEY8_GLYSO	421	25
1786262	85221	VRVVNCQGNAVFDGELR	Q7GC77_SOYBN	425	25
1786263	85221	VRVVNCQGNAVFDGELR	Q39922_GLYSO	425	25
1786264	85221	VRVVNCQGNAVFDGELR	P93708_SOYBN	425	25
1786265	85221	VRVVNCQGNAVFDGELR	P93707_SOYBN	425	25
1786266	85221	VRVVNCQGNAVFDGELR	C0KG62_SOYBN	425	25
1786267	85221	VQIVNENGDSVFDGQVQ	B9T5E7_RICCO	397	25
1786268	85221	MQIVSENGESVFDEEIR	B2KN55_PISVE	368	25
1786269	85221	MQIVSENGESVFDEEIR	B7P074_PISVE	368	25
1786270	85221	VRVVNCQGNAVFNGKLR	Q1WAB8_9FABA	455	25
1786271	85221	CQIVDDFGRNVFDGEVQ	A1E0V6_FICAW	395	25
1786272	85221	VRIVNCQGNTVFDNKVR	LEGJ_PEA	403	25
1786273	85221	VRIVNSQGNPVFDDKVR	Q43673_VICFA	464	25
1786274	85221	VQVVGDEGKSVFDDNVQ	A9NJG2_FAGTA	401	25
1786275	85221	IQVVDENGNRVFDGNVK	B9T1B8_RICCO	358	25
1786276	85221	VRIVNSQGNAVFDNKVT	LEGB4_VICFA	384	25
1786277	85221	IQIVSENGESVFDEEIR	B7P073_PISVE	377	25
1786278	85221	VQIVDHRGETVFDDNLR	Q84ND2_BEREX	360	25
1786279	85221	VQVANNQGRSVFNGVLH	Q6K508_ORYSJ	366	25
1786280	85221	VQVVDNFGQSVFDGEVR	11SB_CUCMA	377	25
1786281	85221	VRVVNCQGNAVFDGELR	Q9SB12_SOYBN	425	25
1786282	85221	VQVANNQGRSVFNGVLH	Q6T726_ORYSJ	366	25
1786283	85221	VRIVNSEGNKVFDDKVS	O24294_PEA	470	25
1786284	85221	IQVVDHRGRSVFDGELH	B8AH66_ORYSI	378	25
1786285	85221	IQVVDHRGRSVFDGELH	Q9ZWJ8_ORYSA	399	25
1786286	85221	IQVVDHRGRSVFDGELH	Q6K7K6_ORYSJ	399	25
1786287	85221	IQVVDHRGRSVFDGELH	B9EZT3_ORYSJ	378	25
1786288	85221	VQVVGDEGRSVFDDNVQ	13S1_FAGES	458	25
1786289	85221	VRVVNCQGNAVFDGELR	GLYG5_SOYBN	424	24
1786290	85221	VQVVNENGDAILDQEVQ	Q43607_PRUDU	448	25
1786291	85221	VQVVGDEGRSVFDDNVQ	13S3_FAGES	428	25
1786292	85221	IQIVNDQGQSVFDEELS	A2I9A6_AMAHP	379	25
1786293	85221	VQIVNENGDSVFDGQVR	B9S9Q7_RICCO	285	25
1786294	85221	IQVVNDNGQNVLDQQVQ	Q2TLW0_SINAL	401	25
1786295	85221	IQVVNDNGQNVLDQQVQ	Q9AXL9_BRANA	380	25
1786296	85221	IQVVNENGNSVFDGSVR	B9SF35_RICCO	371	25
1786297	85221	IQIVNENGDSVFDGQVR	B9T5E6_RICCO	293	25
1786298	85221	IQVVNDNGQNVLDQQVQ	CRU1_RAPSA	370	25
1786299	85221	IQVVNDNGQNVLDQQVQ	CRU3_BRANA	400	25
1786300	85221	VQVVNDNGDRVFDGQVS	CRU1_BRANA	381	25
1786301	85221	VQVVNDNGDRVFDGQVS	CRUA_BRANA	379	25
1786302	85221	VQVVNSQGKSVFSGAVG	Q3HW60_SOYBN	428	25
1786303	85221	VQVVNSQGKSVFSGAVG	Q9FEC5_SOYBN	428	25
1786304	85221	VQVVNSQGKSVFSGAVG	Q6DR94_SOYBN	428	25
1786305	85221	IQVVNDNGQNVLDQQVQ	Q2TLV9_SINAL	414	25
1786306	85221	IQVVNDNGDRVFDGQVS	CRU2_BRANA	387	25
1786307	85221	IQVVNDNGQNVLDQQVQ	Q8RX74_ARATH	414	25
1786308	85221	IQVVNDNGQNVLDQQVQ	Q96318_ARATH	414	25
1786309	85221	VQVVDCNGNRVFDEELQ	AHY3_ARAHY	379	25
1786310	85221	IQMVNDNGERVFDQEIS	12S2_ARATH	350	25
1786311	85221	IQMVNDNGERVFDQEIS	Q56WH8_ARATH	73	25
1786312	85221	VQVVNHNGDAVFDDNVE	LEGA_GOSHI	405	25
1786313	85221	IQNVNDNGQRVFDQEIS	CRU4_BRANA	357	25
1786314	85221	VQIVGSSRRSVYDGEVR	C0ILQ2_COFCA	286	25
1786315	85221	VQVVDSNGDRVFDEELQ	Q647H4_ARAHY	432	25
1786316	85221	VQVVDSNGDRVFDEELQ	Q6T2T4_ARAHY	432	25
1786317	85221	IQIVNDNGNRVFDGQVS	12S1_ARATH	363	25
1786318	85221	VQVVGDEGKSVFDDKVQ	13S2_FAGES	394	25
1786319	85221	VQVVNCNGERVFDGELQ	GLYG2_SOYBN	381	25
1786320	85221	VQVVNCNGERVFDGELQ	Q549Z4_SOYBN	381	25
1786321	85221	VQVVDSNGNRVYDEELQ	B5TYU1_ARAHY	426	25
1786322	85221	VQVVDSNGNRVYDEELQ	Q5I6T2_ARAHY	426	25
1786323	85221	VQVVDSNGNRVYDEELQ	A1DZF0_ARAHY	425	25
1786324	85221	VQVVNCNGERVFDGELQ	GLYG3_SOYBN	377	25
1786325	85221	VQVVNCNGERVFDGELQ	Q852U5_SOYBN	377	25
1786326	85221	VQVVDSNGDRVFDEELQ	Q8LKN1_ARAHY	434	25
1786327	85221	VQVVDSNGNRVYDEELQ	Q647H3_ARAHY	433	25
1786328	85221	VQVVNCNGERVFDGELQ	Q852U4_SOYBN	378	25
1786329	85221	IQVVNCNGERVFDGELQ	GLYG1_SOYBN	391	25
1786330	85221	IQVVGHKGRSVLNEEVN	Q2XSW7_SESIN	388	25
1786331	85221	LQVVNCNGNTVFDGELE	LEGA2_PEA	416	25
1786332	85221	LQVVNCNGNTVFDGELE	Q9T0P5_PEA	413	25
1786333	85221	LQVVNCNGNTVFDGELE	LEGA_PEA	413	25
1786334	85221	VQVVDSNGNRVYDEELQ	Q9FZ11_ARAHY	425	25
1786335	85221	VQIVDNSGRAVFDDMVN	P93559_SAGSA	473	25
1786336	85221	IQVVDDNGQSVFNEQVG	Q9ZWA9_ARATH	351	25
1786337	85221	VQVASDNGTTVFDGVLR	C5YY38_SORBI	372	25
1786338	85221	LQVVNCNGNTVFDEELE	Q99304_VICFA	396	25
1786339	85221	LQVVNCNGNTVFDGELE	Q41676_VICNA	378	25
1786340	85221	VQVVDSNGNRVYDEELQ	Q0GM57_ARAHY	407	25
1786341	85221	LQVVNCNGNTVFDGELE	Q41702_VICSA	394	25
1786342	85221	VQIINDHGETMLDGQVR	B9SW16_RICCO	379	25
1786343	85221	LQVVSSEGRRVFDGELR	A2YQV0_ORYSI	407	25
1786344	85221	FQVVDQNGRTVHDDVVR	P93560_SAGSA	687	25
1786345	85221	VQVASDNGTTVFDDVLR	Q946V2_MAIZE	371	25
1786346	85221	VQVASDNGTTVFDDVLR	Q948J8_MAIZE	370	25
1786347	85221	VQAVGSNGNTVFNGRVN	Q38698_ASAEU	359	25
1786348	85221	LQVVSSEGRRVFDGELR	A3BP99_ORYSJ	406	25
1786349	85221	LQVVSSEGRRVFDGELR	Q6ZK46_ORYSJ	411	25
1786350	85221	IQVVNCKGNRIFDGELE	B5U8K6_LOTJA	371	25
1786351	85221	FQVVDCSGNAVFNGELN	Q53I54_LUPAL	408	25
1786352	85221	VQVVGHNGQTVLDDTVR	Q40348_MAGSL	371	25
1786353	85221	IQIVQNEGRRVFDGAVK	Q39770_GINBI	353	24
1786354	85221	IQVVENRGRRVFDGRVQ	O04689_METGY	394	24
1786355	85221	IEVVGDEGRSVFDGRVR	Q40870_PICGL	392	25
1786356	85221	IQVVENRGRRVFDGRVQ	Q39521_CRYJA	405	24
1786357	85221	IQVVENRGRRVFDGRLQ	O04691_METGY	396	24
1786358	85221	IEVVGEQGRSLFDGRVR	Q40933_PSEMZ	396	25
1786359	85221	VQVVGHDGEKVLDARVN	Q38697_ASAEU	356	25
1786360	85221	AQVVDERGNTIMNERVR	B9H8M2_POPTR	360	25
1786361	85221	IQIVDDKGRRVFSGEVR	Q39775_GNEGN	450	26
1786362	85222	GQLLIIPQHYAVLKKA	A1YQH4_ORYSJ	397	1
1786363	85222	GQLLIIPQHYAVLKKA	Q0E2D5_ORYSJ	397	1
1786364	85222	GQLLIIPQHYAVLKKA	Q0E2D2_ORYSJ	401	1
1786365	85222	GQLLIIPQHYAVLKKA	GLUB2_ORYSJ	397	1
1786366	85222	GQLLIIPQHYAVLKKA	GLUB1_ORYSJ	401	1
1786367	85222	GQLLIIPQHYAVLKKA	B9F4T3_ORYSJ	379	1
1786368	85222	GQLLIIPQHYAVLKKA	B9F4T2_ORYSJ	161	1
1786369	85222	GQLLIIPQHYAVLKKA	B9F4T1_ORYSJ	375	1
1786370	85222	GQLLIIPQHYAVLKKA	B8AEZ5_ORYSI	379	1
1786371	85222	GQLLIIPQHYAVLKKA	A2X301_ORYSI	288	1
1786372	85222	GQLLIIPQHYAVLKKA	A1YQH6_ORYSJ	397	1
1786373	85222	GQLLIIPQHYAVLKKA	A1YQH5_ORYSJ	397	1
1786374	85222	GQLLTIPQNFAVVKRA	B5KVH4_CARIL	415	1
1786375	85222	GQLLTIPQNFAVVKRA	B5KVH5_CARIL	415	1
1786376	85222	GQLLIVPQHYVVVKKA	A1YQG3_ORYSJ	405	1
1786377	85222	GQLLIVPQHYVVVKKA	GLUA2_ORYSJ	405	1
1786378	85222	GQLLIVPQHYVVVKKA	A2Z708_ORYSI	405	1
1786379	85222	GQLLIIPQHYAILKKA	A2X2Z8_ORYSI	340	1
1786380	85222	GQLLIIPQHYVVLKKA	A2X399_ORYSI	402	1
1786381	85222	GQLLIIPQHYVVLKKA	Q0E262_ORYSJ	402	1
1786382	85222	GQLLIIPQHYVVLKKA	Q0E261_ORYSJ	402	1
1786383	85222	GQLLIIPQHYVVLKKA	GLUB5_ORYSJ	402	1
1786384	85222	GQLLIIPQHYVVLKKA	GLUB4_ORYSJ	402	1
1786385	85222	GQLLIIPQHYVVLKKA	A2X3A0_ORYSI	221	1
1786386	85222	GQLLTIPQNFAVVKRA	Q2TPW5_9ROSI	414	1
1786387	85222	GQLLIIPQHYAVVKKA	A2WVB9_ORYSI	405	1
1786388	85222	GQLLIIPQHYAVVKKA	A1YQG5_ORYSJ	405	1
1786389	85222	GQLLIIPQHYAVVKKA	Q0JJ36_ORYSJ	405	1
1786390	85222	GQLLIIPQHYAVVKKA	GLUA1_ORYSJ	405	1
1786391	85222	GQLLIIPQHYVVVKKA	Q0Z945_9ORYZ	406	1
1786392	85222	GQLLIIPQNYVVMKKA	A2X2V1_ORYSI	398	1
1786393	85222	GQLLIIPQNYVVMKKA	Q84X94_ORYSJ	398	1
1786394	85222	GQLLIVPQHFVVLKKA	Q38780_AVESA	424	1
1786395	85222	GQLVVVPQSFAVVKQA	Q40347_MAGSL	387	1
1786396	85222	GQVLTVPQNFAVVKRA	B9GS11_POPTR	392	1
1786397	85222	GQLLIIPQNYVVMKKA	C0L8H1_ORYSJ	397	1
1786398	85222	GQLLIIPQNYVVMKKA	Q84X93_ORYSJ	398	1
1786399	85222	GQLLIIPQNYVVMKKA	Q6ESW6_ORYSJ	398	1
1786400	85222	GQLLIIPQHYVVLKKA	SSG2_AVESA	416	1
1786401	85222	GQLLIVPQHYVVVKKA	Q40689_ORYSA	405	1
1786402	85222	GQVLTVPQNFAVVKRS	B9H8M5_POPTR	392	1
1786403	85222	GQLLIIPQHHVVLKKA	Q0Z870_9ORYZ	414	1
1786404	85222	GQLLIVPQHFVVLKNA	Q38779_AVESA	448	1
1786405	85222	HQILTVPQNFAVVKRA	Q41128_QUERO	397	1
1786406	85222	GQVLTIPQNFAVAKRA	Q8W1C2_CORAV	419	1
1786407	85222	GQLLIVPQHYVVLKKA	O49258_AVESA	412	1
1786408	85222	GQLLIIPQHHVVIKKA	B8AKE2_ORYSI	404	1
1786409	85222	GQLLIIPQHHVVIKKA	Q10JA8_ORYSJ	404	1
1786410	85222	GQLLIIPQHHVVIKKA	GLUA3_ORYSJ	404	1
1786411	85222	GQLLIIPQHHVVIKKA	B9F952_ORYSJ	404	1
1786412	85222	EQILTVPQNFAVVKRA	Q8LK20_CASCR	452	1
1786413	85222	GQLLIIPQHYVVLKKA	SSG1_AVESA	416	1
1786414	85222	GQVLTVPQHHAVVKQA	A1E0V5_FICAW	421	1
1786415	85222	GQALTVPQNYVIVKQA	A1E0V7_FICAW	407	1
1786416	85222	GQIFVVPQNFAVVKRA	B7SLJ1_PISVE	386	1
1786417	85222	GQVLTVPQHHAVVKQA	A1E0V4_FICAW	423	1
1786418	85222	GQVVVVPQNFAVVKRA	Q2XSW6_SESIN	380	1
1786419	85222	GQALTVPQNFVIVKQA	A1E0V8_FICAW	401	1
1786420	85222	EQLLIIPQNYVVLKKA	B8AEZ0_ORYSI	375	1
1786421	85222	EQLLIIPQNYVVLKKA	A3A527_ORYSJ	375	1
1786422	85222	EQLLIIPQNYVVLKKA	Q6T725_ORYSJ	397	1
1786423	85222	GQLVVVPQNFAVVKQA	Q06AW1_CHEQI	390	1
1786424	85222	GQLVVVPQNFAVVKQA	Q6Q384_CHEQI	390	1
1786425	85222	GQLLIIPQNYVVLKKA	B2CGM6_WHEAT	481	1
1786426	85222	GQLLILPQHYVVLKKT	O49257_AVESA	369	1
1786427	85222	GQLLVVPQNFVVAQQA	B5U8K2_LOTJA	524	1
1786428	85222	GQLLVVPQNFVVAQQA	B5U8K1_LOTJA	493	1
1786429	85222	GQLLVVPQNFVVAEQA	A3KEY9_GLYSO	477	1
1786430	85222	GQLLVVPQNFVVAEQA	Q9SB11_SOYBN	477	1
1786431	85222	GQLLVVPQNFVVAEQA	Q9S9D0_SOYBN	477	1
1786432	85222	GQLLVVPQNFVVAEQA	Q43452_SOYBN	476	1
1786433	85222	GQLLVVPQNFVVAEQA	Q39921_GLYSO	477	1
1786434	85222	GQLLVVPQNFVVAEQA	GLYG4_SOYBN	476	1
1786435	85222	GQLVVVPQNFVVMKQA	A0EM47_ACTCH	377	1
1786436	85222	GQLLIIPQNYVVMKKA	B2CGM5_WHEAT	481	1
1786437	85222	GQLVVVPQNFAVVKQA	Q06AW2_CHEQI	391	1
1786438	85222	GQLVVVPQNFAVVKQA	Q6Q385_CHEQI	391	1
1786439	85222	GQVVTAPQNFAVVMKA	B9N2L2_POPTR	379	1
1786440	85222	GQVVTAPQNFAVVMKA	B9P6C0_POPTR	409	1
1786441	85222	GQLLVVPQNFVVAHQA	C9WC98_LUPAN	406	1
1786442	85222	GQLIIVPQYFAVIKKA	13SB_FAGES	99	1
1786443	85222	GQLVVVPQNFVVAEQA	Q41703_VICSA	403	1
1786444	85222	GQLLVIPQNFAVIKQA	Q9M4R4_ELAGV	385	1
1786445	85222	GQVVTAPQSFAVVKKA	B9N2L3_POPTR	407	1
1786446	85222	GQVVTAPQSFAVVKKA	B9N2L4_POPTR	406	1
1786447	85222	GQLIIVPQYFAVIKKA	P93079_COFAR	400	1
1786448	85222	GQLLVVPQNYAVAKQA	A1E0V3_FICAW	419	1
1786449	85222	GQVLTVPQNFMVVKRA	B9SF37_RICCO	391	1
1786450	85222	GQLIIVPQYFAVIKKA	O82437_COFAR	403	1
1786451	85222	GQLIIVPQYFAVIKKA	Q9ZNY2_COFAR	403	1
1786452	85222	GQVLTVPQNFVVVKRS	Q9M4Q8_RICCO	388	1
1786453	85222	GQVLTVPQNFMVVKRA	B9SF36_RICCO	421	1
1786454	85222	GQVLTVPQNFVVVKRS	B9SDX6_RICCO	388	1
1786455	85222	GQLLIIPQNHAVIKKA	A2X2Z1_ORYSI	384	1
1786456	85222	GQLIIVPQNYVVAKRA	Q9AUD2_SESIN	388	1
1786457	85222	GQLIVVPQGFAVVKRA	Q39627_CITSI	398	1
1786458	85222	GQLLVVPQNFVVAEQG	A3KEY8_GLYSO	439	1
1786459	85222	GQLLVVPQNFVVAEQG	Q7GC77_SOYBN	443	1
1786460	85222	GQLLVVPQNFVVAEQG	Q39922_GLYSO	443	1
1786461	85222	GQLLVVPQNFVVAEQG	P93708_SOYBN	443	1
1786462	85222	GQLLVVPQNFVVAEQG	P93707_SOYBN	443	1
1786463	85222	GQLLVVPQNFVVAEQG	C0KG62_SOYBN	443	1
1786464	85222	GQMFTVPQNFVVITKA	B9T5E7_RICCO	415	1
1786465	85222	GQLVVVPQNFAVVKRA	B2KN55_PISVE	386	1
1786466	85222	GQLVVVPQNFAVVKRA	B7P074_PISVE	386	1
1786467	85222	GQLLVVPQNFVVAEQA	Q1WAB8_9FABA	473	1
1786468	85222	GQLLVVPQNYAVAKQA	A1E0V6_FICAW	413	1
1786469	85222	GQLVVVPQNFVVAEQA	LEGJ_PEA	421	1
1786470	85222	GQLVVVPQNFVVAQQA	Q43673_VICFA	482	1
1786471	85222	GQILVVPQGFAVVVKA	A9NJG2_FAGTA	419	1
1786472	85222	GQVLTVPQNFVVVKRA	B9T1B8_RICCO	376	1
1786473	85222	GQLVVVPQNFVVAEQA	LEGB4_VICFA	402	1
1786474	85222	GQLVVVPQNFAVVKRA	B7P073_PISVE	395	1
1786475	85222	GQMVVVPQNFVVVKQA	Q84ND2_BEREX	378	1
1786476	85222	GQLLIIPQNHAVIKKA	Q6K508_ORYSJ	384	1
1786477	85222	GQVLMIPQNFVVIKRA	11SB_CUCMA	395	1
1786478	85222	GQLLVVPQNFVVAEQG	Q9SB12_SOYBN	443	1
1786479	85222	GQLLIIPQNHAVIKKA	Q6T726_ORYSJ	384	1
1786480	85222	GQLVVVPQNFVVAQQA	O24294_PEA	488	1
1786481	85222	QQILLIPQNFAVVVKA	B8AH66_ORYSI	396	1
1786482	85222	QQILLIPQNFAVVVKA	Q9ZWJ8_ORYSA	417	1
1786483	85222	QQILLIPQNFAVVVKA	Q6K7K6_ORYSJ	417	1
1786484	85222	QQILLIPQNFAVVVKA	B9EZT3_ORYSJ	396	1
1786485	85222	GQILVVPQGFAVVLKA	13S1_FAGES	476	1
1786486	85222	GQLLVVPQNPAVAEQG	GLYG5_SOYBN	442	1
1786487	85222	GQLFIVPQNHGVIQQA	Q43607_PRUDU	466	1
1786488	85222	GQILVVPQGFAVVLKA	13S3_FAGES	446	1
1786489	85222	GQLVVVPQNFAIVKQA	A2I9A6_AMAHP	397	1
1786490	85222	GQMFTVPQNFIVITKA	B9S9Q7_RICCO	303	1
1786491	85222	GQLVVIPQGFAYVVQS	Q2TLW0_SINAL	419	1
1786492	85222	GQLVVIPQGFAYVVQS	Q9AXL9_BRANA	398	1
1786493	85222	GQVLTLPQNFVVVNRA	B9SF35_RICCO	389	1
1786494	85222	GQMFTVPQNFVVITKA	B9T5E6_RICCO	311	1
1786495	85222	GQLVVIPQGFAYVVQS	CRU1_RAPSA	388	1
1786496	85222	GQLVVIPQGFAYVVQS	CRU3_BRANA	418	1
1786497	85222	GQLLSIPQGFSVVKRA	CRU1_BRANA	399	1
1786498	85222	GQLLSIPQGFSVVKRA	CRUA_BRANA	397	1
1786499	85222	GRVVVVPQNFAVAIQA	Q3HW60_SOYBN	446	1
1786500	85222	GRVVVVPQNFAVAIQA	Q9FEC5_SOYBN	446	1
1786501	85222	GRVVVVPQNFAVAIQA	Q6DR94_SOYBN	446	1
1786502	85222	GQLVVIPQGFAYVVQS	Q2TLV9_SINAL	432	1
1786503	85222	GQLLSIPQGFSVVKRA	CRU2_BRANA	405	1
1786504	85222	GQLVVIPQGFAYVVQS	Q8RX74_ARATH	432	1
1786505	85222	GQLVVIPQGFAYVVQS	Q96318_ARATH	432	1
1786506	85222	GQSLVVPQNFAVAAKS	AHY3_ARAHY	397	1
1786507	85222	GQLLVVPQGFSVMKHA	12S2_ARATH	368	1
1786508	85222	GQLLVVPQGFSVMKHA	Q56WH8_ARATH	91	1
1786509	85222	GQLLTVPQNFAFMKQA	LEGA_GOSHI	423	1
1786510	85222	GQLLVVPQGFAVVKRA	CRU4_BRANA	375	1
1786511	85222	GQLLIIPQNFAHVKIA	C0ILQ2_COFCA	304	1
1786512	85222	GHVLVVPQNFAVAGKS	Q647H4_ARAHY	450	1
1786513	85222	GHVLVVPQNFAVAGKS	Q6T2T4_ARAHY	450	1
1786514	85222	GQLIAVPQGFSVVKRA	12S1_ARATH	381	1
1786515	85222	GQILVVPQGFAVVLKA	13S2_FAGES	412	1
1786516	85222	GGVLIVPQNFAVAAKS	GLYG2_SOYBN	399	1
1786517	85222	GGVLIVPQNFAVAAKS	Q549Z4_SOYBN	399	1
1786518	85222	GHVLVVPQNFAVAGKS	B5TYU1_ARAHY	444	1
1786519	85222	GHVLVVPQNFAVAGKS	Q5I6T2_ARAHY	444	1
1786520	85222	GHVLVVPQNFAVAGKS	A1DZF0_ARAHY	443	1
1786521	85222	GQVLIVPQNFAVAARS	GLYG3_SOYBN	395	1
1786522	85222	GQVLIVPQNFAVAARS	Q852U5_SOYBN	395	1
1786523	85222	GHVLVVPQNFAVAGKS	Q8LKN1_ARAHY	452	1
1786524	85222	GHVLVVPQNFAVAGKS	Q647H3_ARAHY	451	1
1786525	85222	GQVLTVPQNFAVAARS	Q852U4_SOYBN	396	1
1786526	85222	GRVLIVPQNFVVAARS	GLYG1_SOYBN	409	1
1786527	85222	GQLVVVPQNFALAIRA	Q2XSW7_SESIN	406	1
1786528	85222	GRALTVPQNYAVAAKS	LEGA2_PEA	434	1
1786529	85222	GRALTVPQNYAVAAKS	Q9T0P5_PEA	431	1
1786530	85222	GRALTVPQNYAVAAKS	LEGA_PEA	431	1
1786531	85222	GHVLVVPQNFAVAGKS	Q9FZ11_ARAHY	443	1
1786532	85222	GQVVVVPQNYAVVKQA	P93559_SAGSA	491	1
1786533	85222	GQIIVIPQGFAVSKTA	Q9ZWA9_ARATH	369	1
1786534	85222	GQLLIIPQGYLVATKA	C5YY38_SORBI	390	1
1786535	85222	GRALTVPQNYAVAAKS	Q99304_VICFA	414	1
1786536	85222	GRALTVPQNYAVAAKS	Q41676_VICNA	396	1
1786537	85222	GHVLVVPQNFAVAAKA	Q0GM57_ARAHY	425	1
1786538	85222	GRALTVPQNYAVAAKS	Q41702_VICSA	412	1
1786539	85222	GQILTIPQNFVAMSKA	B9SW16_RICCO	397	1
1786540	85222	GQMVVVPQSFAVAGRA	A2YQV0_ORYSI	425	1
1786541	85222	GQLLVVPQNFAVANQA	P93560_SAGSA	705	1
1786542	85222	GQLLIVPQGYLVATKA	Q946V2_MAIZE	389	1
1786543	85222	GQLLIVPQGYLVATKA	Q948J8_MAIZE	388	1
1786544	85222	GDLVVVPQYFAMMKRA	Q38698_ASAEU	377	1
1786545	85222	GQMVVVPQSFAVAGRA	A3BP99_ORYSJ	424	1
1786546	85222	GQMVVVPQSFAVAGRA	Q6ZK46_ORYSJ	429	1
1786547	85222	GQVLIVPQNFVVAARS	B5U8K6_LOTJA	389	1
1786548	85222	GQVLTIPQNYAAAIKS	Q53I54_LUPAL	426	1
1786549	85222	GDLVVFPQYFAVMKRA	Q40348_MAGSL	389	1
1786550	85222	GQFLVIPQLHAIAKQA	Q39770_GINBI	371	1
1786551	85222	GQFLVIPQFYAVVKRA	O04689_METGY	412	1
1786552	85222	GQFIVIPQFYAVIKQA	Q40870_PICGL	410	1
1786553	85222	GQFLVIPQFYAVMKRA	Q39521_CRYJA	423	1
1786554	85222	GQFLVIPQFYAVMKRA	O04691_METGY	414	1
1786555	85222	GQFIVIPQFHAVIKQA	Q40933_PSEMZ	414	1
1786556	85222	GDMFVVPQYFAVMKQA	Q38697_ASAEU	374	1
1786557	85222	GDMFVIPQFYATLMRA	B9H8M2_POPTR	378	1
1786558	85222	GQFLLIPQNFAAVKEA	Q39775_GNEGN	468	1
1786559	85223	EGCQYIAIKTNANAFVSHL	A1YQH4_ORYSJ	415	2
1786560	85223	EGCQYIAIKTNANAFVSHL	Q0E2D5_ORYSJ	415	2
1786561	85223	EGCQYIAIKTNANAFVSHL	Q0E2D2_ORYSJ	419	2
1786562	85223	EGCQYIAIKTNANAFVSHL	GLUB2_ORYSJ	415	2
1786563	85223	EGCQYIAIKTNANAFVSHL	GLUB1_ORYSJ	419	2
1786564	85223	EGCQYIAIKTNANAFVSHL	B9F4T3_ORYSJ	397	2
1786565	85223	EGCQYIAIKTNANAFVSHL	B9F4T2_ORYSJ	179	2
1786566	85223	EGCQYIAIKTNANAFVSHL	B9F4T1_ORYSJ	393	2
1786567	85223	EGCQYIAIKTNANAFVSHL	B8AEZ5_ORYSI	397	2
1786568	85223	EGCQYIAIKTNANAFVSHL	A2X301_ORYSI	306	2
1786569	85223	EGCQYIAIKTNANAFVSHL	A1YQH6_ORYSJ	415	2
1786570	85223	EGCQYIAIKTNANAFVSHL	A1YQH5_ORYSJ	415	2
1786571	85223	EGFEWVSFKTNENAMVSPL	B5KVH4_CARIL	433	2
1786572	85223	EGFEWVSFKTNENAMVSPL	B5KVH5_CARIL	433	2
1786573	85223	EGCAYIAFKTNPNSMVSHI	A1YQG3_ORYSJ	423	2
1786574	85223	EGCAYIAFKTNPNSMVSHI	GLUA2_ORYSJ	423	2
1786575	85223	EGCAYIAFKTNPNSMVSHI	A2Z708_ORYSI	423	2
1786576	85223	EGCQYIAIKTNANAFVSHL	A2X2Z8_ORYSI	358	2
1786577	85223	EGCQYISFKTNANSMVSHL	A2X399_ORYSI	420	2
1786578	85223	EGCQYISFKTNANSMVSHL	Q0E262_ORYSJ	420	2
1786579	85223	EGCQYISFKTNANSMVSHL	Q0E261_ORYSJ	420	2
1786580	85223	EGCQYISFKTNANSMVSHL	GLUB5_ORYSJ	420	2
1786581	85223	EGCQYISFKTNANSMVSHL	GLUB4_ORYSJ	420	2
1786582	85223	EGCQYISFKTNANSMVSHL	A2X3A0_ORYSI	239	2
1786583	85223	EGFEWVSFKTNENAMVSPL	Q2TPW5_9ROSI	432	2
1786584	85223	EGCAYIAFKTNPNSMVSHI	A2WVB9_ORYSI	423	2
1786585	85223	EGCAYIAFKTNPNSMVSHI	A1YQG5_ORYSJ	423	2
1786586	85223	EGCAYIAFKTNPNSMVSHI	Q0JJ36_ORYSJ	423	2
1786587	85223	EGCAYIAFKTNPNSMVSHI	GLUA1_ORYSJ	423	2
1786588	85223	EGCAYIAFKTNPNSMVSHI	Q0Z945_9ORYZ	424	2
1786589	85223	EGFQYVAFKTNPNAMVNHI	A2X2V1_ORYSI	416	2
1786590	85223	EGFQYVAFKTNPNAMVNHI	Q84X94_ORYSJ	416	2
1786591	85223	EGCQYISFKTNPNSMVSHI	Q38780_AVESA	442	2
1786592	85223	KGFEYVAFKTNDNAMNSPL	Q40347_MAGSL	405	2
1786593	85223	NRFEWVSFKTNDNAMISPL	B9GS11_POPTR	410	2
1786594	85223	EGFQFIAFKTNPNAMVNHI	C0L8H1_ORYSJ	415	2
1786595	85223	EGFQFIAFKTNPNAMVNHI	Q84X93_ORYSJ	416	2
1786596	85223	EGFQFIAFKTNPNAMVNHI	Q6ESW6_ORYSJ	416	2
1786597	85223	EGCQYISFKTNPNSMVSQI	SSG2_AVESA	434	2
1786598	85223	EGCAYIASKTNPNSMVSHI	Q40689_ORYSA	423	2
1786599	85223	QSFEWVSFKTNDNAMISPL	B9H8M5_POPTR	410	2
1786600	85223	EGCSYIAFKTNPNSMVSQI	Q0Z870_9ORYZ	432	2
1786601	85223	EGCQYISFKTNPNSMVSHI	Q38779_AVESA	466	2
1786602	85223	EGFEWVAFKTNDNAQISPL	Q41128_QUERO	416	3
1786603	85223	EGFEWVAFKTNDNAQISPL	Q8W1C2_CORAV	437	2
1786604	85223	EGCQYISFKTNPNSMVSHI	O49258_AVESA	430	2
1786605	85223	EGCSYIALKTNPDSMVSHM	B8AKE2_ORYSI	422	2
1786606	85223	EGCSYIALKTNPDSMVSHM	Q10JA8_ORYSJ	422	2
1786607	85223	EGCSYIALKTNPDSMVSHM	GLUA3_ORYSJ	422	2
1786608	85223	EGCSYIALKTNPDSMVSHM	B9F952_ORYSJ	422	2
1786609	85223	EGFEWVAFKTNDKAQISPL	Q8LK20_CASCR	470	2
1786610	85223	EGCQYISFKTTPNSMVSYI	SSG1_AVESA	434	2
1786611	85223	EGFEWVSFKTNDNAWVSPL	A1E0V5_FICAW	439	2
1786612	85223	EGFEWISFKTNDRAKVTQL	A1E0V7_FICAW	425	2
1786613	85223	QRFEWISFKTNDRAMISPL	B7SLJ1_PISVE	404	2
1786614	85223	EGFEWVSFKTNDNAWVSPL	A1E0V4_FICAW	441	2
1786615	85223	QGCEWVEFNTNDNALINTL	Q2XSW6_SESIN	398	2
1786616	85223	EGFEWVSFKTNDRAKVNQL	A1E0V8_FICAW	419	2
1786617	85223	EGCQYIAINTNANAFVSHL	B8AEZ0_ORYSI	393	2
1786618	85223	EGCQYIAINTNANAFVSHL	A3A527_ORYSJ	393	2
1786619	85223	EGCQYIAINTNANAFVSHL	Q6T725_ORYSJ	415	2
1786620	85223	EGFEWIAFKTCENALFQTL	Q06AW1_CHEQI	408	2
1786621	85223	EGFEWIAFKTCENALFQTL	Q6Q384_CHEQI	408	2
1786622	85223	DGSKYIEFKTNANSMVSHI	B2CGM6_WHEAT	499	2
1786623	85223	EGCQYISFKTNPNSMVSHI	O49257_AVESA	387	2
1786624	85223	EGFEYVVFKTNARAAVSHV	B5U8K2_LOTJA	542	2
1786625	85223	EGFEYVVFKTNARAAVSHV	B5U8K1_LOTJA	511	2
1786626	85223	QGFEYIVFKTHHNAVTSYL	A3KEY9_GLYSO	495	2
1786627	85223	QGFEYIVFKTHHNAVTSYL	Q9SB11_SOYBN	495	2
1786628	85223	QGFEYIVFKTHHNAVTSYL	Q9S9D0_SOYBN	495	2
1786629	85223	QGFEYIVFKTHHNAVTSYL	Q43452_SOYBN	494	2
1786630	85223	QGFEYIVFKTHHNAVTSYL	Q39921_GLYSO	495	2
1786631	85223	QGFEYIVFKTHHNAVTSYL	GLYG4_SOYBN	494	2
1786632	85223	QGFEWVAIKTNENAMFNTL	A0EM47_ACTCH	395	2
1786633	85223	DGSKYIEFKTNANSMVSHI	B2CGM5_WHEAT	499	2
1786634	85223	EGFEWIAFKTCENALFQTL	Q06AW2_CHEQI	409	2
1786635	85223	EGFEWIAFKTCENALFQTL	Q6Q385_CHEQI	409	2
1786636	85223	QGLEWVSFKTNDNAQISQL	B9N2L2_POPTR	397	2
1786637	85223	QGLEWVSFKTNDNAQISQL	B9P6C0_POPTR	427	2
1786638	85223	EGFEFIAFKTNDQATTSPL	C9WC98_LUPAN	424	2
1786639	85223	QGFEYVAFKTNDNAMINPL	13SB_FAGES	117	2
1786640	85223	EGLEYVVFKTNDRAAVSHV	Q41703_VICSA	422	3
1786641	85223	EGFEFTSIKTIDNAMVNTI	Q9M4R4_ELAGV	403	2
1786642	85223	QGFEWVSFKTNDNAQVSEL	B9N2L3_POPTR	425	2
1786643	85223	QGFEWVSFKTNDNAQVSEL	B9N2L4_POPTR	424	2
1786644	85223	EGFEYVAFKTNDNAMINPL	P93079_COFAR	418	2
1786645	85223	RGFEWIAIKTNDNAMRNPL	A1E0V3_FICAW	437	2
1786646	85223	DRFEYVAFKTNDNAMTFDA	B9SF37_RICCO	409	2
1786647	85223	QGFEYVAFKTNDNAMINPL	O82437_COFAR	421	2
1786648	85223	QGFEYVAFKTNDNAMINPL	Q9ZNY2_COFAR	421	2
1786649	85223	DRFEYVAFKTNDNAMTSDL	Q9M4Q8_RICCO	406	2
1786650	85223	DRFEYVAFKTNDNAMTFDA	B9SF36_RICCO	439	2
1786651	85223	DRFEYVAFKTNDNAMTSDL	B9SDX6_RICCO	406	2
1786652	85223	NGCQYVAIKTIPNPMVSRV	A2X2Z1_ORYSI	402	2
1786653	85223	EGLEWISFKTNDNAMTSQL	Q9AUD2_SESIN	407	3
1786654	85223	RGLEWISFKTNDVAMTSQL	Q39627_CITSI	416	2
1786655	85223	QGLEYVVFKTHHNAVSSYI	A3KEY8_GLYSO	457	2
1786656	85223	QGLEYVVFKTHHNAVSSYI	Q7GC77_SOYBN	461	2
1786657	85223	QGLEYVVFKTHHNAVSSYI	Q39922_GLYSO	461	2
1786658	85223	QGLEYVVFKTHHNAVSSYI	P93708_SOYBN	461	2
1786659	85223	QGLEYVVFKTHHNAVSSYI	P93707_SOYBN	461	2
1786660	85223	QGLEYVVFKTHHNAVSSYI	C0KG62_SOYBN	461	2
1786661	85223	EGLEWVSFKTNDNAKINQL	B9T5E7_RICCO	433	2
1786662	85223	DGFEWVSFKTNGLAKISQL	B2KN55_PISVE	404	2
1786663	85223	DGFEWVSFKTNGLAKISQL	B7P074_PISVE	404	2
1786664	85223	QGFEYIVFKTHHNAVTSYL	Q1WAB8_9FABA	491	2
1786665	85223	RGFEWIAIKTNDNAMRNPL	A1E0V6_FICAW	431	2
1786666	85223	EGLEYVVFKTNDRAAVSHV	LEGJ_PEA	440	3
1786667	85223	EAFEYVVFKTNDRAAVSHV	Q43673_VICFA	501	3
1786668	85223	QGLEWVELKNNDNAITSPI	A9NJG2_FAGTA	437	2
1786669	85223	DRFECVAFNTNDNAVASDL	B9T1B8_RICCO	394	2
1786670	85223	EGLEYLVFKTNDRAAVSHV	LEGB4_VICFA	421	3
1786671	85223	DKFEWVSFKTNGLSQTSQL	B7P073_PISVE	413	2
1786672	85223	RGFEWVVFNTNDNALFSTA	Q84ND2_BEREX	396	2
1786673	85223	NGCQYVAIKTISDPTVSWV	Q6K508_ORYSJ	402	2
1786674	85223	RGFEWIAFKTNDNAITNLL	11SB_CUCMA	413	2
1786675	85223	QGLEYVVFKTHHNAVSSYI	Q9SB12_SOYBN	461	2
1786676	85223	NGCQYVAIKTISDPTVSWV	Q6T726_ORYSJ	402	2
1786677	85223	EGFEYVVFKTNDRAAVSHV	O24294_PEA	507	3
1786678	85223	EGFAWVSFKTNHNAVDSQI	B8AH66_ORYSI	414	2
1786679	85223	EGFAWVSFKTNHNAVDSQI	Q9ZWJ8_ORYSA	435	2
1786680	85223	EGFAWVSFKTNHNAVDSQI	Q6K7K6_ORYSJ	435	2
1786681	85223	EGFAWVSFKTNHNAVDSQI	B9EZT3_ORYSJ	414	2
1786682	85223	EGLEWVELKNDDNAITSPI	13S1_FAGES	494	2
1786683	85223	QGLEYVVFKTHHNAVSSYI	GLYG5_SOYBN	460	2
1786684	85223	QGFEYFAFKTEENAFINTL	Q43607_PRUDU	484	2
1786685	85223	EGLEWVELKNDDNAITSPI	13S3_FAGES	464	2
1786686	85223	DGFEWVSFKTSENAMFQSL	A2I9A6_AMAHP	415	2
1786687	85223	EVLEWISFKTNDKAKINQL	B9S9Q7_RICCO	321	2
1786688	85223	NNFEWISFKTNANAMISTL	Q2TLW0_SINAL	436	1
1786689	85223	NNFEWISFKTNANAMVSTL	Q9AXL9_BRANA	416	2
1786690	85223	DNFEYVSFNTNDNAVAFDV	B9SF35_RICCO	407	2
1786691	85223	QGLEWVSFKTNDNARINQL	B9T5E6_RICCO	329	2
1786692	85223	NNFEWISFKTNANAMVSTL	CRU1_RAPSA	406	2
1786693	85223	NNFEWISFKTNANAMVSTL	CRU3_BRANA	436	2
1786694	85223	EQFRWIEFKTNANAQINTL	CRU1_BRANA	417	2
1786695	85223	EQFRWIEFKTNANAQINTL	CRUA_BRANA	415	2
1786696	85223	DGMEYIVFRTNDRAMMGTL	Q3HW60_SOYBN	464	2
1786697	85223	DGMEYIVFRTNDRAMMGTL	Q9FEC5_SOYBN	464	2
1786698	85223	DGMEYIVFRTNDRAMMGTL	Q6DR94_SOYBN	464	2
1786699	85223	NNFEWISFKTNANAMISTL	Q2TLV9_SINAL	449	1
1786700	85223	DQFRWIEFKTNANAQINTL	CRU2_BRANA	423	2
1786701	85223	NKFEWISFKTNENAMISTL	Q8RX74_ARATH	450	2
1786702	85223	NKFEWISFKTNENAMISTL	Q96318_ARATH	450	2
1786703	85223	EHFLYVAFKTNSRASISNL	AHY3_ARAHY	415	2
1786704	85223	EQFEWIEFKTNENAQVNTL	12S2_ARATH	386	2
1786705	85223	EQFEWIEFKTNENAQVNTL	Q56WH8_ARATH	109	2
1786706	85223	EGAEWISFFTNSEATNTPM	LEGA_GOSHI	441	2
1786707	85223	QQFQWIEFKSNDNAQINTL	CRU4_BRANA	393	2
1786708	85223	EGLEWFNVKTNDNAKTSPL	C0ILQ2_COFCA	322	2
1786709	85223	ENFEYVAFKTDSRPSIANL	Q647H4_ARAHY	468	2
1786710	85223	ENFEYVAFKTDSRPSIANL	Q6T2T4_ARAHY	468	2
1786711	85223	NRFQWVEFKTNANAQINTL	12S1_ARATH	399	2
1786712	85223	EGLEWVELKNSGNAITSPI	13S2_FAGES	430	2
1786713	85223	DNFEYVSFKTNDRPSIGNL	GLYG2_SOYBN	417	2
1786714	85223	DNFEYVSFKTNDRPSIGNL	Q549Z4_SOYBN	417	2
1786715	85223	DNFEYVAFKTDSRPSIANL	B5TYU1_ARAHY	462	2
1786716	85223	DNFEYVAFKTDSRPSIANL	Q5I6T2_ARAHY	462	2
1786717	85223	ENFEYVAFKTDSRPSIANL	A1DZF0_ARAHY	461	2
1786718	85223	DNFEYVSFKTNDRPSIGNL	GLYG3_SOYBN	413	2
1786719	85223	DNFEYVSFKTNDRPSIGNL	Q852U5_SOYBN	413	2
1786720	85223	ENFEYVAFKTDSRPSIANL	Q8LKN1_ARAHY	470	2
1786721	85223	DNFEYVAFKTDSRPSIANL	Q647H3_ARAHY	469	2
1786722	85223	DNFEYVSFKTNDRPSIGNL	Q852U4_SOYBN	414	2
1786723	85223	DNFEYVSFKTNDTPMIGTL	GLYG1_SOYBN	427	2
1786724	85223	QGFEYVTFRTNDNAMKSEL	Q2XSW7_SESIN	424	2
1786725	85223	DRFSYVAFKTNDRAGIARL	LEGA2_PEA	452	2
1786726	85223	DRFSYVAFKTNDRAGIARL	Q9T0P5_PEA	449	2
1786727	85223	DRFSYVAFKTNDRAGIARL	LEGA_PEA	449	2
1786728	85223	DNFEYVAFKTDSRPNIANF	Q9FZ11_ARAHY	461	2
1786729	85223	DEFEWISLKTNDNAMVNQI	P93559_SAGSA	509	2
1786730	85223	TGFEWISFKTNDNAYINTL	Q9ZWA9_ARATH	387	2
1786731	85223	EGFQYISFETNHNSMVSHI	C5YY38_SORBI	408	2
1786732	85223	DRFTYVAFKTNDRAGIARL	Q99304_VICFA	432	2
1786733	85223	ERFTYVAFKTNDRDGIARL	Q41676_VICNA	414	2
1786734	85223	ENYEYLAFKTDSRPSIANL	Q0GM57_ARAHY	443	2
1786735	85223	ERFTYVAFKTDDRASIARL	Q41702_VICSA	430	2
1786736	85223	EGLEWVSFKTNDNPKMSQI	B9SW16_RICCO	415	2
1786737	85223	EGFAWVSFQTSDGAMNAPV	A2YQV0_ORYSI	443	2
1786738	85223	DNFEWIALKTNENAIINQI	P93560_SAGSA	723	2
1786739	85223	EGFQYIAFETNPDTMVSHV	Q946V2_MAIZE	407	2
1786740	85223	EGFQYIAFETNPDTMVSHV	Q948J8_MAIZE	406	2
1786741	85223	NGFEWVSFKTSPLPVRSPL	Q38698_ASAEU	395	2
1786742	85223	EGFAWVSFQTSDGAMNAPV	A3BP99_ORYSJ	442	2
1786743	85223	EGFAWVSFQTSDGAMNAPV	Q6ZK46_ORYSJ	447	2
1786744	85223	DKFNYVAFKTNDMPTMAKL	B5U8K6_LOTJA	407	2
1786745	85223	DNFRYVAFKTNDIPQIATL	Q53I54_LUPAL	444	2
1786746	85223	NGFEWVSFKTSASPMRSPL	Q40348_MAGSL	407	2
1786747	85223	DGLEWISFTTSDSPIRSTL	Q39770_GINBI	389	2
1786748	85223	QGFEWITFTTSHSPIRSSF	O04689_METGY	430	2
1786749	85223	EGFEWITFTTSDISFQSFL	Q40870_PICGL	428	2
1786750	85223	QGFDWITFTTCHSPIRSSF	Q39521_CRYJA	441	2
1786751	85223	QGFDWITFTTCHSPIRSSF	O04691_METGY	432	2
1786752	85223	DGLEWITFTTSDASVRSSL	Q40933_PSEMZ	432	2
1786753	85223	NGLEWVSIKTSALPMRSPL	Q38697_ASAEU	392	2
1786754	85223	NGFEWVSFKSSSQPIKSPM	B9H8M2_POPTR	396	2
1786755	85223	QIFEWVAFLTDGRPLREQL	Q39775_GNEGN	486	2
1786756	85224	NSVFRALPVDVVANAYRI	A1YQH4_ORYSJ	437	3
1786757	85224	NSVFRALPVDVVANAYRI	Q0E2D5_ORYSJ	437	3
1786758	85224	NSVFRALPVDVVANAYRI	Q0E2D2_ORYSJ	441	3
1786759	85224	NSVFRALPVDVVANAYRI	GLUB2_ORYSJ	437	3
1786760	85224	NSVFRALPVDVVANAYRI	GLUB1_ORYSJ	441	3
1786761	85224	NSVFRALPVDVVANAYRI	B9F4T3_ORYSJ	419	3
1786762	85224	NSVFRALPVDVVANAYRI	B9F4T2_ORYSJ	201	3
1786763	85224	NSVFRALPVDVVANAYRI	B9F4T1_ORYSJ	415	3
1786764	85224	NSVFRALPVDVVANAYRI	B8AEZ5_ORYSI	419	3
1786765	85224	NSVFRALPVDVVANAYRI	A2X301_ORYSI	328	3
1786766	85224	NSVFRALPVDVVANAYRI	A1YQH6_ORYSJ	437	3
1786767	85224	NSVFRALPVDVVANAYRI	A1YQH5_ORYSJ	437	3
1786768	85224	TSAIRALPEEVLVNAFQI	B5KVH4_CARIL	455	3
1786769	85224	TSAIRALPEEVLVNAFQI	B5KVH5_CARIL	455	3
1786770	85224	SSIFRALPTDVLANAYRI	A1YQG3_ORYSJ	445	3
1786771	85224	SSIFRALPTDVLANAYRI	GLUA2_ORYSJ	445	3
1786772	85224	SSIFRALPTDVLANAYRI	A2Z708_ORYSI	445	3
1786773	85224	NSVFRALPVDVVANAYRI	A2X2Z8_ORYSI	380	3
1786774	85224	NSIFRAMPVDVIANAYRI	A2X399_ORYSI	442	3
1786775	85224	NSIFRAMPVDVIANAYRI	Q0E262_ORYSJ	442	3
1786776	85224	NSIFRAMPVDVIANAYRI	Q0E261_ORYSJ	442	3
1786777	85224	NSIFRAMPVDVIANAYRI	GLUB5_ORYSJ	442	3
1786778	85224	NSIFRAMPVDVIANAYRI	GLUB4_ORYSJ	442	3
1786779	85224	NSIFRAMPVDVIANAYRI	A2X3A0_ORYSI	261	3
1786780	85224	TSAIRALPEEVLATAFQI	Q2TPW5_9ROSI	454	3
1786781	85224	SSIFRALPNDVLANAYRI	A2WVB9_ORYSI	445	3
1786782	85224	SSIFRALPNDVLANAYRI	A1YQG5_ORYSJ	445	3
1786783	85224	SSIFRALPNDVLANAYRI	Q0JJ36_ORYSJ	445	3
1786784	85224	SSIFRALPNDVLANAYRI	GLUA1_ORYSJ	445	3
1786785	85224	SSIFRALPTDVLANAYRI	Q0Z945_9ORYZ	446	3
1786786	85224	NSVLRAMPVDVIANAYRI	A2X2V1_ORYSI	438	3
1786787	85224	NSVLRAMPVDVIANAYRI	Q84X94_ORYSJ	438	3
1786788	85224	SSILRALPIDVLANAYRI	Q38780_AVESA	464	3
1786789	85224	TSVIRAMPEDVLMNSYRI	Q40347_MAGSL	427	3
1786790	85224	TSAIRAMPAEVLANAFRI	B9GS11_POPTR	432	3
1786791	85224	NSVLRAMPVDVIANAYRI	C0L8H1_ORYSJ	437	3
1786792	85224	NSVLRAMPVDVIANAYRI	Q84X93_ORYSJ	438	3
1786793	85224	NSVLRAMPVDVIANAYRI	Q6ESW6_ORYSJ	438	3
1786794	85224	TSILRALPVDVLANAYRI	SSG2_AVESA	456	3
1786795	85224	SSIFRALPNDVLANAYRI	Q40689_ORYSA	445	3
1786796	85224	TSALRAMPAEVLASAFRI	B9H8M5_POPTR	432	3
1786797	85224	NSILRALPDDVVANAYRI	Q0Z870_9ORYZ	454	3
1786798	85224	TSILRALPIDVLANAYRI	Q38779_AVESA	488	3
1786799	85224	TSVLRAIPADVLANAFQL	Q41128_QUERO	438	3
1786800	85224	TSAIRALPDDVLANAFQI	Q8W1C2_CORAV	459	3
1786801	85224	SSILRALPVDVLANAYRI	O49258_AVESA	452	3
1786802	85224	NSIFRALPDDVVANAYRI	B8AKE2_ORYSI	444	3
1786803	85224	NSIFRALPDDVVANAYRI	Q10JA8_ORYSJ	444	3
1786804	85224	NSIFRALPDDVVANAYRI	GLUA3_ORYSJ	444	3
1786805	85224	NSIFRALPDDVVANAYRI	B9F952_ORYSJ	444	3
1786806	85224	TSVLRAIPADVLANAFQL	Q8LK20_CASCR	492	3
1786807	85224	TSILRALPVDVLANAYRI	SSG1_AVESA	456	3
1786808	85224	TSVIRALPEAVLMNAFQI	A1E0V5_FICAW	461	3
1786809	85224	TSYMRALPEDVIVNAYQI	A1E0V7_FICAW	447	3
1786810	85224	TSVLRAMPEEVLANAFQI	B7SLJ1_PISVE	426	3
1786811	85224	TSIIRALPEAVLMNAFQI	A1E0V4_FICAW	463	3
1786812	85224	TSALRGLPADVIANAYQI	Q2XSW6_SESIN	420	3
1786813	85224	TSFMQALPEDVIANAYQI	A1E0V8_FICAW	441	3
1786814	85224	DSVFRALPVDVVANAYRI	B8AEZ0_ORYSI	415	3
1786815	85224	DSVFHALPVDVIANAYCI	A3A527_ORYSJ	415	3
1786816	85224	DSVFHALPVDVIANAYCI	Q6T725_ORYSJ	437	3
1786817	85224	TSAIRAMPVEVISNIYQI	Q06AW1_CHEQI	430	3
1786818	85224	TSAIRAMPVEVISNIYQI	Q6Q384_CHEQI	430	3
1786819	85224	NSILGALPVDVIANAYGI	B2CGM6_WHEAT	521	3
1786820	85224	SSILRALPVNVLANAYRI	O49257_AVESA	409	3
1786821	85224	KQVFRATPAQVLANAFGI	B5U8K2_LOTJA	561	0
1786822	85224	KQVFRATPAEVLSNAFGI	B5U8K1_LOTJA	530	0
1786823	85224	KDVFRAIPSEVLAHSYNL	A3KEY9_GLYSO	514	0
1786824	85224	KDVFRAIPSEVLAHSYNL	Q9SB11_SOYBN	514	0
1786825	85224	KDVFRAIPSEVLAHSYNL	Q9S9D0_SOYBN	514	0
1786826	85224	KDVFRAIPSEVLAHSYNL	Q43452_SOYBN	513	0
1786827	85224	KDVFRAIPSEVLAHSYNL	Q39921_GLYSO	514	0
1786828	85224	KDVFRAIPSEVLAHSYNL	GLYG4_SOYBN	513	0
1786829	85224	TSALRAMPVDVLANAYQI	A0EM47_ACTCH	417	3
1786830	85224	SSILGALPVDVIANAYGI	B2CGM5_WHEAT	521	3
1786831	85224	TSAIRAMPLEVISNIYQI	Q06AW2_CHEQI	431	3
1786832	85224	TSAIRAMPLEVISNIYQI	Q6Q385_CHEQI	431	3
1786833	85224	VSTIRALPDEVVANSFQI	B9N2L2_POPTR	419	3
1786834	85224	VSTIRALPDEVVANSFQI	B9P6C0_POPTR	449	3
1786835	85224	KQVFRGIPAEVLANAFRL	C9WC98_LUPAN	443	0
1786836	85224	LSAFRAIPEEVLRSSFQI	13SB_FAGES	139	3
1786837	85224	QQVFRATPADVLANAFGL	Q41703_VICSA	441	0
1786838	85224	ASAFQGMPEEVLMNSYRI	Q9M4R4_ELAGV	425	3
1786839	85224	VSTIRGLPVEVVANSFQI	B9N2L3_POPTR	447	3
1786840	85224	VSTIRGLPVEVVANSFQI	B9N2L4_POPTR	446	3
1786841	85224	LSALRAIPEEVLRSSFQI	P93079_COFAR	440	3
1786842	85224	ISAIRALPEDLLSNAFRI	A1E0V3_FICAW	459	3
1786843	85224	TSAIRAMPVEVVANAFQV	B9SF37_RICCO	431	3
1786844	85224	LSAFRAIPEEVLRSSFQI	O82437_COFAR	443	3
1786845	85224	LSAFRAIPEEVLRSSFQI	Q9ZNY2_COFAR	443	3
1786846	85224	TSAVRGMPVEVIANAFRV	Q9M4Q8_RICCO	428	3
1786847	85224	TSAIRAMPIEVVANAFQV	B9SF36_RICCO	461	3
1786848	85224	SSAVRGMPVEVIANAFRV	B9SDX6_RICCO	428	3
1786849	85224	NSILRALPVDVIANAYRI	A2X2Z1_ORYSI	424	3
1786850	85224	LSAIRAMPEEVVMTAYQV	Q9AUD2_SESIN	429	3
1786851	85224	ASVLRGLPLDVIQNSFQV	Q39627_CITSI	438	3
1786852	85224	KDVFRAIPSEVLSNSYNL	A3KEY8_GLYSO	476	0
1786853	85224	KDVFRAIPSEVLSNSYNL	Q7GC77_SOYBN	480	0
1786854	85224	KDVFRAIPSEVLSNSYNL	Q39922_GLYSO	480	0
1786855	85224	KDVFRAIPSEVLSNSYNL	P93708_SOYBN	480	0
1786856	85224	KDVFRAIPSEVLSNSYNL	P93707_SOYBN	480	0
1786857	85224	KDVFRAIPSEVLSNSYNL	C0KG62_SOYBN	480	0
1786858	85224	VSAIRSMPEEVVANAFQV	B9T5E7_RICCO	455	3
1786859	85224	ISVMRGLPLDVIQNSFDI	B2KN55_PISVE	426	3
1786860	85224	ISVMRGLPLDVIQNSFDI	B7P074_PISVE	426	3
1786861	85224	KDVFRAIPSEVLAHSYNL	Q1WAB8_9FABA	510	0
1786862	85224	ISAIRAMPEDLLFNAFRI	A1E0V6_FICAW	453	3
1786863	85224	QQVFRATPSEVLANAFGL	LEGJ_PEA	459	0
1786864	85224	NQVFRATPAEVLANVFGL	Q43673_VICFA	520	0
1786865	85224	TSVLRAIPVEVLANSYDI	A9NJG2_FAGTA	459	3
1786866	85224	TSAIRAMPLEVLANAFQV	B9T1B8_RICCO	416	3
1786867	85224	QQVFRATPADVLANAFGL	LEGB4_VICFA	440	0
1786868	85224	VSVFRALPLDVIKNSFDI	B7P073_PISVE	435	3
1786869	85224	TSPLRGIPVGVLANAYRL	Q84ND2_BEREX	418	3
1786870	85224	NSILRALPVDVIANAYRI	Q6K508_ORYSJ	424	3
1786871	85224	VSQMRMLPLGVLSNMYRI	11SB_CUCMA	435	3
1786872	85224	KDVFRLIPSEVLSNSYNL	Q9SB12_SOYBN	480	0
1786873	85224	NSILRALPVDVIANAYRI	Q6T726_ORYSJ	424	3
1786874	85224	NQVFRATPGEVLANAFGL	O24294_PEA	526	0
1786875	85224	ASILRALPVDVVANAYRL	B8AH66_ORYSI	436	3
1786876	85224	ASILRALPVDVVANAYRL	Q9ZWJ8_ORYSA	457	3
1786877	85224	ASILRALPVDVVANAYRL	Q6K7K6_ORYSJ	457	3
1786878	85224	ASILRALPVDVVANAYRL	B9EZT3_ORYSJ	436	3
1786879	85224	TSVLRAIPVEVLANSYDI	13S1_FAGES	516	3
1786880	85224	KDVFRVIPSEVLSNSYNL	GLYG5_SOYBN	479	0
1786881	85224	TSFLRALPDEVLANAYQI	Q43607_PRUDU	506	3
1786882	85224	TSVLRAIPVEVLANSYDI	13S3_FAGES	486	3
1786883	85224	TSAIRSLPIDVVSNIYQI	A2I9A6_AMAHP	437	3
1786884	85224	VSAIRSMPEEVIANAFQV	B9S9Q7_RICCO	343	3
1786885	85224	TSALRALPLEVITNAYQI	Q2TLW0_SINAL	458	3
1786886	85224	TSALRALPLEVLTNAFQI	Q9AXL9_BRANA	438	3
1786887	85224	TSALRGMPVEVIANAFRV	B9SF35_RICCO	429	3
1786888	85224	VSAIRSMPEEVVANAFQV	B9T5E6_RICCO	351	3
1786889	85224	TSALRALPLEVITNAFQI	CRU1_RAPSA	428	3
1786890	85224	TSALRALPLEVITNAFQI	CRU3_BRANA	458	3
1786891	85224	TSVLRGLPLEVISNGYQI	CRU1_BRANA	439	3
1786892	85224	TSVLRGLPLEVISNGYQI	CRUA_BRANA	437	3
1786893	85224	TSAITAIPGEVLANAFGL	Q3HW60_SOYBN	486	3
1786894	85224	TSAITAIPGEVLANAFGL	Q9FEC5_SOYBN	486	3
1786895	85224	TSAITAIPGEVLANAFGL	Q6DR94_SOYBN	486	3
1786896	85224	TSALRALPLEVITNAFQI	Q2TLV9_SINAL	471	3
1786897	85224	TSVMRGLPLEVIANGYQI	CRU2_BRANA	445	3
1786898	85224	TSLLRALPLEVISNGFQI	Q8RX74_ARATH	472	3
1786899	85224	TSLLRALPLEVISNGFQI	Q96318_ARATH	472	3
1786900	85224	NSYMWNLPEDVVANSYGL	AHY3_ARAHY	437	3
1786901	85224	TSVMRGLPLEVITNGYQI	12S2_ARATH	408	3
1786902	85224	TSVMRGLPLEVITNGYQI	Q56WH8_ARATH	131	3
1786903	85224	VSFMRALPEEVVAASYQV	LEGA_GOSHI	463	3
1786904	85224	TSVMRGLPLEVISNGYQI	CRU4_BRANA	415	3
1786905	85224	RSVIRAMPEDVLINSYQL	C0ILQ2_COFCA	344	3
1786906	85224	NSFIDNLPEEVVANSYGL	Q647H4_ARAHY	490	3
1786907	85224	NSFIDNLPEEVVANSYGL	Q6T2T4_ARAHY	490	3
1786908	85224	TSVLRGLPLEVITNGFQI	12S1_ARATH	421	3
1786909	85224	TSVLRAIPVEVLANSYDI	13S2_FAGES	452	3
1786910	85224	NSLLNALPEEVIQHTFNL	GLYG2_SOYBN	439	3
1786911	85224	NSLLNALPEEVIQHTFNL	Q549Z4_SOYBN	439	3
1786912	85224	NSVIDNLPEEVVANSYGL	B5TYU1_ARAHY	484	3
1786913	85224	NSVIDNLPEEVVANSYGL	Q5I6T2_ARAHY	484	3
1786914	85224	NSFIDNLPEEVVANSYGL	A1DZF0_ARAHY	483	3
1786915	85224	NSLLNALPEEVIQQTFNL	GLYG3_SOYBN	435	3
1786916	85224	NSLLNALPEEVIQQTFNL	Q852U5_SOYBN	435	3
1786917	85224	NSFIDNLPEEVVANSYGL	Q8LKN1_ARAHY	492	3
1786918	85224	NSIIDNLPEEVVANSYGL	Q647H3_ARAHY	491	3
1786919	85224	NSLLNALPEEVIQQTFNL	Q852U4_SOYBN	436	3
1786920	85224	NSLLNALPEEVIQHTFNL	GLYG1_SOYBN	449	3
1786921	85224	LSAIRAMPDEVVMNAFGV	Q2XSW7_SESIN	446	3
1786922	85224	SSVINNLPLDVVAATFNL	LEGA2_PEA	474	3
1786923	85224	SSVINNLPLDVVAATFNL	Q9T0P5_PEA	471	3
1786924	85224	SSVINNLPLDVVAATFNL	LEGA_PEA	471	3
1786925	85224	NSIIDNLPEEVVANSYGL	Q9FZ11_ARAHY	483	3
1786926	85224	NSVLNGIPEDVLVNAYQL	P93559_SAGSA	531	3
1786927	85224	TSYLRAVPVDVIKASYGV	Q9ZWA9_ARATH	409	3
1786928	85224	NSLLSDLPVGVIASSYGV	C5YY38_SORBI	430	3
1786929	85224	SSVINDMPVDVVAATFNL	Q99304_VICFA	454	3
1786930	85224	SSVINDLPLDVVAATFNL	Q41676_VICNA	436	3
1786931	85224	NSIIDNLPEEVVANSYRL	Q0GM57_ARAHY	465	3
1786932	85224	SSVIDDLPLDVVAATFNM	Q41702_VICSA	452	3
1786933	85224	VSVIKSMPEKVIANAFQV	B9SW16_RICCO	437	3
1786934	85224	SSALRGMPADVLANAFGV	A2YQV0_ORYSI	465	3
1786935	85224	GSAINALPDDLLANAYGL	P93560_SAGSA	745	3
1786936	85224	NSVLSDLPAAVIASSYAI	Q946V2_MAIZE	429	3
1786937	85224	NSVLSDLPAAVIASSYAI	Q948J8_MAIZE	428	3
1786938	85224	RSTLKAMPVDVLANSFQI	Q38698_ASAEU	417	3
1786939	85224	SSALRGMPADVLDNAFGV	A3BP99_ORYSJ	464	3
1786940	85224	SSALRGMPADVLDNAFGV	Q6ZK46_ORYSJ	469	3
1786941	85224	TSEIQAMPLEVIQNAFNL	B5U8K6_LOTJA	429	3
1786942	85224	NSEISALPLEVVAHAFNL	Q53I54_LUPAL	466	3
1786943	85224	TSTIKGMPLEVLTNAYQV	Q40348_MAGSL	429	3
1786944	85224	NSVLKAMPQEVVMNAYRI	Q39770_GINBI	411	3
1786945	85224	NSVLKAMPQEVVMNAYNI	O04689_METGY	452	3
1786946	85224	QSVLKAMPEEVLSAAYRM	Q40870_PICGL	450	3
1786947	85224	NSVLKAMPQEVVMNAYNI	Q39521_CRYJA	463	3
1786948	85224	NSVLKAMPQEVVMNAYNI	O04691_METGY	454	3
1786949	85224	ESVLKAMPEDVVSAAYRM	Q40933_PSEMZ	454	3
1786950	85224	TSAIKGMPIQVLTNSYRI	Q38697_ASAEU	414	3
1786951	85224	ISVMRAMPIDVISNAYQI	B9H8M2_POPTR	418	3
1786952	85224	NSLIQSMPRQVVAATCGI	Q39775_GNEGN	508	3
1786953	85225	ELSNEERNLLSVAYKNVVGARRSSWRVISS	1433_DROME	38	38
1786954	85225	ELSNEERNLLSVAYKNVVGARRSSWRVISS	143B_HUMAN	35	35
1786955	85225	ELSNEERNLLSVAYKNVVGARRSSWRVVSS	143Z_BOVIN	35	35
1786956	85225	ELSVEERNLLSVAYKNVIGARRASWRIVSS	BMH1_YEAST	37	37
1786957	85225	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_HORVU	42	42
1786958	85225	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_ORYSA	42	42
1786959	85225	ELSCEERNLLSVAYKNVVGGQRAAWRVLSS	143S_HUMAN	35	35
1786960	85226	YRERVEKELREICYEVLGLLDKYLI	1433_DROME	85	17
1786961	85226	YREKIEAELQDICNDVLELLDKYLI	143B_HUMAN	82	17
1786962	85226	YREKIETELRDICNDVLSLLEKFLI	143Z_BOVIN	82	17
1786963	85226	YRSKIETELTKISDDILSVLDSHLI	BMH1_YEAST	87	20
1786964	85226	YRTRIETELSKICDGILKLLDSHLV	1433_HORVU	91	19
1786965	85226	YRSRIETELSKICDGILKLLDSHLV	1433_ORYSA	91	19
1786966	85226	YREKVETELQGVCDTVLGLLDSHLI	143S_HUMAN	84	19
1786967	85227	ESKVFYLKMKGDYYRYLAEVATG	1433_DROME	116	6
1786968	85227	ESKVFYLKMKGDYFRYLSEVASG	143B_HUMAN	113	6
1786969	85227	ESKVFYLKMKGDYYRYLAEVAAG	143Z_BOVIN	113	6
1786970	85227	ESKVFYYKMKGDYHRYLAEFSSG	BMH1_YEAST	118	6
1786971	85227	ESKVFYLKMKGDYHRYLAEFKAG	1433_HORVU	122	6
1786972	85227	ESNVFYLKMKGDYHRYLAEFKSG	1433_ORYSA	122	6
1786973	85227	ESRVFYLKMKGDYYRYLAEVATG	143S_HUMAN	115	6
1786974	85228	AYQDAFDISKGKMQPTHPIRLGLALNF	1433_DROME	151	12
1786975	85228	AYQEAFEISKKEMQPTHPIRLGLALNF	143B_HUMAN	148	12
1786976	85228	AYQEAFEISKKEMQPTHPIRLGLALNF	143Z_BOVIN	148	12
1786977	85228	AYKTASEIATTELPPTHPIRLGLALNF	BMH1_YEAST	153	12
1786978	85228	AYKSAQDIALADLPTTHPIRLGLALNF	1433_HORVU	157	12
1786979	85228	AYKSAQDIALADLPTTHPIRLGLALNL	1433_ORYSA	157	12
1786980	85228	AYQEAMDISKKEMPPTNPIRLGLALNF	143S_HUMAN	150	12
1786981	85229	SVFYYEILNSPDKACQLAKQAFDDAIA	1433_DROME	178	0
1786982	85229	SVFYYEILNSPEKACSLAKTAFDEAIA	143B_HUMAN	175	0
1786983	85229	SVFYYEILNSPEKACSLAKTAFDEAIA	143Z_BOVIN	175	0
1786984	85229	SVFYYEIQNSPDKACHLRKQAFDDAIA	BMH1_YEAST	180	0
1786985	85229	SVFYYEILNSPDRACNLAKQAFDEAIA	1433_HORVU	184	0
1786986	85229	SVFYYEILNSPDRACNLAKQAFDDAIA	1433_ORYSA	184	0
1786987	85229	SVFHYEIANSPEEAISLAKTTFDEAMA	143S_HUMAN	177	0
1786988	85230	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	1433_DROME	205	0
1786989	85230	ELDTLNEESYKDSTLIMQLLRDNLTLWTSE	143B_HUMAN	202	0
1786990	85230	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143Z_BOVIN	202	0
1786991	85230	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	BMH1_YEAST	207	0
1786992	85230	ELDSLGEESYKDSTLIMQLLRDNLTLWTSD	1433_HORVU	211	0
1786993	85230	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1433_ORYSA	211	0
1786994	85230	DLHTLSEDSYKDSTLIMQLLRDNLTLWTAD	143S_HUMAN	204	0
1786995	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143B_TOBAC	38	38
1786996	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_LYCES	43	43
1786997	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	P93786	42	42
1786998	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143O_ARATH	39	39
1786999	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	P93785	37	37
1787000	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1435_SOLTU	40	40
1787001	85231	ELSVEERNLLSVAYKNVIGARRASWRIISS	1433_MESCR	41	41
1787002	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	O49082	42	42
1787003	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143C_TOBAC	42	42
1787004	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143H_ARATH	45	45
1787005	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143A_VICFA	42	42
1787006	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143E_TOBAC	40	40
1787007	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	O24221	43	43
1787008	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	O24001	43	43
1787009	85231	ELTIEERNLLSVAYKNVIGARRASWRIISS	O65352	43	43
1787010	85231	ELTVEERNLLSVAYKNVIGARRASWRIVSS	O24222	37	37
1787011	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143A_SOYBN	40	40
1787012	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_PEA	42	42
1787013	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1431_MAIZE	42	42
1787014	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_SOLTU	38	38
1787015	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143N_ARATH	39	39
1787016	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1432_MAIZE	42	42
1787017	85231	ELTIEERNLLSVAYKNVIGARRASWRIISS	143F_TOBAC	40	40
1787018	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_OENHO	42	42
1787019	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143U_ARATH	41	41
1787020	85231	ELTVEERNLLSVAYKNVIGARTLAWRIISS	1432_LYCES	37	37
1787021	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1435_LYCES	39	39
1787022	85231	ELTVEERILLSVAYKNVMGARRASWRIISS	1436_LYCES	40	40
1787023	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143C_ARATH	44	44
1787024	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143B_HORVU	43	43
1787025	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1434_LYCES	40	40
1787026	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	O24223	46	46
1787027	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143A_HORVU	42	42
1787028	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1434_SOLTU	38	38
1787029	85231	ELTIEERNLLSVAYKNVIGARRASWRIISS	143A_TOBAC	38	38
1787030	85231	ELSVEERNLLSVAYKNVIGARRASWRIISS	143P_ARATH	38	38
1787031	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_ORYSA	42	42
1787032	85231	ELSVEERNLLSVAYKNVIGARRASWRIISS	1433_CHLRE	39	39
1787033	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	143E_HUMAN	36	36
1787034	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	O57468	36	36
1787035	85231	ELSVEERNLLSVAYKNVIGARRASWRIVSS	BMH1_YEAST	36	36
1787036	85231	ELSVEERNLLSVAYKNVIGARRASWRIVSS	BMH2_YEAST	36	36
1787037	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	1433_DICDI	35	35
1787038	85231	ELTVEERNLLSVAYKNVIGARRASWRIVSS	RA24_SCHPO	38	38
1787039	85231	ELTVEERNLLSVAYKNVIGSLRAAWRIVSS	143L_ARATH	42	42
1787040	85231	ELTVEERNLLSVAYKNVIGSLRAAWRIVSS	143R_ARATH	42	42
1787041	85231	ELTVEERNLLSVAYKNVIGARRASWRIITS	143E_DROME	36	36
1787042	85231	ELTVEERNLLSVAYKNVIGARRASWRIISS	Q39558	42	42
1787043	85231	ELTVEERNLLSVAYKNVIGSLRAAWRIVSS	P93787	43	43
1787044	85231	ELSNEERNLLSVAYKNVVGARRSSWRVVSS	143Z_HUMAN	35	35
1787045	85231	ELSNEERNLLSVAYKNVVGARRSSWRVVSS	143Z_SHEEP	35	35
1787046	85231	ELSNEERNLLSVAYKNVVGARRSSWRVVSS	143Z_MOUSE	35	35
1787047	85231	ELTVEERNLLSGAYKNVIGSLRAAWRIVSS	143K_ARATH	42	42
1787048	85231	ELSNEERNLLSVAYKNVVGARRSSWRVVSS	O57469	35	35
1787049	85231	ELTVEERNLLSVAYKNVIGSLRAAWRIVSS	143D_TOBAC	43	43
1787050	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	143B_HUMAN	36	36
1787051	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	O70455	37	37
1787052	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	143B_BOVIN	36	36
1787053	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	143B_RAT	36	36
1787054	85231	ELTVEERNLLSVAYKNVIGSLRAAWRIVSS	1431_LYCES	43	43
1787055	85231	DLTVEERNLLSVAYKNVIGARRASWRIVTS	1433_TRIHA	35	35
1787056	85231	ELTVEERNLLSVGYKNVIGARRASWRILSS	O49152	39	39
1787057	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	1434_CAEEL	37	37
1787058	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	143Z_DROME	38	38
1787059	85231	ELTIEERNLLSVGYKNVIGARRASWRILSS	143B_VICFA	39	39
1787060	85231	ELTVEERNLLSVGYKNVIGARRASWRILSS	143D_SOYBN	39	39
1787061	85231	ELSVEERNLLSVAYKNVIGARRASWRIVSS	1433_CANAL	37	37
1787062	85231	KLSVEERNLLSVAYKNIIGARRASWRIISS	RA25_SCHPO	37	37
1787063	85231	ELSNEERNLLSVAYKNVVGGRRSAWRVISS	143T_HUMAN	35	35
1787064	85231	ELSNEERNLLSVAYKNVVGGRRSAWRVISS	143T_RAT	35	35
1787065	85231	ELSNEERNLLSVAYKNVVGARRSSWRVISS	1433_CAEEL	37	37
1787066	85231	PLSNEDRNLLSVAYKNVVGARRSSWRVISS	143F_HUMAN	35	35
1787067	85231	PLSNEDRNLLSVAYKNVVGARRSSWRVISS	143F_MOUSE	35	35
1787068	85231	ELTVEERNLLSVGYKNVVGARRASWRILSS	143C_SOYBN	39	39
1787069	85231	PLSNEERNLLSVAYKNVVGARRSSWRVISS	143G_BOVIN	35	35
1787070	85231	PLSNEERNLLSVAYKNVVGARRSSWRVISS	O70457	36	36
1787071	85231	PLSNEERNLLSVAYKNVVGARRSSWRVISS	143G_RAT	35	35
1787072	85231	DLTVEERNLLSVGYKNVIGSRRASWRIFSS	143M_ARATH	39	39
1787073	85231	DLTVEERNLLSVGYKNVIGSRRASWRIFSS	O80367	39	39
1787074	85231	ELTVEERNLVSVGYKNVIGARRASWRILSS	143E_ARATH	37	37
1787075	85231	ELSNEERNLLSVAYKNVVGARRSSWRVVSS	143Z_XENLA	35	35
1787076	85231	ELSCEERNLLSVAYKNVVGGQRAAWRVLSS	O70456	35	35
1787077	85231	ELSCEERNLLSVAYKNVVGGQRAAWRVLSS	143S_HUMAN	35	35
1787078	85231	ELTVEERNLLSVAYKNAVGARRASWRIISS	O61131	48	48
1787079	85231	ELSCEERNLLSVAYKNVVGGQRAAWRVLSS	O77642	35	35
1787080	85231	ELSVEERNLLSVAYKNAVGARRASWRIISS	O60955	48	48
1787081	85231	ELSIEERNLLSVAYKNVIGAKRASWRIISS	1431_ENTHI	36	36
1787082	85231	ELSVEERNLLSVAYKNVIGSRRASWRVISS	1433_FUCVE	36	36
1787083	85231	ELSVEERNLLSVAYKNAVGARRASWRIISS	1433_NEOCA	48	48
1787084	85231	ELSVEERNLISVAYKNVVGSRRASWRIISS	1432_ENTHI	36	36
1787085	85231	ELNNEERNLLSVAYKNVLGARRSSWRIMSS	Q24902	45	45
1787086	85231	NLGNEERNLLSVAYKNVVGARRSAWRVIHG	1431_SCHMA	46	46
1787087	85232	YRSKIESELSNICDGILKLLDSCLI	143B_TOBAC	87	19
1787088	85232	YRSKIENELSKICDGILKLLDSKLI	1433_LYCES	92	19
1787089	85232	YRSKIENELSKICDGILKLLDSKLI	P93786	91	19
1787090	85232	YRSKIETELSGICDGILKLLDSRLI	143O_ARATH	88	19
1787091	85232	YRSKIESELSNICDGILKLLDSNLI	P93785	86	19
1787092	85232	YRSKIESELTSICNGILKLLDSKLI	1435_SOLTU	89	19
1787093	85232	YRGKIETELSKICDGILNLLESHLI	1433_MESCR	90	19
1787094	85232	YRGKIEAELSKICDGILKLLDSHLV	O49082	91	19
1787095	85232	YRSKIENELSKICDGILKLLDAKLI	143C_TOBAC	91	19
1787096	85232	YRSKIESELSKICDGILKLLDTRLV	143H_ARATH	94	19
1787097	85232	YRSKIETELSNICNGILKLLDSRLI	143A_VICFA	91	19
1787098	85232	YRGKIEAELSKICDGILNLLESHLI	143E_TOBAC	89	19
1787099	85232	YRGKIETELTKICDGILKLLESHLV	O24221	92	19
1787100	85232	YRGKIETELSKICDGILKLLETHLV	O24001	92	19
1787101	85232	YRSKIESELSSICDGILKVLDSKLI	O65352	92	19
1787102	85232	YRGKIEAELSKICDGILKLLDSHLV	O24222	86	19
1787103	85232	YRGKIEAELSKICDGILNLLESNLI	143A_SOYBN	89	19
1787104	85232	YRSKIESELSNICDGILKLLDTRLI	1433_PEA	91	19
1787105	85232	YRGKIETELTKICDGILKLLETHLV	1431_MAIZE	91	19
1787106	85232	YRVKIEAELSKICDGILSLLESHLV	1433_SOLTU	87	19
1787107	85232	YRGKIETELSKICDGILNLLDSHLV	143N_ARATH	88	19
1787108	85232	YRGKIETELTKICDGILKLLESHLV	1432_MAIZE	91	19
1787109	85232	YRSKIESELTSICNGILKLLDSNLI	143F_TOBAC	89	19
1787110	85232	YRSKIETELSNICGGILKLLDSRLI	1433_OENHO	91	19
1787111	85232	YRGKIETELSKICDGILNLLEAHLI	143U_ARATH	90	19
1787112	85232	YRSKIESELSDICDGILKLLDSNLI	1432_LYCES	86	19
1787113	85232	YRSQIENELTSICNGILKLLDSKLI	1435_LYCES	88	19
1787114	85232	YRSKIESELTSICNGILKLLDSKLI	1436_LYCES	89	19
1787115	85232	YRSKIETELSDICDGILKLLDTILV	143C_ARATH	93	19
1787116	85232	YRGKIEVELTKICDGILKLLDSHLV	143B_HORVU	92	19
1787117	85232	YRSKIEADLSKICDGILSLLESNLI	1434_LYCES	89	19
1787118	85232	YRGKIEAELARICDGILALLDSHLV	O24223	95	19
1787119	85232	YRTRIETELSKICDGILKLLDSHLV	143A_HORVU	91	19
1787120	85232	YRSQIENELTSICNGILKLLDSKLI	1434_SOLTU	87	19
1787121	85232	YRSKIESELTSICNGILKLLDSKLI	143A_TOBAC	87	19
1787122	85232	YRGEIESELSKICDGILNVLEAHLI	143P_ARATH	87	19
1787123	85232	YRSRIETELSKICDGILKLLDSHLV	1433_ORYSA	91	19
1787124	85232	YRTVVEEELSKICASILQLLDDHLI	1433_CHLRE	88	19
1787125	85232	YRQMVETELKLICCDILDVLDKHLI	143E_HUMAN	85	19
1787126	85232	YRQMVETELKSICNDILDVLDKHLI	O57468	85	19
1787127	85232	YRSKIETELTKISDDILSVLDSHLI	BMH1_YEAST	86	20
1787128	85232	YRSKIETELTKISDDILSVLDSHLI	BMH2_YEAST	86	20
1787129	85232	YKCKVEKELTDICNDILEVLESHLI	1433_DICDI	84	19
1787130	85232	YRQKIEQELDTICQDILTVLEKHLI	RA24_SCHPO	87	19
1787131	85232	YRSKVESELSSVCSGILKLLDSHLI	143L_ARATH	91	19
1787132	85232	YRSKVESELSSVCSGILKLLDSHLI	143R_ARATH	91	19
1787133	85232	YRGQVEKELRDICSDILNVLEKHLI	143E_DROME	85	19
1787134	85232	YRSKIETELSNICGFRILNLLDSRL	Q39558	91	19
1787135	85232	YRSKVESELSDVCAGILKILDQYLI	P93787	92	19
1787136	85232	YREKIETELRDICNDVLSLLEKFLI	143Z_HUMAN	82	17
1787137	85232	YREKIETELRDICNDVLSLLEKFLI	143Z_SHEEP	82	17
1787138	85232	YREKIETELRDICNDVLSLLEKFLI	143Z_MOUSE	82	17
1787139	85232	YRSKVETELSSIFSGILRLLDSHLI	143K_ARATH	91	19
1787140	85232	YREKIEAELREICNDVLNLLDKFLI	O57469	82	17
1787141	85232	YRSKVESELSDVCAGILKILDQYLI	143D_TOBAC	92	19
1787142	85232	YREKIEAELQDICNDVLELLDKYLI	143B_HUMAN	83	17
1787143	85232	YREKIEAELQDICNDVLELLDKYLI	O70455	84	17
1787144	85232	YREKIEAELQDICNDVLQLLDKYLI	143B_BOVIN	83	17
1787145	85232	YREKIEAELQDICSDVLELLDKYLI	143B_RAT	83	17
1787146	85232	YRSKVESELSDVCAGILKILDQYLI	1431_LYCES	92	19
1787147	85232	YRQKIENELAKICDDILEVLDQHLI	1433_TRIHA	84	19
1787148	85232	YRQKVESELTNICNDVMRVIDEHLI	O49152	88	19
1787149	85232	YREKVEKELRDICQDVLNLLDKFLI	1434_CAEEL	84	17
1787150	85232	YRERVEKELREICYEVLGLLDKYLI	143Z_DROME	85	17
1787151	85232	YRHKVETELSNICIDVMRVIDEHLI	143B_VICFA	88	19
1787152	85232	YRQKVELELSNICNDVMRVIDEHLI	143D_SOYBN	88	19
1787153	85232	YRAKIEAELSKICEDILSVLSDHLI	1433_CANAL	86	19
1787154	85232	YRKKIEDELSDICHDVLSVLEKHLI	RA25_SCHPO	86	19
1787155	85232	YREKVESELRSICTTVLELLDKYLI	143T_HUMAN	82	17
1787156	85232	YREKVESELRSICTTVLELLDKYLI	143T_RAT	82	17
1787157	85232	YRVKVEQELNDICQDVLKLLDEFLI	1433_CAEEL	84	17
1787655	85246	CATCKVQV	DMPP_PSEPU	41	-1
1787158	85232	YREKIEKELETVCNDVLSLLDKFLI	143F_HUMAN	84	19
1787159	85232	YREKIEKELETVCNDVLALLDKFLI	143F_MOUSE	84	19
1787160	85232	YRLKVESELSNICSDIMTVIDEYLI	143C_SOYBN	88	19
1787161	85232	YREKIEKELEAVCQDVLSLLDNYLI	143G_BOVIN	84	19
1787162	85232	YREKIEKELEAVCQDVLSLLDNYLI	O70457	85	19
1787163	85232	YREKIEKELEAVCQDVLSLLDNYLI	143G_RAT	84	19
1787164	85232	YMEKVELELSNICIDIMSVLDEHLI	143M_ARATH	88	19
1787165	85232	YMEKVELELSNICIDIMSVLDEHLI	O80367	88	19
1787166	85232	YRKRVEDELAKVCNDILSVIDKHLI	143E_ARATH	86	19
1787167	85232	YREKIEAELREICNDVLNLLDKFLI	143Z_XENLA	82	17
1787168	85232	YREKVETELRGVCDTVLGLLDSHLI	O70456	84	19
1787169	85232	YREKVETELQGVCDTVLGLLDSHLI	143S_HUMAN	84	19
1787170	85232	YRKKVEEELNNICQDILNLLTKKLI	O61131	97	19
1787171	85232	YREKVETELRGVCDTVLGLLDTHLI	O77642	84	19
1787172	85232	YRQKVEEELNKICHDILQLLTDKLI	O60955	97	19
1787173	85232	YRAKIEKELSTCCDDVLKVIQENLL	1431_ENTHI	85	19
1787174	85232	YKSKIETELTDICADILKIIEAELI	1433_FUCVE	82	16
1787175	85232	YRQKVEEELNKICHDILQLLTDKLI	1433_NEOCA	97	19
1787176	85232	YRAKIEQELSQKCDDVLKIITEFLL	1432_ENTHI	85	19
1787177	85232	YLKKVEEELIPICNDVLALPVLPIT	Q24902	91	16
1787178	85232	YRIKMEKELNTICNQVLALLEDYLL	1431_SCHMA	93	17
1787179	85233	DSKVFYLKMKGDYHRYLAEFKTG	143B_TOBAC	118	6
1787180	85233	DSKVFYLKMKGDYHRYLAEFKTG	1433_LYCES	123	6
1787181	85233	DSKVFYLKMKGDYHRYLAEFKTG	P93786	122	6
1787182	85233	DSKVFYLKMKGDYHRYLAEFKTG	143O_ARATH	119	6
1787183	85233	DSKVFYLKMKGDYHRYLAEFKTG	P93785	117	6
1787184	85233	DSKVFYLKMKGDYHRYLAEFKTG	1435_SOLTU	120	6
1787185	85233	ESKVFYLKMKGDYHRYLAEFKTG	1433_MESCR	121	6
1787186	85233	ESKVFYLKMKGDYHRYLAEFKSG	O49082	122	6
1787187	85233	DSKVFYLKMKGDYHRYLAEFKTG	143C_TOBAC	122	6
1787188	85233	DSKVFYLKMKGDYHRYLAEFKTG	143H_ARATH	125	6
1787189	85233	DSKVFYLKMKGDYHRYLAEFKSG	143A_VICFA	122	6
1787190	85233	ESKVFYLKMKGDYHRYLAEFKTG	143E_TOBAC	120	6
1787191	85233	ESKVFYLKMKGDYYRYLAEFKTG	O24221	123	6
1787192	85233	ESKVFYLKMKGDYYRYLAEFKSG	O24001	123	6
1787193	85233	DSKVFYLKMKGDYYRYLAEFKTG	O65352	123	6
1787194	85233	ESKVFYLKMKGDYHRYLAEFKTG	O24222	117	6
1787195	85233	ESKVFYLKMKGDYHRYLAEFKTG	143A_SOYBN	120	6
1787196	85233	DSKVFYLKMKGDYHRYLAEFKTG	1433_PEA	122	6
1787197	85233	ESKVFYLKMKGDYYRYLAEFKTG	1431_MAIZE	122	6
1787198	85233	ESKVFYLKMKGDYHRYLAEFKTG	1433_SOLTU	118	6
1787199	85233	ESKVFYLKMKGDYHRYLAEFKTG	143N_ARATH	119	6
1787200	85233	ESKVFYLKMKGDYYRYLAEFKTG	1432_MAIZE	122	6
1787201	85233	DSKVFYLKMKGDYHRYLAEFKTG	143F_TOBAC	120	6
1787202	85233	DSKVFYLKMKGDYHRYLAEFKTG	1433_OENHO	122	6
1787203	85233	ESKVFYLKMKGDYHRYLAEFKTG	143U_ARATH	121	6
1787204	85233	DSKVFYLKMKGDYHRYLAEFKTG	1432_LYCES	117	6
1787205	85233	DSKVFYLKMKGDYYRYLAEFKTG	1435_LYCES	119	6
1787206	85233	DSKVFYLKMKGDYHRYLAEFKTG	1436_LYCES	120	6
1787207	85233	DSKVFYLKMKGDYHRYLAEFKSG	143C_ARATH	124	6
1787208	85233	ESKVFYLKMKGDYYRYLAEFKSG	143B_HORVU	123	6
1787209	85233	ESKVFHLKMKGDYHRYLAEFKTG	1434_LYCES	120	6
1787210	85233	ESKVFYLKMKGDYHRYLAEFKSG	O24223	126	6
1787211	85233	ESKVFYLKMKGDYHRYLAEFKAG	143A_HORVU	122	6
1787212	85233	DSKVFYLKMKGDYYRYLAEFKTG	1434_SOLTU	118	6
1787213	85233	DSKVFYLKMKGDYYRYLAEFKTG	143A_TOBAC	118	6
1787214	85233	ESKVFYLKMKGDYHRYLAEFKAG	143P_ARATH	118	6
1787215	85233	ESNVFYLKMKGDYHRYLAEFKSG	1433_ORYSA	122	6
1787216	85233	ESKVFYLKMKGDYHRYLAEFKTG	1433_CHLRE	119	6
1787217	85233	ESKVFYYKMKGDYHRYLAEFATG	143E_HUMAN	116	6
1787218	85233	ESKVFYYKMKGDYHRYLAEFAQG	O57468	116	6
1787219	85233	ESKVFYYKMKGDYHRYLAEFSSG	BMH1_YEAST	117	6
1787220	85233	ESKVFYYKMKGDYHRYLAEFSSG	BMH2_YEAST	117	6
1787221	85233	ESKVFYYKMKGDYFRYLAEFATG	1433_DICDI	115	6
1787222	85233	ESKVFYYKMKGDYYRYLAEFAVG	RA24_SCHPO	118	6
1787223	85233	ESKVFYLKMKGDYHRYMAEFKSG	143L_ARATH	122	6
1787224	85233	ESKVFYLKMKGDYHRYMAEFKSG	143R_ARATH	122	6
1787225	85233	ESKVFYYKMKGDYHRYLAEFATG	143E_DROME	116	6
1787226	85233	DSKVFYLKMKGDYHRYLAEFKTG	Q39558	123	7
1787227	85233	ESKVFYLKMKGDYYRYLAEFKVG	P93787	123	6
1787228	85233	ESKVFYLKMKGDYYRYLAEVAAG	143Z_HUMAN	113	6
1787229	85233	ESKVFYLKMKGDYYRYLAEVAAG	143Z_SHEEP	113	6
1787230	85233	ESKVFYLKMKGDYYRYLAEVAAG	143Z_MOUSE	113	6
1787231	85233	ESKVFYLKMKGDYHRYLAEFKSG	143K_ARATH	122	6
1787232	85233	ESKVFYLKMKGDYYRYLAEVAAG	O57469	113	6
1787233	85233	ESKVFYLKMKGDYYRYLAEFKVG	143D_TOBAC	123	6
1787234	85233	ESKVFYLKMKGDYFRYLSEVASG	143B_HUMAN	114	6
1787235	85233	ESKVFYLKMKGDYFRYLSEVASG	O70455	115	6
1787236	85233	ESKVFYLKMKGDYFRYLSEVASG	143B_BOVIN	114	6
1787237	85233	ESKVFYLKMKGDYFRYLSEVASG	143B_RAT	114	6
1787238	85233	ESKVFYLKMKGDYYRYLAEFKVG	1431_LYCES	123	6
1787239	85233	ESKVFYHKIKGDYHRYLAEFAIG	1433_TRIHA	115	6
1787240	85233	ESTVFYYKMKGDYYRYLAEFKTG	O49152	119	6
1787241	85233	ESKVFYLKMKGDYYRYLAEVASG	1434_CAEEL	115	6
1787242	85233	ESKVFYLKMKGDYYRYLAEVATG	143Z_DROME	116	6
1787243	85233	ESTVFYYKMKGDYYRYLAEFKTG	143B_VICFA	119	6
1787244	85233	ESTVFYYKMKGDYYRYLAEFKSG	143D_SOYBN	119	6
1787245	85233	ESKVFYYKMKGDYHRYLAEFAIA	1433_CANAL	117	6
1787246	85233	ESKVFYYKMKGDYYRYLAEFTVG	RA25_SCHPO	117	6
1787247	85233	ESKVFYLKMKGDYFRYLAEVACG	143T_HUMAN	113	6
1787248	85233	ESKVFYLKMKGDYFRYLAEVACG	143T_RAT	113	6
1787249	85233	ESKAFYLKMKGDYYRYLAEVASE	1433_CAEEL	115	6
1787250	85233	ESKVFYLKMKGDYYRYLAEVASG	143F_HUMAN	117	8
1787251	85233	ESKVFYLKMKGDYYRYLAEVASG	143F_MOUSE	117	8
1787252	85233	EPSVFFYKMKGDYYRYLAEFKSG	143C_SOYBN	119	6
1787253	85233	ESKVFYLKMKGDYYRYLAEVATG	143G_BOVIN	117	8
1787254	85233	ESKVFYLKMKGDYYRYLAEVATG	O70457	118	8
1787255	85233	ESKVFYLKMKGDYYRYLAEVATG	143G_RAT	117	8
1787256	85233	ESTVFFNKMKGDYYRYLAEFKSG	143M_ARATH	119	6
1787257	85233	ESTVFFNKMKGDYYRYLAEFKSG	O80367	119	6
1787258	85233	ESTVFFYKMKGDYYRYLAEFSSG	143E_ARATH	117	6
1787259	85233	ESKVFYLKMKGDYYRYLAEVAAG	143Z_XENLA	113	6
1787260	85233	ESRVFYLKMKGDYYRYLAEVATG	O70456	115	6
1787261	85233	ESRVFYLKMKGDYYRYLAEVATG	143S_HUMAN	115	6
1787262	85233	ESKVFYYKMKGDYYRYISEFSCD	O61131	128	6
1787263	85233	ESRVFYLKMKGDYYRYLAEVATG	O77642	115	6
1787264	85233	ESKVFYYKMKGDYYRYISEFSGE	O60955	128	6
1787265	85233	ESKVFFKKMEGDYYRYFAEFTVD	1431_ENTHI	116	6
1787266	85233	EGKVFYYKMKGDYHRYLAEFQSA	1433_FUCVE	113	6
1787267	85233	ESKVFYYKMKGDYYRYISEFSGE	1433_NEOCA	128	6
1787268	85233	ESKVFFKKMEGDYYRYYAEFTVD	1432_ENTHI	116	6
1787269	85233	EAKIFYYKMMGDYYRYLAEVQEG	Q24902	121	5
1787270	85233	DSKVFFLKMQGDYYRYLAEVATD	1431_SCHMA	124	6
1787271	85234	AYKAAQDIANAELAPTHPIRLGLALNF	143B_TOBAC	153	12
1787272	85234	AYKAAQDIASAELAPTHPIRLGLALNF	1433_LYCES	158	12
1787273	85234	AYKAAQDIASAELAPTHPIRLGLALNF	P93786	157	12
1787274	85234	AYKSAQDIANAELAPTHPIRLGLALNF	143O_ARATH	154	12
1787275	85234	AYKAAQDIANTELAPTHPIRLGLALNF	P93785	152	12
1787276	85234	AYKAAQDIANAELAPTHPIRLGLALNF	1435_SOLTU	155	12
1787277	85234	AYKSAQDIALAELAPTHPIRLGLALNF	1433_MESCR	156	12
1787278	85234	AYKSAQDIALAELAPTHPIRLGLALNF	O49082	157	12
1787279	85234	AYKAAQDIATTELAPTHPIRLGLALNF	143C_TOBAC	157	12
1787280	85234	AYKAAQDIANAELAPTHPIRLGLALNF	143H_ARATH	160	12
1787281	85234	AYKSAQDIANTELPPTHPIRLGLALNF	143A_VICFA	157	12
1787282	85234	AYKSAQDIALAELAPTHPIRLGLALNF	143E_TOBAC	155	12
1787283	85234	AYKAAQDIALAELPPTHPIRLGLALNF	O24221	158	12
1787284	85234	AYKAAQDIALAELAPTHPIRLGLALNF	O24001	158	12
1787285	85234	AYKAAQDIANAELAPTHPIRLGLALNF	O65352	158	12
1787286	85234	AYKAAQDIALADLAPTHPIRLGLALNF	O24222	152	12
1787287	85234	AYKSAQDIALADLAPTHPIRLGLALNF	143A_SOYBN	155	12
1787288	85234	GYKSAQDIANAELPPTHPIRLGLALNF	1433_PEA	157	12
1787289	85234	AYKAAQDIALAELAPTHPIRLGLALNF	1431_MAIZE	157	12
1787290	85234	AYKSAQDIALAELTPTHPIRLGLALNF	1433_SOLTU	154	13
1787291	85234	AYKSAQDIALADLAPTHPIRLGLALNF	143N_ARATH	154	12
1787292	85234	AYKAAQDIALAELAPTHPIRLGLALNF	1432_MAIZE	157	12
1787293	85234	SYKSAQDIANAELAPTHPIRLGLALNF	143F_TOBAC	155	12
1787294	85234	AYKAAQDIANAELAPTHPIRLGLALNF	1433_OENHO	157	12
1787295	85234	AYKSAQDIALADLAPTHPIRLGLALNF	143U_ARATH	156	12
1787296	85234	AYKAAQDIANTELAPTHPIRLGLALNF	1432_LYCES	152	12
1787297	85234	AYKSAQDIANGELAPTHPIRLGLALNF	1435_LYCES	154	12
1787298	85234	AYKAAQDIANAELAPTHPIRLGLALNF	1436_LYCES	155	12
1787299	85234	AYKAAQDIANSELAPTHPIRLGLALNF	143C_ARATH	159	12
1787300	85234	AYKAAQEIALAELPPTHPIRLGLALNF	143B_HORVU	158	12
1787301	85234	AYKSAQDIALAELAPTHPIRLGLALNF	1434_LYCES	155	12
1787302	85234	AYKAAQDIALADLAPTHPIRLGLALNF	O24223	161	12
1787303	85234	AYKSAQDIALADLPTTHPIRLGLALNF	143A_HORVU	157	12
1787304	85234	AYKSAQDIANGELAPTHPIRLGLALNF	1434_SOLTU	153	12
1787305	85234	AYKSAQDIANGELAPTHPIRLGLALNF	143A_TOBAC	153	12
1787306	85234	AYKSASDIATAELAPTHPIRLGLALNF	143P_ARATH	153	12
1787307	85234	AYKSAQDIALADLPTTHPIRLGLALNL	1433_ORYSA	157	12
1787308	85234	AYKAAQDIALVDLPPTHPIRLGLALNF	1433_CHLRE	154	12
1787309	85234	AYKAASDIAMTELPPTHPIRLGLALNF	143E_HUMAN	151	12
1787310	85234	AYKAASDIAMTELPPTHPIRLGLALNF	O57468	151	12
1787311	85234	AYKTASEIATTELPPTHPIRLGLALNF	BMH1_YEAST	152	12
1787312	85234	AYKTASEIATTELPPTHPIRLGLALNF	BMH2_YEAST	152	12
1787313	85234	AYKAASDIAVTELPPTHPIRLGLALNF	1433_DICDI	150	12
1787314	85234	GYKAASEIATAELAPTHPIRLGLALNF	RA24_SCHPO	153	12
1787315	85234	AYKAAQDIAAADMAPTHPIRLGLALNF	143L_ARATH	157	12
1787316	85234	AYKAAQDIAAADMAPTHPIRLGLALNF	143R_ARATH	157	12
1787317	85234	AYKAASDIAMNDLPPTHPIRLGLALNF	143E_DROME	151	12
1787318	85234	AYKSAQDIANAELPPTHPIRLGLALNF	Q39558	158	12
1787319	85234	AYKAAQDIAVAELAPTHPIRLGLALNF	P93787	158	12
1787320	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	143Z_HUMAN	148	12
1787321	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	143Z_SHEEP	148	12
1787322	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	143Z_MOUSE	148	12
1787323	85234	AYKAAQDVAVADLAPTHPIRLGLALNF	143K_ARATH	157	12
1787324	85234	AYQDAFDISKTEMQPTHPIRLGLALNF	O57469	148	12
1787325	85234	AYKAAQDIALAELAPTHPIRLGLALNY	143D_TOBAC	158	12
1787326	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	143B_HUMAN	149	12
1787327	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	O70455	150	12
1787328	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	143B_BOVIN	149	12
1787329	85234	AYQEAFEISKKEMQPTHPIRLGLALNF	143B_RAT	149	12
1787330	85234	AYKAAQDIAVADVAPTHPIRLGLALNF	1431_LYCES	158	12
1787331	85234	AYKAATEVAQTELPPTHPIRLGLALNF	1433_TRIHA	150	12
1787332	85234	AYESATAAAEAELPPTHPIRLGLALNF	O49152	154	12
1787333	85234	SYQEAFDIAKDKMQPTHPIRLGLALNF	1434_CAEEL	150	12
1787334	85234	AYQDAFDISKGKMQPTHPIRLGLALNF	143Z_DROME	151	12
1787335	85234	AYESATTAAEAELPPTHPIRLGLALNF	143B_VICFA	154	12
1787336	85234	AYESATAAAEADLPPTHPIRLGLALNF	143D_SOYBN	154	12
1787337	85234	AYKAASDVAVTELPPTHPIRLGLALNF	1433_CANAL	152	12
1787338	85234	AYKAASDIAVAELPPTDPMRLGLALNF	RA25_SCHPO	152	12
1787339	85234	AYQEAFDISKKEMQPTHPIRLGLALNF	143T_HUMAN	148	12
1787340	85234	AYQEAFDISKKEMQPTHPIRLGLALNF	143T_RAT	148	12
1787341	85234	AYQEALDIAKDKMQPTHPIRLGLALNF	1433_CAEEL	149	11
1787342	85234	AYKEAFEISKEQMQPTHPIRLGLALNF	143F_HUMAN	152	12
1787343	85234	AYKEAFEISKEHMQPTHPIRLGLALNF	143F_MOUSE	152	12
1787344	85234	AYQLASTTAEAELASTHPIRLGLALNF	143C_SOYBN	154	12
1787345	85234	AYSEAHEISKEHMQPTHPIRLGLALNY	143G_BOVIN	152	12
1787346	85234	AYSEAHEISKEHMQPTHPIRLGLALNY	O70457	153	12
1787347	85234	AYSEAHEISKEHMQPTHPIRLGLALNY	143G_RAT	152	12
1787348	85234	AYEIATTAAEAKLPPTHPIRLGLALNF	143M_ARATH	154	12
1787349	85234	AYEIATTAAEAKLPPTHPIRLGLALNF	O80367	154	12
1787350	85234	AYKAAVAAAENGLAPTHPVRLGLALNF	143E_ARATH	152	12
1787351	85234	AYQDAFDISKTEMQPTHPIRLGLALKL	143Z_XENLA	148	12
1787352	85234	AYQEAMDISKKEMPPTNPIRLGLALNF	O70456	150	12
1787656	85246	CGTCKYKL	XYLA_PSEPU	57	-1
1787353	85234	AYQEAMDISKKEMPPTNPIRLGLALNF	143S_HUMAN	150	12
1787354	85234	AYQKATDIAENELPSTHPIRLGLALNY	O61131	163	12
1787355	85234	AYQEAMDISKKEMPPTNPIRLGLALNF	O77642	150	12
1787356	85234	SYQKATETAEAELPSTHPIRLGLALNY	O60955	163	12
1787357	85234	AYTEATEISNAELAPTHPIRLGLALNF	1431_ENTHI	151	12
1787358	85234	AYQLASDHANQDLPPTHPIRLGLALNF	1433_FUCVE	148	12
1787359	85234	SYQKATETAEGHSPATHPIRLGLALNY	1433_NEOCA	163	12
1787360	85234	AAYQEATDTAASLVPTHPIRLGLALNF	1432_ENTHI	150	11
1787361	85234	ANQKATSLAEAELSVTHPIRLGLALNF	Q24902	156	12
1787362	85234	DAYTKATTAAENLPTTHPIRLGLALNF	1431_SCHMA	158	11
1787363	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143B_TOBAC	180	0
1787364	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1433_LYCES	185	0
1787365	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	P93786	184	0
1787366	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143O_ARATH	181	0
1787367	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	P93785	179	0
1787368	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1435_SOLTU	182	0
1787369	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	1433_MESCR	183	0
1787370	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	O49082	184	0
1787371	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143C_TOBAC	184	0
1787372	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143H_ARATH	187	0
1787373	85235	SVFYYEILNSPDRACGLAKQAFDEAIA	143A_VICFA	184	0
1787374	85235	SVFYYEILNSSDRACNLAKQAFDDAIA	143E_TOBAC	182	0
1787375	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	O24221	185	0
1787376	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	O24001	185	0
1787377	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	O65352	185	0
1787378	85235	SVFYYEILNSPDKACNLAKQAFDEAIS	O24222	179	0
1787379	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	143A_SOYBN	182	0
1787380	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1433_PEA	184	0
1787381	85235	SVFYYEILNSPDRACSLAKQAFDEAIS	1431_MAIZE	184	0
1787382	85235	SVFYYEILNSPDRACNLAKQAFDDAIA	1433_SOLTU	181	0
1787383	85235	SVFYYEILNSPDRACSLAKQAFDEAIS	143N_ARATH	181	0
1787384	85235	SVFYYEILNSPDRACSLAKQAFDEAIS	1432_MAIZE	184	0
1787385	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143F_TOBAC	182	0
1787386	85235	SVFYYEILNSPDRACNLANEAFDEAIA	1433_OENHO	184	0
1787387	85235	SVFYYEILNSSDRACSLAKQAFDEAIS	143U_ARATH	183	0
1787388	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1432_LYCES	179	0
1787389	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1435_LYCES	181	0
1787390	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1436_LYCES	182	0
1787391	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143C_ARATH	186	0
1787392	85235	SVFYYEILNSPDRACDLAKQAFDEAIS	143B_HORVU	185	0
1787393	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	1434_LYCES	182	0
1787394	85235	SVFYYEILNSPDRACNLAKQAFDEAIS	O24223	188	0
1787395	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143A_HORVU	184	0
1787396	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	1434_SOLTU	180	0
1787397	85235	SVFYYEILNSPDRACNLAKQAFDEAIA	143A_TOBAC	180	0
1787398	85235	SVFYYEILNSPDRACSLAKQAFDDAIA	143P_ARATH	180	0
1787399	85235	SVFYYEILNSPDRACNLAKQAFDDAIA	1433_ORYSA	184	0
1787400	85235	SVFYYEILNSPERACHLAKQAFDEAIA	1433_CHLRE	181	0
1787401	85235	SVFYYEILNSPDRACRLAKAAFDDAIA	143E_HUMAN	178	0
1787402	85235	SVFYYEILNSPDRACRLAKAAFDDAIA	O57468	178	0
1787403	85235	SVFYYEIQNSPDKACHLAKQAFDDAIA	BMH1_YEAST	179	0
1787404	85235	SVFYYEIQNSPDKACHLAKQAFDDAIA	BMH2_YEAST	179	0
1787405	85235	SVFYYEILNSPDRACNLAKTAFDDAIA	1433_DICDI	177	0
1787406	85235	SVFYYEILNSPDRACYLAKQAFDEAIS	RA24_SCHPO	180	0
1787407	85235	SVFYYEILNSSDKACNMAKQAFEEAIA	143L_ARATH	184	0
1787408	85235	SVFYYEILNSSDKACNMAKQAFEEAIA	143R_ARATH	184	0
1787409	85235	SVFYYEILNSPDRACRLAKAAFDDAIA	143E_DROME	178	0
1787410	85235	SVFYYEILNSPDRACSLAKQAFDEAIA	Q39558	185	0
1787411	85235	SVFYYEILNASEKACSMAKQAFEEAIA	P93787	185	0
1787412	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	143Z_HUMAN	175	0
1787413	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	143Z_SHEEP	175	0
1787414	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	143Z_MOUSE	175	0
1787415	85235	SVFYYEILNSSEKACSMAKQAFEEAIA	143K_ARATH	184	0
1787416	85235	SVFYYEILNCPDKACALAKAAFDEAIA	O57469	175	0
1787417	85235	SVFYYEILNASEKACSMAKQAFEEAIA	143D_TOBAC	185	0
1787418	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	143B_HUMAN	176	0
1787419	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	O70455	177	0
1787420	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	143B_BOVIN	176	0
1787421	85235	SVFYYEILNSPEKACSLAKTAFDEAIA	143B_RAT	176	0
1787422	85235	SVFYYEILNASEKACSMAKQAFEEAIA	1431_LYCES	185	0
1787423	85235	SVFYYEILNAPDQACHLAKQAFDDAIA	1433_TRIHA	177	0
1787424	85235	SVFYYEILNSPERACHLAKQAFDEAIS	O49152	181	0
1787425	85235	SVFFYEILNAPDKACQLAKQAFDDAIA	1434_CAEEL	177	0
1787426	85235	SVFYYEILNSPDKACQLAKQAFDDAIA	143Z_DROME	178	0
1787427	85235	SVFYYEILNSPERACHLAKQAFDEAIS	143B_VICFA	181	0
1787428	85235	SVFYYEILNSPERACHLAKQAFDEAIS	143D_SOYBN	181	0
1787429	85235	SVFYYEILNSPDRACHLAKQAFDDAVA	1433_CANAL	179	0
1787430	85235	SVFYYEILDSPESACHLAKQVFDEAIS	RA25_SCHPO	179	0
1787431	85235	SVFYYEILNNPELACTLAKTAFDEAIA	143T_HUMAN	175	0
1787432	85235	SVFYYEILNNPELACTLAKTAFDEAIA	143T_RAT	175	0
1787433	85235	SVFYYEILNTPEHACQLAKQAFDDAIA	1433_CAEEL	176	0
1787434	85235	SVFYYEIQNAPEQACLLAKQAFDDAIA	143F_HUMAN	179	0
1787435	85235	SVFYYEIQNAPEQACLLAKQAFDDAIA	143F_MOUSE	179	0
1787436	85235	SVFYYEILNSPERACHLAKQAFDEAIS	143C_SOYBN	181	0
1787437	85235	SVFYYEIQNAPEQACHLAKTAFDDAIA	143G_BOVIN	179	0
1787438	85235	SVFYYEIQNAPEQACHLAKTAFDDAIA	O70457	180	0
1787439	85235	SVFYYEIQNAPEQACHLAKTAFDDAIA	143G_RAT	179	0
1787440	85235	SVFYYEIMNAPERACHLAKQAFDEAIS	143M_ARATH	181	0
1787441	85235	SVFYYEIMNAPERACHLAKQAFDEAIS	O80367	181	0
1787442	85235	SVFYYEILNSPESACQLAKQAFDDAIA	143E_ARATH	179	0
1787443	85235	VLTNEESSTVQDKACALAKAAFDEAIA	143Z_XENLA	177	2
1787444	85235	SVFHYEIANSPEEAISLAKTTFDEAMA	O70456	177	0
1787445	85235	SVFHYEIANSPEEAISLAKTTFDEAMA	143S_HUMAN	177	0
1787446	85235	SVFFYEILNQPHQACEMAKRAFDDAIT	O61131	190	0
1787447	85235	SVFHYEIANSPEEAISLAKTTFDEAMA	O77642	177	0
1787448	85235	SVFFYEILNLPQQACEMAKRAFDDAIT	O60955	190	0
1787449	85235	SVFYFEIMNDADKACQLAKQAFDDAIA	1431_ENTHI	178	0
1787450	85235	SVFYYEILNSPDRACGLAKAAFDDAIA	1433_FUCVE	175	0
1787451	85235	SVFFYEILNLPQQACEMAKRAFDDAIT	1433_NEOCA	190	0
1787452	85235	SVFYYQIMNDADKACQLAKEAFDEAIQ	1432_ENTHI	177	0
1787453	85235	SVFYYEIKNMPEKACSLAKAAFDAAIT	Q24902	183	0
1787454	85235	SVFFYEIQNDAAKACELAKSAFDSAIA	1431_SCHMA	185	0
1787455	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143B_TOBAC	207	0
1787456	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1433_LYCES	212	0
1787457	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	P93786	211	0
1787458	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143O_ARATH	208	0
1787459	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	P93785	206	0
1787460	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1435_SOLTU	209	0
1787461	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1433_MESCR	210	0
1787462	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	O49082	211	0
1787463	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143C_TOBAC	211	0
1787464	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143H_ARATH	214	0
1787465	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143A_VICFA	211	0
1787466	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143E_TOBAC	209	0
1787467	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	O24221	212	0
1787468	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	O24001	212	0
1787469	85236	ELDTLGEDSYKDSTLIMQLLRDNLTLWTSD	O65352	212	0
1787470	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	O24222	206	0
1787471	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143A_SOYBN	209	0
1787472	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1433_PEA	211	0
1787473	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	1431_MAIZE	211	0
1787474	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1433_SOLTU	208	0
1787475	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWNSD	143N_ARATH	208	0
1787476	85236	ELDTLSEESYKDSTLIMQLLHDNLTLWTSD	1432_MAIZE	211	0
1787477	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143F_TOBAC	209	0
1787478	85236	ELDTLEEESYKDSTLIMQLLRDNLTLWTSD	1433_OENHO	211	0
1787479	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143U_ARATH	210	0
1787480	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1432_LYCES	206	0
1787481	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1435_LYCES	208	0
1787482	85236	ELDTLGEESYKDSTLIMQLLRDNLTSWTSD	1436_LYCES	209	0
1787483	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWASD	143C_ARATH	213	0
1787484	85236	ELDSLSEESYKDSTLIMQLLRDNLTLWTSD	143B_HORVU	212	0
1787485	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1434_LYCES	209	0
1787486	85236	ELDSLGEESYKDSTLIMQLLRDNLTLWTSD	O24223	215	0
1787487	85236	ELDSLGEESYKDSTLIMQLLRDNLTLWTSD	143A_HORVU	211	0
1787488	85236	DVDTLGEESYKDSTLIMQLLRDNLTLWTSD	1434_SOLTU	207	0
1787489	85236	ELGTLGEESYKDSTLIMQLFCDNLTLWTSD	143A_TOBAC	207	0
1787490	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143P_ARATH	207	0
1787491	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	1433_ORYSA	211	0
1787492	85236	ELDSLGEESYKDSTLIMQLLRDNLTLWTSD	1433_CHLRE	208	0
1787493	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143E_HUMAN	205	0
1787494	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	O57468	205	0
1787495	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	BMH1_YEAST	206	0
1787496	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	BMH2_YEAST	206	0
1787497	85236	ELDTLSEDSYKDSTLIMQLLRDNLTLWTSD	1433_DICDI	204	0
1787498	85236	ELDSLSEESYKDSTLIMQLLRDNLTLWTSD	RA24_SCHPO	207	0
1787499	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143L_ARATH	211	0
1787500	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143R_ARATH	211	0
1787501	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143E_DROME	205	0
1787502	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	Q39558	212	0
1787503	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	P93787	212	0
1787504	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143Z_HUMAN	202	0
1787505	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143Z_SHEEP	202	0
1787506	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143Z_MOUSE	202	0
1787507	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143K_ARATH	211	0
1787508	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	O57469	202	0
1787509	85236	ELDTLGEESYKDSTLIMQLLRDNLTLWTSD	143D_TOBAC	212	0
1787510	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSE	143B_HUMAN	203	0
1787511	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSE	O70455	204	0
1787512	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSE	143B_BOVIN	203	0
1787513	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSE	143B_RAT	203	0
1787514	85236	ELDTMGEESYKDSTLIMQLLRDNLTLWTSD	1431_LYCES	212	0
1787515	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSS	1433_TRIHA	204	0
1787516	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSD	O49152	208	0
1787517	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	1434_CAEEL	204	0
1787518	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143Z_DROME	205	0
1787519	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSD	143B_VICFA	208	0
1787520	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSD	143D_SOYBN	208	0
1787521	85236	DLETLSEDSYKDSTLIMQLLRDNLTLWTDL	1433_CANAL	206	0
1787522	85236	ELDSLSEESYKDSTLIMQLLRDNLTLWTSD	RA25_SCHPO	206	0
1787523	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143T_HUMAN	202	0
1787524	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143T_RAT	202	0
1787525	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	1433_CAEEL	203	0
1787526	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143F_HUMAN	206	0
1787527	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143F_MOUSE	206	0
1787528	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143C_SOYBN	208	0
1787529	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143G_BOVIN	206	0
1787530	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	O70457	207	0
1787531	85236	ELDTLNEDSYKDSTLIMQLLRDNLTLWTSD	143G_RAT	206	0
1787532	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143M_ARATH	208	0
1787533	85236	ELDTLNEESYKDSTLIMQLLRDNLTLWTSD	O80367	208	0
1787534	85236	ELDSLNEESYKDSTLIMQLLRDNLTLWTSD	143E_ARATH	206	0
1787535	85236	ELDTLSEESYKDSTLIMQLLRDNLTLWTSD	143Z_XENLA	204	0
1787536	85236	DLHTLSEDSYKDSTLIMQLLRDNLTLWTAD	O70456	204	0
1787537	85236	DLHTLSEDSYKDSTLIMQLLRDNLTLWTAD	143S_HUMAN	204	0
1787538	85236	EFDNVSEDSYKDSTLIMQLLRDNLTLWTSD	O61131	217	0
1787539	85236	DLHTLSEDSYKDSTLIMQLLRDNLTLWTAD	O77642	204	0
1787540	85236	EFDNVSEDSYKDSTLIMQLLRDNLTLWTSD	O60955	217	0
1787541	85236	KLDEVPENMYKDSTLIMQLLRDNLTLWTSD	1431_ENTHI	205	0
1787542	85236	LDTLSEESYKDSTLIIMQLLRDNLTLWTSD	1433_FUCVE	203	1
1787543	85236	EFDNVSEDSYKDSTLIMQLLRDNLTLWTSD	1433_NEOCA	217	0
1787544	85236	KLDEVPEESYKESTLIMQLLRDNLTLWTSD	1432_ENTHI	204	0
1787545	85236	EVDSIKDETYKDSTLIMQLLRDNLTLWTPS	Q24902	210	0
1787546	85236	ELDQLQDDSYKDSTLIMQLLRDNLTLWASD	1431_SCHMA	212	0
1787547	85237	GYCIHMGHGVYASVAHVV	POLN_FCVF9	1095	1095
1787548	85237	GYCVHMGHGVYASVAHVV	POLN_FCVC6	1097	1097
1787549	85237	GWMIHIGNGLYISNTHTA	POLN_RHDV	1120	1120
1787550	85237	GYGVHIGNGNVITVTHVA	POLN_MANCV	997	997
1787551	85238	APFFSGKPTRDPWGSPV	POLN_FCVF9	1145	32
1787552	85238	APFFSGRPTRDPWGSPV	POLN_FCVC6	1147	32
1787553	85238	AQIAEGTPVCDWKKSPI	POLN_RHDV	1165	27
1787554	85238	GPFSQLPHMQIGSGSPV	POLN_MANCV	1039	24
1787555	85239	THPGDCGLPYID	POLN_FCVF9	1188	26
1787556	85239	THPGDCGLPYID	POLN_FCVC6	1190	26
1787557	85239	TTHGDCGLPLYD	POLN_RHDV	1207	25
1787558	85239	TKKGDCGLPYFN	POLN_MANCV	1092	36
1787559	85240	DNGRVTGLHTG	POLN_FCVF9	1200	0
1787560	85240	DNGRVTGLHTG	POLN_FCVC6	1202	0
1787561	85240	SSGKIVAIHTG	POLN_RHDV	1219	0
1787562	85240	SNRQLVALHAG	POLN_MANCV	1104	0
1787563	85241	GWMIHIGNGLYISNTHTA	POLN_RHDV	1120	1120
1787564	85241	GWMIHIGNGLYISNTHTA	Q86117	1120	1120
1787565	85241	GWMIHIGNGLYISNTHTA	Q86119	1120	1120
1787566	85241	GWMIHIGNGLYISNTHTA	Q89273	1120	1120
1787567	85241	GRMIHIGNGLYISNTHTA	Q86114	1120	1120
1787568	85241	GYCIHMGHGVYASVAHVV	POLN_FCVF9	1095	1095
1787569	85241	GWMIHIGNGMYLSNTHTA	Q96725	1113	1113
1787570	85241	GYCVHMGHGVYASVAHVV	Q66913	1095	1095
1787571	85241	GYCVHMGHGVYASVAHVV	POLN_FCVC6	1097	1097
1787572	85241	GYCVHMGHGVYATVAHVA	Q66914	1095	1095
1787573	85241	GYAIHIGHGVYISLKHVV	O92368	1208	1208
1787574	85241	GYGVHIGNGNVITVTHVA	POLN_MANCV	997	997
1787575	85242	AQIAEGTPVCDWKKSPI	POLN_RHDV	1165	27
1787576	85242	AQIAEGTPVCDWKKSPI	Q86117	1165	27
1787577	85242	AQIAEGTPVCDWKKSPI	Q86119	1165	27
1787578	85242	AQIAEGTPVCDWKKSPI	Q89273	1165	27
1787579	85242	AQIAEGTPVCDWKKSPI	Q86114	1165	27
1787580	85242	APFFSGKPTRDPWGSPV	POLN_FCVF9	1145	32
1787581	85242	AQIAEGTPVRDWKRASI	Q96725	1158	27
1787582	85242	APFFSGKPTRDPWGSPV	Q66913	1145	32
1787583	85242	APFFSGRPTRDPWGSPV	POLN_FCVC6	1147	32
1787584	85242	APFFPGKPTRDPWGSPV	Q66914	1145	32
1787585	85242	VPVGTSKPIKDPWGNPV	O92368	1258	32
1787586	85242	GPFSQLPHMQIGSGSPV	POLN_MANCV	1039	24
1787587	85243	TTHGDCGLPLYD	POLN_RHDV	1207	25
1787588	85243	TTHGDCGLPLYD	Q86117	1207	25
1787589	85243	TTHGDCGLPLYD	Q86119	1207	25
1787590	85243	TTHGDCGLPLYD	Q89273	1207	25
1787591	85243	TTHGDCGLPLYD	Q86114	1207	25
1787592	85243	THPGDCGLPYID	POLN_FCVF9	1188	26
1787593	85243	TTHGDCGLPLFD	Q96725	1200	25
1787594	85243	THPGDCGLPYID	Q66913	1188	26
1787595	85243	THPGDCGLPYID	POLN_FCVC6	1190	26
1787596	85243	THPGDCGLPYID	Q66914	1188	26
1787597	85243	TRQGDCGLPYVD	O92368	1301	26
1787598	85243	TKKGDCGLPYFN	POLN_MANCV	1092	36
1787599	85244	SSGKIVAIHTG	POLN_RHDV	1219	0
1787600	85244	SSGKIVAIHTG	Q86117	1219	0
1787601	85244	SSGKIVAIHTG	Q86119	1219	0
1787602	85244	SSGKIVAIHTG	Q89273	1219	0
1787603	85244	SSGKIVAIHTG	Q86114	1219	0
1787604	85244	DNGRVTGLHTG	POLN_FCVF9	1200	0
1787605	85244	EAGKVVAIHTG	Q96725	1212	0
1787606	85244	DNGRVTGLHTG	Q66913	1200	0
1787607	85244	DNGRVTGLHTG	POLN_FCVC6	1202	0
1787608	85244	DNGRVTGLHTG	Q66914	1200	0
1787609	85244	DHGVVVGLHAG	O92368	1313	0
1787610	85244	SNRQLVALHAG	POLN_MANCV	1104	0
1787611	85245	PFSCRAGAC	FER1_ANASP	38	38
1787612	85245	PFSCRAGAC	FER1_EQUAR	35	35
1787613	85245	PFSCRAGAC	FER_HALHA	60	60
1787614	85245	PSSCRAGSC	FER2_APHSA	38	38
1787615	85245	PFSCRSGSC	FER_BRYMA	37	37
1787616	85245	PYSCRAGSC	FER_WHEAT	82	82
1787617	85245	PVGCRGGGC	FERN_PSEPU	37	37
1787618	85245	PVGCRGGGC	FERX_PSEPU	38	38
1787619	85245	PLSCQAGAC	FER2_EQUAR	34	34
1787620	85245	PFSCHSGSC	FERH_ANASP	38	38
1787621	85245	PLDCRDGAC	XYLZ_PSEPU	37	37
1787622	85245	PMDCREGEC	BENC_ACICA	48	48
1787623	85245	MSSCREGGC	MEMC_METCA	39	39
1787624	85245	RRSCREGIC	DHSB_USTMA	103	103
1787625	85245	PYGCGGGGC	XDH_HUMAN	41	41
1787626	85245	RWSCRMAIC	FRDB_ECOLI	54	54
1787627	85245	DFVCRAGIC	FRDB_WOLSU	54	54
1787628	85245	PASCLTGVC	FER2_SYNP6	36	36
1787629	85245	TYGCREGEC	FER4_RHOCA	35	35
1787630	85245	PFACGHGTC	DMPP_PSEPU	33	33
1787631	85245	PHDCKVGSC	XYLA_PSEPU	49	49
1787632	85245	KLGCGEGGC	XDH_RAT	39	39
1787633	85245	KLGCAEGGC	XDH_DROPS	44	44
1787634	85245	PSSCESGTC	PDR_BURCE	269	269
1787635	85245	PLACEQGIC	VANB_PSES9	260	260
1787636	85246	CSTCAGKL	FER1_ANASP	46	-1
1787637	85246	CSSCLGKV	FER1_EQUAR	43	-1
1787638	85246	CANCASIV	FER_HALHA	68	-1
1787639	85246	CSTCAGKL	FER2_APHSA	46	-1
1787640	85246	CSTCAGKI	FER_BRYMA	45	-1
1787641	85246	CSSCAGKL	FER_WHEAT	90	-1
1787642	85246	CGLCKVRV	FERN_PSEPU	45	-1
1787643	85246	CGLCRVRV	FERX_PSEPU	46	-1
1787644	85246	CSTCLGKI	FER2_EQUAR	42	-1
1787645	85246	CSSCVGKV	FERH_ANASP	46	-1
1787646	85246	CGACKCFA	XYLZ_PSEPU	45	-1
1787647	85246	CGTCRAFC	BENC_ACICA	56	-1
1787648	85246	CATCKALC	MEMC_METCA	47	-1
1787649	85246	CGSCAMNI	DHSB_USTMA	111	-1
1787650	85246	CGACTVMI	XDH_HUMAN	49	-1
1787651	85246	CGSCGMMV	FRDB_ECOLI	62	-1
1787652	85246	CGSCGMMI	FRDB_WOLSU	62	-1
1787653	85246	CTTCAARI	FER2_SYNP6	44	-1
1787654	85246	CGTCMTHI	FER4_RHOCA	43	-1
1787657	85246	CGACTVMI	XDH_RAT	47	-1
1787658	85246	CGACTVMI	XDH_DROPS	52	-1
1787659	85246	CGSCKTGL	PDR_BURCE	277	-1
1787660	85246	CGTCLTRV	VANB_PSES9	268	-1
1787661	85247	PYSCRAGAC	FER2_DUNSA	35	35
1787662	85247	PYSCRAGAC	FER_SCEQU	36	36
1787663	85247	PYSCRAGAC	FER_MARPO	35	35
1787664	85247	PYSCRAGAC	FER_CHLRE	66	66
1787665	85247	PYSCRAGAC	FER_CHLFU	34	34
1787666	85247	PYSCRAGAC	FER2_SPIOL	36	36
1787667	85247	PYSCRAGAC	FER2_PHYES	37	37
1787668	85247	PYSCRAGAC	FER2_PHYAM	37	37
1787669	85247	PYSCRAGAC	FER1_CYAPA	38	38
1787670	85247	PYSCRAGAC	FER_PORUM	38	38
1787671	85247	PYSCRAGAC	FER_PORPU	38	38
1787672	85247	PYSCRAGAC	FER_ODOSI	38	38
1787673	85247	PYSCRAGAC	FER_GUITH	36	36
1787674	85247	PYSCRAGAC	FER_BUMFI	38	38
1787675	85247	PYSCRAGAC	FER1_SYNP7	38	38
1787676	85247	PYSCRAGSC	FER1_DUNSA	35	35
1787677	85247	PYSCRAGSC	Q40683	79	79
1787678	85247	PYSCRAGSC	O22382	79	79
1787679	85247	PYSCRAGSC	FER_SILPR	85	85
1787680	85247	PYSCRAGSC	FER_PERBI	34	34
1787681	85247	PYSCRAGSC	FER_MEDSA	36	36
1787682	85247	PYSCRAGSC	FER_DATST	36	36
1787683	85247	PYSCRAGSC	FER_COLES	36	36
1787684	85247	PYSCRAGSC	FER_BRANA	36	36
1787685	85247	PYSCRAGSC	FER_ARCLA	36	36
1787686	85247	PYSCRAGSC	FER_ARATH	88	88
1787687	85247	PYSCRAGSC	FERB_ALOMA	37	37
1787688	85247	PYSCRAGSC	FERA_ALOMA	36	36
1787689	85247	PYSCRAGSC	FER5_MAIZE	74	74
1787690	85247	PYSCRAGSC	FER3_RAPSA	36	36
1787691	85247	PYSCRAGSC	FER2_ARATH	88	88
1787692	85247	PYSCRAGSC	FER1_PHYES	36	36
1787693	85247	PYSCRAGSC	FER1_PEA	88	88
1787694	85247	PYSCRAGSC	FER1_ORYSA	36	36
1787695	85247	PYSCRAGSC	FER1_MESCR	87	87
1787696	85247	PYSCRAGSC	FER1_MAIZE	88	88
1787697	85247	PYSCRAGSC	FER1_LYCES	83	83
1787698	85247	PYSCRAGAC	FER1_APHFL	37	37
1787699	85247	PYSCRAGAC	Q39648	90	90
1787700	85247	PYSCRAGAC	FER_MASLA	38	38
1787701	85247	PYSCRAGAC	FER_APHSA	36	36
1787702	85247	PYSCRAGAC	FER2_CYACA	38	38
1787703	85247	PYSCRAGAC	FER1_CYACA	37	37
1787704	85247	PYSCRAGSC	FER1_SPIOL	86	86
1787705	85247	PYSCRAGSC	FER_WHEAT	82	82
1787706	85247	PYSCRAGSC	FER_SAMNI	36	36
1787707	85247	PYSCRAGSC	FER_LEUGL	35	35
1787708	85247	PYSCRAGAC	FER1_NOSMU	38	38
1787709	85247	PYSCRAGAC	FER_SYNY4	36	36
1787710	85247	PYSCRAGAC	FER_SYNY3	36	36
1787711	85247	PYSCRAGAC	FER_SYNP4	38	38
1787712	85247	PYSCRAGAC	FER_SPIMA	38	38
1787713	85247	PYSCRAGAC	FER_CHLFR	38	38
1787714	85247	PYSCRAGAC	FER3_MAIZE	92	92
1787715	85247	PYSCRAGAC	FER1_RAPSA	38	38
1787716	85247	PYSCRAGAC	FER1_PLEBO	39	39
1787717	85247	PFSCRAGSC	O80429	80	80
1787718	85247	PYSCRAGSC	FER1_PHYAM	36	36
1787719	85247	PYSCRAGAC	FER_RHOPL	37	37
1787720	85247	PFSCRAGAC	FER1_ANASP	38	38
1787721	85247	PFSCRAGAC	FER_SYNLI	36	36
1787722	85247	PFSCRAGAC	FER_SYNEL	37	37
1787723	85247	PFSCRAGAC	FER_NOSMU	38	38
1787724	85247	PFSCRAGAC	FER1_ANAVA	38	38
1787725	85247	PSSCRAGAC	O30582	39	39
1787726	85247	PYSCRAGAC	FER_GLEJA	36	36
1787727	85247	PSSCRAGSC	FER2_APHSA	38	38
1787728	85247	PYSCRAGAC	O04166	86	86
1787729	85247	PFSCRAGSC	Q40684	88	88
1787730	85247	PFSCRAGAC	FER1_EQUAR	35	35
1787731	85247	PFSCRAGAC	FER1_EQUTE	35	35
1787732	85247	PYSCRAGAC	FER_EUGVI	36	36
1787733	85247	PASCRAGAC	FER1_SYNP2	36	36
1787734	85247	PYSCRAGAC	FER2_RAPSA	38	38
1787735	85247	PYSCRAGAC	FER_SPIPL	38	38
1787736	85247	PFSCRSGSC	FER_BRYMA	37	37
1787737	85247	PFSCRAGSC	FER6_MAIZE	95	95
\.


--
-- Name: seq_seq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('seq_seq_id_seq', 1787737, true);


--
-- Name: true_positives_tp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('true_positives_tp_id_seq', 1, false);


--
-- Data for Name: truepartialpositives; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY truepartialpositives (tpp_id, fingerprint_id, protein_id, numberofelements, accession_number) FROM stdin;
311332	8431	461727	2	Q8LA49
311333	8431	461776	2	Q84TL7
311334	8431	461703	3	A2XZP5
311335	8431	461851	2	B9SYN6
311336	8431	461640	4	A3A5D6
311337	8431	461802	5	Q39772
311338	8431	461707	2	A9P9T4
311339	8431	461692	2	Q9SNZ2
311340	8431	461709	2	C7EA91
311341	8431	461711	5	Q9SE84
311342	8431	461728	5	Q84MJ4
311343	8431	461648	5	Q39722
311344	8431	461774	5	P19084
311345	8431	461715	4	B9EZT7
311346	8431	461652	2	A2WZN8
311347	8431	461783	5	Q647H1
311348	8431	461839	3	Q65XA1
311349	8431	461656	3	A2XZQ4
311350	8431	461800	2	A8MRV6
311351	8431	461661	4	Q56YY3
311352	8431	461847	2	B6THG1
311353	8431	461775	5	Q41714
311354	8431	461738	4	B9SKF4
311355	8431	461665	2	C5YYX1
311356	8431	461826	2	B6TDD3
311357	8431	461732	2	B9SW14
311358	8431	461724	2	B6TFX9
311359	8431	461855	2	A5ARE0
311360	8431	461670	5	Q9XHP0
311361	8431	461794	4	B8AH68
311362	8431	461674	2	B6SLE7
311363	8431	461796	5	Q9SMJ4
311364	8431	461748	2	C7EA92
311365	8431	461799	2	C5WQC0
311366	8431	461637	4	C0L8H2
311367	8431	461743	2	A5B7S5
311368	8431	461660	5	Q41017
311369	8431	461720	2	B9PAX0
311370	8431	461739	5	Q9SQH7
311371	8431	461805	2	Q84TL6
311372	8431	461769	2	A3A224
311373	8431	461751	4	Q43671
311374	8431	461679	5	Q39694
311375	8431	461811	5	P09800
311376	8431	461817	2	Q94CS6
311377	8431	461744	5	Q41018
311378	8431	461696	3	B9FM56
311379	8431	461687	2	C6TGN6
311472	8432	461933	2	Q21539
311473	8432	461905	5	Q41246
\.


--
-- Name: truepartialpositives_tpp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('truepartialpositives_tpp_id_seq', 1, false);


--
-- Data for Name: truepositives; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY truepositives (tp_id, fingerprint_id, protein_id, accession_number) FROM stdin;
311135	8431	461635	B5U8K2
311136	8431	461636	B7SLJ1
311137	8431	461638	Q0Z945
311138	8431	461639	Q41128
311139	8431	461641	B9GS11
311140	8431	461642	O23878
311141	8431	461643	Q6Q384
311142	8431	461644	Q39770
311143	8431	461645	B9S9Q7
311144	8431	461646	B9SF37
311145	8431	461647	Q56WH8
311146	8431	461649	C0ILQ2
311147	8431	461650	P12615
311148	8431	461651	A1DZF0
311149	8431	461653	Q948J8
311150	8431	461654	B8AEZ0
311151	8431	461655	Q38697
311152	8431	461657	O04691
311153	8431	461658	Q41676
311154	8431	461659	P93559
311155	8431	461662	A1E0V6
311156	8431	461663	B9F952
311157	8431	461664	B5KVH5
311158	8431	461666	B9F4T1
311159	8431	461667	P15838
311160	8431	461668	A1E0V4
311161	8431	461669	Q84ND2
311162	8431	461671	Q40689
311163	8431	461672	B9T5E6
311164	8431	461673	Q3HW60
311165	8431	461675	A2WVB9
311166	8431	461676	Q8LKN1
311167	8431	461677	A9NJG2
311168	8431	461678	A3KEY8
311169	8431	461680	B9SF35
311170	8431	461681	B9P6C0
311171	8431	461682	B9T1B8
311172	8431	461683	Q2TLV9
311173	8431	461684	B9H8M5
311174	8431	461685	Q9T0P5
311175	8431	461686	B9EZT3
311176	8431	461688	P13744
311177	8431	461689	Q40870
311178	8431	461690	A2X399
311179	8431	461691	Q8RX74
311180	8431	461693	Q6ERU3
311181	8431	461694	Q02498
311182	8431	461695	Q9FZ11
311183	8431	461697	Q6K7K6
311184	8431	461698	A1E0V8
311185	8431	461699	B7P073
311186	8431	461700	P93707
311187	8431	461701	Q9SB11
311188	8431	461702	Q6DR94
311189	8431	461704	P33524
311190	8431	461705	Q6ZK46
311191	8431	461706	Q2XSW7
311192	8431	461708	Q9FEC5
311193	8431	461710	Q10JA8
311194	8431	461712	Q39922
311195	8431	461713	A2X3A0
311196	8431	461714	Q946V2
311197	8431	461716	A1E0V5
311198	8431	461717	C9WC98
311199	8431	461718	P05190
311200	8431	461719	B2CGM5
311201	8431	461721	Q0JJ36
311202	8431	461722	O24294
311203	8431	461723	B9H8M2
311204	8431	461725	P05692
311205	8431	461726	P33523
311206	8431	461729	Q1WAB8
311207	8431	461730	Q39775
311208	8431	461731	Q2TPW5
311209	8431	461733	Q549Z4
311210	8431	461734	P33525
311211	8431	461735	Q6K508
311212	8431	461736	A1YQH6
311213	8431	461737	B9SDX6
311214	8431	461740	B9SF36
311215	8431	461741	Q6Q385
311216	8431	461742	Q40933
311217	8431	461745	O23880
311218	8431	461746	Q43452
311219	8431	461747	P07730
311220	8431	461749	Q6T726
311221	8431	461750	Q40348
311222	8431	461752	Q40347
311223	8431	461753	P02857
311224	8431	461754	A1YQH5
311225	8431	461755	A0EM47
311226	8431	461756	B9SW16
311227	8431	461757	Q647H3
311228	8431	461758	Q53I54
311229	8431	461759	A2X2Z8
311230	8431	461760	Q6T2T4
311231	8431	461761	B7P074
311232	8431	461762	A3KEY9
311233	8431	461763	Q84X93
311234	8431	461764	P93079
311235	8431	461765	A2X2V1
311236	8431	461766	P83004
311237	8431	461767	Q8LK20
311238	8431	461768	Q2TLW0
311239	8431	461770	B5TYU1
311240	8431	461771	P15456
311241	8431	461772	C5YY38
311242	8431	461773	Q02897
311243	8431	461777	Q0Z870
311244	8431	461778	Q96318
311245	8431	461779	P09802
311246	8431	461780	A2X301
311247	8431	461781	P93560
311248	8431	461782	B2CGM6
311249	8431	461784	Q84X94
311250	8431	461785	C0KG62
311251	8431	461786	Q41702
311252	8431	461787	Q647H4
311253	8431	461788	B9N2L3
311254	8431	461789	Q39521
311255	8431	461790	Q0GM57
311256	8431	461791	Q0E2D2
311257	8431	461792	P04347
311258	8431	461793	B9N2L2
311259	8431	461795	B8AH66
311260	8431	461797	Q43607
311261	8431	461798	Q7GC77
311262	8431	461801	Q9SB12
311263	8431	461803	A1E0V3
311264	8431	461804	Q6T725
311265	8431	461806	B9F4T2
311266	8431	461807	Q39627
311267	8431	461808	Q9M4R4
311268	8431	461809	Q43673
311269	8431	461810	A2YQV0
311270	8431	461812	Q9ZWA9
311271	8431	461813	Q09151
311272	8431	461814	P04405
311273	8431	461815	Q38780
311274	8431	461816	Q8W1C2
311275	8431	461818	A1YQG5
311276	8431	461819	Q38698
311277	8431	461820	P93708
311278	8431	461821	Q99304
311279	8431	461822	P33522
311280	8431	461823	A3A527
311281	8431	461824	P02858
311282	8431	461825	P04776
311283	8431	461827	Q0E2D5
311284	8431	461828	Q9AXL9
311285	8431	461829	Q6ESW6
311286	8431	461830	B5U8K1
311287	8431	461831	O82437
311288	8431	461832	O49257
311289	8431	461833	B9N2L4
311290	8431	461834	A1YQH4
311291	8431	461835	Q0E261
311292	8431	461836	B5KVH4
311293	8431	461837	P14812
311294	8431	461838	A2X2Z1
311295	8431	461840	B2KN55
311296	8431	461841	Q0E262
311297	8431	461842	Q852U4
311298	8431	461843	P15455
311299	8431	461844	Q647H2
311300	8431	461845	A2I9A6
311301	8431	461846	B8AKE2
311302	8431	461848	Q9M4Q8
311303	8431	461849	A1YQG3
311304	8431	461850	P14614
311305	8431	461852	Q5I6T2
311306	8431	461853	P07728
311307	8431	461854	C0L8H1
311308	8431	461856	P11090
311309	8431	461857	Q9ZWJ8
311310	8431	461858	Q06AW2
311311	8431	461859	A1E0V7
311312	8431	461860	P14323
311313	8431	461861	B8AEZ5
311314	8431	461862	Q06AW1
311315	8431	461863	Q39921
311316	8431	461864	Q41703
311317	8431	461865	O04689
311318	8431	461866	Q9AUD2
311319	8431	461867	Q2XSW6
311320	8431	461868	B9F4T3
311321	8431	461869	A3BP99
311322	8431	461870	O49258
311323	8431	461871	Q38779
311324	8431	461872	Q9S9D0
311325	8431	461873	B5U8K6
311326	8431	461874	Q9ZNY2
311327	8431	461875	Q852U5
311328	8431	461876	B9T5E7
311329	8431	461877	P11828
311330	8431	461878	A2Z708
311331	8431	461879	Q9XFM4
311380	8432	461880	P93259
311381	8432	461881	P42643
311382	8432	461882	P34730
311383	8432	461883	Q96452
311384	8432	461884	P35213
311385	8432	461885	P29305
311386	8432	461886	Q39757
311387	8432	461887	P31946
311388	8432	461888	Q43643
311389	8432	461889	Q25538
311390	8432	461890	P46266
311391	8432	461891	P29361
311392	8432	461892	O61131
311393	8432	461893	P42648
311394	8432	461894	P93785
311395	8432	461895	P93787
311396	8432	461896	P29358
311397	8432	461897	P42652
311398	8432	461898	P93206
311399	8432	461899	P93211
311400	8432	461900	Q04917
311401	8432	461901	O49082
311402	8432	461902	O80367
311403	8432	461903	O49995
311404	8432	461904	O65352
311405	8432	461906	Q01526
311406	8432	461907	P48348
311407	8432	461908	P46077
311408	8432	461909	Q01525
311409	8432	461910	O77642
311410	8432	461911	P48347
311411	8432	461912	Q96300
311412	8432	461913	O49152
311413	8432	461914	P35215
311414	8432	461915	P42647
311415	8432	461916	P42653
311416	8432	461917	P29310
311417	8432	461918	O49996
311418	8432	461919	O70457
311419	8432	461920	O70456
311420	8432	461921	O70455
311421	8432	461922	Q20655
311422	8432	461923	P42644
311423	8432	461924	Q43470
311424	8432	461925	O60955
311425	8432	461926	O24001
311426	8432	461927	Q96453
311427	8432	461928	P29359
311428	8432	461929	P54632
311429	8432	461930	P35214
311430	8432	461931	P93786
311431	8432	461932	P27348
311432	8432	461934	O42766
311433	8432	461935	P93210
311434	8432	461936	P29307
311435	8432	461937	P31947
311436	8432	461938	P35216
311437	8432	461939	P52908
311438	8432	461940	O49998
311439	8432	461941	P29312
311440	8432	461942	P11576
311441	8432	461943	P41932
311442	8432	461944	P93343
311443	8432	461945	Q41418
311444	8432	461946	O49997
311445	8432	461947	P93342
311446	8432	461948	Q91896
311447	8432	461949	Q24902
311448	8432	461950	P42655
311449	8432	461951	P42649
311450	8432	461952	Q26540
311451	8432	461953	P93209
311452	8432	461954	P93784
311453	8432	461955	P92177
311454	8432	461956	P42657
311455	8432	461957	P93208
311456	8432	461958	P42645
311457	8432	461959	O57469
311458	8432	461960	O57468
311459	8432	461961	P42656
311460	8432	461962	Q06967
311461	8432	461963	P29311
311462	8432	461964	O24221
311463	8432	461965	O24223
311464	8432	461966	O24222
311465	8432	461967	P49106
311466	8432	461968	P48349
311467	8432	461969	Q39558
311468	8432	461970	Q99002
311469	8432	461971	Q96299
311470	8432	461972	Q96450
311471	8432	461973	P42654
311474	8433	461974	P27409
311475	8433	461975	Q66913
311476	8433	461976	Q66914
311477	8433	461977	O92368
311478	8433	461978	P27410
311479	8433	461979	Q96725
311480	8433	461980	Q69014
311481	8433	461981	P27407
311482	8433	461982	Q86114
311483	8433	461983	Q86117
311484	8433	461984	Q86119
311485	8433	461985	Q89273
\.


--
-- Name: truepositives_tp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('truepositives_tp_id_seq', 311485, true);


--
-- Name: InterMotifDistance_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY intermotifdistance
    ADD CONSTRAINT "InterMotifDistance_pkey" PRIMARY KEY (imd_id);


--
-- Name: falsepartialpositives_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY protein
    ADD CONSTRAINT falsepartialpositives_pkey PRIMARY KEY (id);


--
-- Name: fingerprint_identifier_key; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY fingerprint
    ADD CONSTRAINT fingerprint_identifier_key UNIQUE (identifier);


--
-- Name: fingerprint_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY fingerprint
    ADD CONSTRAINT fingerprint_pkey PRIMARY KEY (id);


--
-- Name: literature_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT literature_pkey PRIMARY KEY (literature_id);


--
-- Name: motif_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY motif
    ADD CONSTRAINT motif_pkey PRIMARY KEY (motif_id);


--
-- Name: reference_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY crossreference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (reference_id);


--
-- Name: scanhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY scanhistory
    ADD CONSTRAINT scanhistory_pkey PRIMARY KEY (sh_id);


--
-- Name: seq_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_pkey PRIMARY KEY (seq_id);


--
-- Name: seq_seq_id_key; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_seq_id_key UNIQUE (seq_id);


--
-- Name: true_partial_positives_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY truepositives
    ADD CONSTRAINT true_partial_positives_pkey PRIMARY KEY (tp_id);


--
-- Name: truepartialpositives_pkey; Type: CONSTRAINT; Schema: public; Owner: anatoliyd; Tablespace: 
--

ALTER TABLE ONLY truepartialpositives
    ADD CONSTRAINT truepartialpositives_pkey PRIMARY KEY (tpp_id);


--
-- Name: falsepartialpositives_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY protein
    ADD CONSTRAINT falsepartialpositives_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: intermotifdistance_motif_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY intermotifdistance
    ADD CONSTRAINT intermotifdistance_motif_id_fkey FOREIGN KEY (motif_id) REFERENCES motif(motif_id);


--
-- Name: literature_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT literature_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: motif_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY motif
    ADD CONSTRAINT motif_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: reference_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY crossreference
    ADD CONSTRAINT reference_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: scanhistory_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY scanhistory
    ADD CONSTRAINT scanhistory_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: seq_motif_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY seq
    ADD CONSTRAINT seq_motif_id_fkey FOREIGN KEY (motif_id) REFERENCES motif(motif_id);


--
-- Name: true_positives_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY truepositives
    ADD CONSTRAINT true_positives_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: truepartialpositives_fingerprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY truepartialpositives
    ADD CONSTRAINT truepartialpositives_fingerprint_id_fkey FOREIGN KEY (fingerprint_id) REFERENCES fingerprint(id);


--
-- Name: truepartialpositives_protein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY truepartialpositives
    ADD CONSTRAINT truepartialpositives_protein_id_fkey FOREIGN KEY (protein_id) REFERENCES protein(id);


--
-- Name: truepositives_protein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anatoliyd
--

ALTER TABLE ONLY truepositives
    ADD CONSTRAINT truepositives_protein_id_fkey FOREIGN KEY (protein_id) REFERENCES protein(id);


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

