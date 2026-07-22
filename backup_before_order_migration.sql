--
-- PostgreSQL database dump
--

\restrict AowB7ZcoW4RV0J9BbdQFgLhML1BgmoQDhd4l5QfiqP49zkHFt9SG1huDf6zrLAL

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO salin;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO salin;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO salin;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO salin;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO salin;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO salin;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO salin;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.cart_items OWNER TO salin;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO salin;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    store_id bigint
);


ALTER TABLE public.carts OWNER TO salin;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO salin;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    store_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO salin;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO salin;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    store_id bigint,
    status character varying,
    tracking_number character varying,
    user_id bigint,
    price numeric
);


ALTER TABLE public.orders OWNER TO salin;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO salin;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    title character varying,
    description text,
    price numeric(10,2),
    stock integer DEFAULT 0,
    store_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category_id bigint,
    cost numeric
);


ALTER TABLE public.products OWNER TO salin;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO salin;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO salin;

--
-- Name: stores; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.stores (
    id bigint NOT NULL,
    name character varying,
    description text,
    theme character varying,
    address character varying,
    phone character varying,
    instagram character varying,
    facebook character varying,
    active boolean DEFAULT true NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    primary_color character varying,
    font_family character varying
);


ALTER TABLE public.stores OWNER TO salin;

--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_id_seq OWNER TO salin;

--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: salin
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role character varying
);


