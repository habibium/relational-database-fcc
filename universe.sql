--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    description text,
    age_in_millions_of_years numeric(7,2),
    has_life boolean,
    is_spherical boolean,
    star_count integer,
    planet_count integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    is_spherical boolean,
    distance_from_planet_in_km integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    moon_count integer,
    has_life boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planets_in_galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planets_in_galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planets_in_galaxy_id integer NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.planets_in_galaxy OWNER TO freecodecamp;

--
-- Name: planets_in_galaxy_planets_in_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planets_in_galaxy_planets_in_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planets_in_galaxy_planets_in_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: planets_in_galaxy_planets_in_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planets_in_galaxy_planets_in_galaxy_id_seq OWNED BY public.planets_in_galaxy.planets_in_galaxy_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planet_count integer,
    is_spherical boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_id_seq'::regclass);


--
-- Name: planets_in_galaxy planets_in_galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_in_galaxy ALTER COLUMN planets_in_galaxy_id SET DEFAULT nextval('public.planets_in_galaxy_planets_in_galaxy_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Our home galaxy, a barred spiral galaxy', 13600.00, true, false, 400, 100);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Nearest large galaxy to the Milky Way', 10010.00, false, false, 1000, 300);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'Third-largest galaxy in the Local Group', 5000.00, false, false, 40, 10);
INSERT INTO public.galaxy VALUES (4, 'Sombrero Galaxy', 'Distinctive galaxy with a bright nucleus and large dust lane', 13250.00, false, false, 100, 50);
INSERT INTO public.galaxy VALUES (5, 'Whirlpool Galaxy', 'Classic spiral galaxy with prominent arms', 400.50, false, false, 100, 30);
INSERT INTO public.galaxy VALUES (6, 'Centaurus A', 'Peculiar galaxy with a supermassive black hole at its center', 13270.00, false, true, 100, 40);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 3, 'Luna', true, 384400);
INSERT INTO public.moon VALUES (2, 4, 'Phobos', false, 9377);
INSERT INTO public.moon VALUES (3, 4, 'Deimos', false, 23460);
INSERT INTO public.moon VALUES (4, 5, 'Io', true, 421700);
INSERT INTO public.moon VALUES (5, 5, 'Europa', true, 671100);
INSERT INTO public.moon VALUES (6, 5, 'Ganymede', true, 1070400);
INSERT INTO public.moon VALUES (7, 5, 'Callisto', true, 1882700);
INSERT INTO public.moon VALUES (8, 6, 'Titan', true, 1221870);
INSERT INTO public.moon VALUES (9, 6, 'Enceladus', true, 238020);
INSERT INTO public.moon VALUES (10, 6, 'Mimas', true, 185520);
INSERT INTO public.moon VALUES (11, 7, 'Miranda', true, 129390);
INSERT INTO public.moon VALUES (12, 7, 'Ariel', true, 190900);
INSERT INTO public.moon VALUES (13, 7, 'Umbriel', true, 266000);
INSERT INTO public.moon VALUES (14, 8, 'Triton', true, 354760);
INSERT INTO public.moon VALUES (15, 8, 'Nereid', false, 5513810);
INSERT INTO public.moon VALUES (16, 5, 'Amalthea', false, 181366);
INSERT INTO public.moon VALUES (17, 6, 'Hyperion', false, 1481100);
INSERT INTO public.moon VALUES (18, 10, 'Proxima Centauri c I', true, 384000);
INSERT INTO public.moon VALUES (19, 12, 'Sirius b I', true, 238000);
INSERT INTO public.moon VALUES (20, 12, 'Sirius b II', false, 421000);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Mercury', 0, false);
INSERT INTO public.planet VALUES (2, 1, 'Venus', 0, false);
INSERT INTO public.planet VALUES (3, 1, 'Earth', 1, true);
INSERT INTO public.planet VALUES (4, 1, 'Mars', 2, false);
INSERT INTO public.planet VALUES (5, 1, 'Jupiter', 79, false);
INSERT INTO public.planet VALUES (6, 1, 'Saturn', 82, false);
INSERT INTO public.planet VALUES (7, 1, 'Uranus', 27, false);
INSERT INTO public.planet VALUES (8, 1, 'Neptune', 14, false);
INSERT INTO public.planet VALUES (9, 2, 'Proxima Centauri b', 0, false);
INSERT INTO public.planet VALUES (10, 2, 'Proxima Centauri c', 1, false);
INSERT INTO public.planet VALUES (11, 2, 'Proxima Centauri d', 0, false);
INSERT INTO public.planet VALUES (12, 6, 'Sirius b', 3, false);


--
-- Data for Name: planets_in_galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planets_in_galaxy VALUES (1, 'Jupiter in Solar System', 1, 1);
INSERT INTO public.planets_in_galaxy VALUES (1, 'Saturn in Solar System', 2, 2);
INSERT INTO public.planets_in_galaxy VALUES (1, 'Uranus in Solar System', 3, 3);
INSERT INTO public.planets_in_galaxy VALUES (1, 'Neptune in Solar System', 4, 4);
INSERT INTO public.planets_in_galaxy VALUES (2, 'Proxima Centauri b in Proxima Centauri Galaxy', 5, 9);
INSERT INTO public.planets_in_galaxy VALUES (3, 'Alpheratz b in Alpheratz Galaxy', 6, 10);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Sun', 8, true);
INSERT INTO public.star VALUES (2, 1, 'Proxima Centauri', 3, true);
INSERT INTO public.star VALUES (3, 1, 'Betelgeuse', 0, false);
INSERT INTO public.star VALUES (4, 2, 'Alpheratz', 5, true);
INSERT INTO public.star VALUES (5, 3, 'Triangulum Alpha', 2, true);
INSERT INTO public.star VALUES (6, 1, 'Sirius', 1, true);


--
-- Name: galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_id_seq', 1, false);


--
-- Name: moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_id_seq', 1, false);


--
-- Name: planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_id_seq', 1, false);


--
-- Name: planets_in_galaxy_planets_in_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planets_in_galaxy_planets_in_galaxy_id_seq', 6, true);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_id_seq', 1, false);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planets_in_galaxy planets_in_galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_in_galaxy
    ADD CONSTRAINT planets_in_galaxy_pkey PRIMARY KEY (planets_in_galaxy_id);


--
-- Name: planets_in_galaxy planets_in_galaxy_planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_in_galaxy
    ADD CONSTRAINT planets_in_galaxy_planet_name_key UNIQUE (name);


--
-- Name: planets_in_galaxy planets_in_galaxy_planets_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_in_galaxy
    ADD CONSTRAINT planets_in_galaxy_planets_id_key UNIQUE (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: planets_in_galaxy fk_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_in_galaxy
    ADD CONSTRAINT fk_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: planets_in_galaxy planets_in_galaxy_planets_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planets_in_galaxy
    ADD CONSTRAINT planets_in_galaxy_planets_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

