SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    date date NOT NULL,
    start_time character varying NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp without time zone,
    end_time character varying,
    duration integer,
    html_description text NOT NULL,
    text_description text NOT NULL
);


--
-- Name: hash_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hash_tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    author_id uuid NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: object_hash_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE object_hash_tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    hash_tag_id uuid NOT NULL,
    hash_taggable_type character varying NOT NULL,
    hash_taggable_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: reminders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE reminders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    date date NOT NULL,
    "time" character varying NOT NULL,
    datetime timestamp without time zone NOT NULL,
    description text NOT NULL,
    html_description text NOT NULL,
    text_description text NOT NULL,
    delivered boolean DEFAULT false NOT NULL,
    delivered_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    token character varying NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email citext NOT NULL,
    password_digest character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    online boolean DEFAULT false NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: hash_tags hash_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hash_tags
    ADD CONSTRAINT hash_tags_pkey PRIMARY KEY (id);


--
-- Name: object_hash_tags object_hash_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY object_hash_tags
    ADD CONSTRAINT object_hash_tags_pkey PRIMARY KEY (id);


--
-- Name: reminders reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_events_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_user_id ON events USING btree (user_id);


--
-- Name: index_hash_tags_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hash_tags_on_author_id ON hash_tags USING btree (author_id);


--
-- Name: index_hash_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_hash_tags_on_name ON hash_tags USING btree (name);


--
-- Name: index_object_hash_tags_on_hash_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_object_hash_tags_on_hash_tag_id ON object_hash_tags USING btree (hash_tag_id);


--
-- Name: index_object_hash_tags_on_hash_tag_id_and_hash_taggable; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_object_hash_tags_on_hash_tag_id_and_hash_taggable ON object_hash_tags USING btree (hash_tag_id, hash_taggable_type, hash_taggable_id);


--
-- Name: index_object_hash_tags_on_hash_taggable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_object_hash_tags_on_hash_taggable ON object_hash_tags USING btree (hash_taggable_type, hash_taggable_id);


--
-- Name: index_reminders_on_datetime; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reminders_on_datetime ON reminders USING btree (datetime);


--
-- Name: index_reminders_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reminders_on_user_id ON reminders USING btree (user_id);


--
-- Name: index_sessions_on_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_expires_at ON sessions USING btree (expires_at);


--
-- Name: index_sessions_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sessions_on_token ON sessions USING btree (token);


--
-- Name: index_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_user_id ON sessions USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: events fk_rails_0cb5590091; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_rails_0cb5590091 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: reminders fk_rails_49f81d5e52; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reminders
    ADD CONSTRAINT fk_rails_49f81d5e52 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: sessions fk_rails_758836b4f0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT fk_rails_758836b4f0 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: hash_tags fk_rails_79c82bd1b7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hash_tags
    ADD CONSTRAINT fk_rails_79c82bd1b7 FOREIGN KEY (author_id) REFERENCES users(id);


--
-- Name: object_hash_tags fk_rails_7bc2da32d5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY object_hash_tags
    ADD CONSTRAINT fk_rails_7bc2da32d5 FOREIGN KEY (hash_tag_id) REFERENCES hash_tags(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180222045129'),
('20180222045321'),
('20180222052324'),
('20180222055324'),
('20180224021819'),
('20180224022708'),
('20180224050623'),
('20180227211752'),
('20180228014043'),
('20180228015916'),
('20180312231254'),
('20180312231602'),
('20180312231820'),
('20180314183608'),
('20180315233323');