ALTER TABLE public.users OWNER TO salin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: salin
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO salin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: salin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	image	Product	6	1	2026-06-05 21:31:56.96188
2	image	Product	7	2	2026-06-05 21:51:30.501289
11	logo	Store	5	11	2026-06-12 20:36:55.00946
16	images	Product	2	16	2026-06-12 20:40:01.774679
25	images	Product	1	25	2026-06-12 22:29:33.06124
26	images	Product	1	26	2026-06-12 22:29:33.119989
27	images	Product	6	27	2026-06-13 14:11:28.13898
28	images	Product	6	28	2026-06-13 14:11:59.912988
29	images	Product	6	29	2026-06-13 14:13:00.09899
30	images	Product	8	30	2026-06-13 14:30:08.240982
31	images	Product	8	31	2026-06-13 14:30:08.243449
32	images	Product	9	32	2026-06-13 17:13:25.649733
34	images	Product	10	34	2026-06-18 08:44:07.150918
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
1	oie69dks7dwa9b8sfn8esjps4fde	profile-avatar-1.png	image/png	{"identified":true,"analyzed":true}	local	1443778	VLGTizHA+FcVqWzeVOs7rQ==	2026-06-05 21:31:56.960282
2	nmigbfrn5uv05tk9nmpi2elw5oes	profile-avatar-3.png	image/png	{"identified":true,"analyzed":true}	local	1576839	LCYmYHAxs57gnC20SXmmqw==	2026-06-05 21:51:30.498484
11	3j6x203k0jnhfo1wbl0tny478u7m	won-avatar1.png	image/png	{"identified":true,"analyzed":true}	local	524198	MixpbqFD5eWplHFaSZ1ooA==	2026-06-12 20:36:55.00399
25	m17fxlx0f53zta5f1ocib6cwlnx0	profile-avatar-1.png	image/png	{"identified":true,"analyzed":true}	local	1443778	VLGTizHA+FcVqWzeVOs7rQ==	2026-06-12 22:29:33.059602
26	36ep57wgglanl52q70xulv9t1q6c	profile-avatar-1.png	image/png	{"identified":true,"analyzed":true}	local	1443778	VLGTizHA+FcVqWzeVOs7rQ==	2026-06-12 22:29:33.102108
16	ug25slj91sn99b86gfoytg6t2x95	won-avatar1.png	image/png	{"identified":true,"analyzed":true}	local	524198	MixpbqFD5eWplHFaSZ1ooA==	2026-06-12 20:40:01.771884
27	c9xzje4do72u80pa1rqa7psno8zs	world-war_1.png	image/png	{"identified":true,"analyzed":true}	local	2548420	o0ZMucFAOebva1vscKreSw==	2026-06-13 14:11:28.133538
28	6tvlnm9yma1bk2j256ukzrhqz5ug	shirt-solid.png	image/png	{"identified":true,"analyzed":true}	local	23068	TaevBJCzFbehwDSTQGNymg==	2026-06-13 14:11:59.90405
29	udv7l62y1pt65kzmjluqklma1tb7	roman_empire.png	image/png	{"identified":true,"analyzed":true}	local	2646535	jLll1nO2+gpTvqwmslARZQ==	2026-06-13 14:13:00.096748
30	3ki4hupzg4z35blyh1yjovh3fxit	profile-avatar-3.png	image/png	{"identified":true,"analyzed":true}	local	1576839	LCYmYHAxs57gnC20SXmmqw==	2026-06-13 14:30:08.239552
31	m5v6bybhkmk06laoik6s74smg2gf	profile-avatar-5.png	image/png	{"identified":true,"analyzed":true}	local	1716202	DApOrM9ZWHOv1hVgkQi/UQ==	2026-06-13 14:30:08.242476
32	k2lzre1f0ir1gwpdtppk8sbdqkut	world-war_1.png	image/png	{"identified":true,"analyzed":true}	local	2548420	o0ZMucFAOebva1vscKreSw==	2026-06-13 17:13:25.647674
34	x4q904dw3np50m0fh0cjcl9egme3	profile-avatar-5.png	image/png	{"identified":true,"analyzed":true}	local	1716202	DApOrM9ZWHOv1hVgkQi/UQ==	2026-06-18 08:44:07.149695
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2026-06-01 17:19:53.188041	2026-06-01 17:19:53.188044
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.cart_items (id, cart_id, product_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.carts (id, created_at, updated_at, store_id) FROM stdin;
1	2026-06-18 11:57:21.32563	2026-06-18 11:57:21.32563	\N
2	2026-06-23 21:40:50.873822	2026-06-23 21:40:50.873822	5
3	2026-06-25 09:13:40.212279	2026-06-25 09:13:40.212279	2
4	2026-06-25 10:20:29.346406	2026-06-25 10:20:29.346406	6
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.categories (id, name, store_id, created_at, updated_at) FROM stdin;
1	Food	2	2026-06-13 14:43:31.350501	2026-06-13 14:43:31.350501
2	food	5	2026-06-13 15:11:18.216747	2026-06-13 15:11:18.216747
3	toy	5	2026-06-13 17:12:21.943214	2026-06-13 17:12:21.943214
5	toilet	5	2026-06-18 08:43:21.900282	2026-06-18 08:43:21.900282
6	medecine	5	2026-06-23 21:50:39.410624	2026-06-23 21:50:39.410624
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.orders (id, product_id, quantity, created_at, updated_at, store_id, status, tracking_number, user_id, price) FROM stdin;
62	1	1	2026-07-06 22:20:59.287655	2026-07-06 22:20:59.287655	5	pending	\N	1	\N
95	7	3	2026-07-12 22:02:23.497859	2026-07-12 22:02:23.497859	5	pending	\N	1	12.0
96	9	3	2026-07-12 22:02:42.345163	2026-07-12 22:02:42.345163	5	pending	\N	1	3.0
97	6	2	2026-07-12 22:04:24.739649	2026-07-12 22:04:24.739649	5	pending	\N	1	10.0
98	8	2	2026-07-12 22:04:24.801539	2026-07-12 22:04:24.801539	5	pending	\N	1	20.0
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.products (id, title, description, price, stock, store_id, created_at, updated_at, category_id, cost) FROM stdin;
2	cat food	Utima salmon flavor for cats age 1+	7.35	9	5	2026-06-04 13:05:04.152283	2026-07-03 16:36:26.699442	2	\N
1	milk for KITTEN	milk for cat	3.50	9	5	2026-06-04 13:03:42.973566	2026-07-06 22:20:59.304898	2	\N
7	cat toy	doudou for cat	12.00	6	5	2026-06-05 21:51:30.492616	2026-07-12 22:02:23.512083	3	\N
9	cat herb	herb for cat	3.00	7	5	2026-06-13 17:13:25.64047	2026-07-12 22:02:42.359605	2	\N
6	cat toy	peluche for cat	10.00	15	5	2026-06-05 21:31:56.930648	2026-07-12 22:04:24.790166	3	\N
8	cat bed	bed for cat	20.00	9	5	2026-06-13 14:30:08.229337	2026-07-12 22:04:24.812778	3	\N
10	cat sand	with perfume	5.00	12	5	2026-06-18 08:44:07.142398	2026-06-18 08:44:07.1754	5	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.schema_migrations (version) FROM stdin;
20260601171758
20260601214047
20260603153251
20260605211657
20260607212742
20260608210608
20260613144113
20260613165900
20260615222012
20260618085434
20260618085549
20260622210312
20260622220911
20260624171753
20260625123931
20260625215216
20260706220707
20260708224323
20260710222212
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.stores (id, name, description, theme, address, phone, instagram, facebook, active, user_id, created_at, updated_at, primary_color, font_family) FROM stdin;
2	Salin Beauty	beauty shop	grid	\N	\N	\N	\N	t	1	2026-06-02 20:58:27.722702	2026-06-21 21:34:02.983563	#ff6600	Poppins
6	salin pizza	pizzaria	sidebar	\N	\N	\N	\N	t	1	2026-06-25 10:20:29.306119	2026-06-25 10:20:29.306119	#ff0026	Roboto
5	cosette shop	pets shop and accessories for pets	grid	\N	\N	\N	\N	t	1	2026-06-04 12:54:02.436955	2026-06-25 13:57:41.138506	#00ff59	Inter
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: salin
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, role) FROM stdin;
1	test@pocketbuilder.com	$2a$12$am8AJof7yDtA8hEc2tRZP.A4pPeZoH2Vj/Vb97EiUpMe49XgiRw4K	\N	\N	\N	2026-06-01 20:20:00.177814	2026-06-25 13:07:29.827134	owner
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 35, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 35, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 110, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.carts_id_seq', 4, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.orders_id_seq', 98, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.products_id_seq', 11, true);


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.stores_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: salin
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: salin
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: salin
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: salin
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_cart_items_on_cart_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_cart_items_on_cart_id ON public.cart_items USING btree (cart_id);


