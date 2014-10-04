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
    year smallint
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
    numberofelements integer
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
    protein_id integer
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
\.


--
-- Name: falsepartialpositives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('falsepartialpositives_id_seq', 160092, true);


--
-- Data for Name: fingerprint; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY fingerprint (id, identifier, accession, no_motifs, creation_date, update_date, title, annotation, cfi, summary) FROM stdin;
\.


--
-- Name: fingerprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('fingerprint_id_seq', 2573, true);


--
-- Data for Name: intermotifdistance; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY intermotifdistance (imd_id, motif_id, region, min, max) FROM stdin;
\.


--
-- Name: intermotifdistance_imd_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('intermotifdistance_imd_id_seq', 15164, true);


--
-- Name: literature_literature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('literature_literature_id_seq', 2591, true);


--
-- Data for Name: motif; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY motif (motif_id, fingerprint_id, title, code, length, "position") FROM stdin;
\.


--
-- Name: motif_motif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('motif_motif_id_seq', 30315, true);


--
-- Data for Name: protein; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY protein (id, fingerprint_id, code, description) FROM stdin;
\.


--
-- Data for Name: reference; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY reference (fingerprint_id, author, title, journal, literature_id, year) FROM stdin;
\.


--
-- Name: reference_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('reference_reference_id_seq', 22127, true);


--
-- Data for Name: scanhistory; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY scanhistory (sh_id, database, iterations_number, hitlist_length, scanning_method, fingerprint_id) FROM stdin;
\.


--
-- Name: scanhistory_sh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('scanhistory_sh_id_seq', 4655, true);


--
-- Data for Name: seq; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY seq (seq_id, motif_id, sequence, pcode, start, "interval") FROM stdin;
\.


--
-- Name: seq_seq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('seq_seq_id_seq', 571854, true);


--
-- Name: true_positives_tp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('true_positives_tp_id_seq', 1, false);


--
-- Data for Name: truepartialpositives; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY truepartialpositives (tpp_id, fingerprint_id, protein_id, numberofelements) FROM stdin;
\.


--
-- Name: truepartialpositives_tpp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('truepartialpositives_tpp_id_seq', 1, false);


--
-- Data for Name: truepositives; Type: TABLE DATA; Schema: public; Owner: anatoliyd
--

COPY truepositives (tp_id, fingerprint_id, protein_id) FROM stdin;
\.


--
-- Name: truepositives_tp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anatoliyd
--

SELECT pg_catalog.setval('truepositives_tp_id_seq', 20341, true);


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