--
-- Name: index_cart_items_on_product_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_cart_items_on_product_id ON public.cart_items USING btree (product_id);


--
-- Name: index_carts_on_store_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_carts_on_store_id ON public.carts USING btree (store_id);


--
-- Name: index_categories_on_store_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_categories_on_store_id ON public.categories USING btree (store_id);


--
-- Name: index_orders_on_product_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_orders_on_product_id ON public.orders USING btree (product_id);


--
-- Name: index_orders_on_store_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_orders_on_store_id ON public.orders USING btree (store_id);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_orders_on_user_id ON public.orders USING btree (user_id);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_products_on_category_id ON public.products USING btree (category_id);


--
-- Name: index_products_on_store_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_products_on_store_id ON public.products USING btree (store_id);


--
-- Name: index_stores_on_user_id; Type: INDEX; Schema: public; Owner: salin
--

CREATE INDEX index_stores_on_user_id ON public.stores USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: salin
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: salin
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: products fk_rails_5cf8ff66a6; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_5cf8ff66a6 FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: cart_items fk_rails_681a180e84; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_681a180e84 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: cart_items fk_rails_6cdb1f0139; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_6cdb1f0139 FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: categories fk_rails_72b047249d; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_rails_72b047249d FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: stores fk_rails_b526db2ffb; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT fk_rails_b526db2ffb FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: orders fk_rails_dfb33b2de0; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_dfb33b2de0 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders fk_rails_f0be2fda72; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_f0be2fda72 FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: orders fk_rails_f868b47f6a; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_f868b47f6a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: carts fk_rails_fb0f29318e; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_rails_fb0f29318e FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: products fk_rails_fb915499a4; Type: FK CONSTRAINT; Schema: public; Owner: salin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_fb915499a4 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

\unrestrict AowB7ZcoW4RV0J9BbdQFgLhML1BgmoQDhd4l5QfiqP49zkHFt9SG1huDf6zrLAL

