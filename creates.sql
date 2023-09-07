--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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
-- Name: address_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_details (
    zip_code integer NOT NULL,
    city character varying,
    state character varying
);


ALTER TABLE public.address_details OWNER TO postgres;

--
-- Name: category_name_translation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_name_translation (
    category_name_portugese character varying NOT NULL,
    category_name_english character varying
);


ALTER TABLE public.category_name_translation OWNER TO postgres;

--
-- Name: category_promotions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_promotions (
    promotion_code character varying NOT NULL,
    type_id integer,
    category_name character varying
);


ALTER TABLE public.category_promotions OWNER TO postgres;

--
-- Name: customer_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_data (
    customer_id character varying NOT NULL,
    zipcode integer,
    email character varying
);


ALTER TABLE public.customer_data OWNER TO postgres;

--
-- Name: login_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_details (
    name character varying NOT NULL,
    email_id character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.login_details OWNER TO postgres;

--
-- Name: login_details_adm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_details_adm (
    name character varying NOT NULL,
    email_id character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.login_details_adm OWNER TO postgres;

--
-- Name: order_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_details (
    order_id character varying NOT NULL,
    customer_id character varying,
    status character varying,
    purchase_timestamp character varying,
    delivered_timestamp character varying,
    estimated_delivery_timestamp character varying
);


ALTER TABLE public.order_details OWNER TO postgres;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_id character varying NOT NULL,
    order_item_id integer NOT NULL,
    product_id character varying,
    seller_id character varying,
    price numeric(6,2)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_payments (
    payment_id integer NOT NULL,
    order_id character varying,
    payment_type character varying,
    number_of_installments integer
);


ALTER TABLE public.order_payments OWNER TO postgres;

--
-- Name: order_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_reviews (
    review_id character varying NOT NULL,
    order_id character varying,
    review_score integer
);


ALTER TABLE public.order_reviews OWNER TO postgres;

--
-- Name: product_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_details (
    product_id character varying NOT NULL,
    category_name character varying,
    weight integer,
    length integer,
    height integer,
    width integer
);


ALTER TABLE public.product_details OWNER TO postgres;

--
-- Name: promotion_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_details (
    type_id integer NOT NULL,
    promotion_type character varying,
    discount_percentage integer
);


ALTER TABLE public.promotion_details OWNER TO postgres;

--
-- Name: seller_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seller_data (
    seller_id character varying NOT NULL,
    zip_code integer
);


ALTER TABLE public.seller_data OWNER TO postgres;

--
-- Name: address_details address_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address_details
    ADD CONSTRAINT address_details_pkey PRIMARY KEY (zip_code);


--
-- Name: category_name_translation category_name_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_name_translation
    ADD CONSTRAINT category_name_translation_pkey PRIMARY KEY (category_name_portugese);


--
-- Name: category_promotions category_promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_promotions
    ADD CONSTRAINT category_promotions_pkey PRIMARY KEY (promotion_code);


--
-- Name: customer_data customer_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_data
    ADD CONSTRAINT customer_data_pkey PRIMARY KEY (customer_id);


--
-- Name: login_details_adm login_details_adm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_details_adm
    ADD CONSTRAINT login_details_adm_pkey PRIMARY KEY (email_id);


--
-- Name: login_details login_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_details
    ADD CONSTRAINT login_details_pkey PRIMARY KEY (email_id);


--
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_id, order_item_id);


--
-- Name: order_payments order_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_payments
    ADD CONSTRAINT order_payments_pkey PRIMARY KEY (payment_id);


--
-- Name: order_reviews order_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_reviews
    ADD CONSTRAINT order_reviews_pkey PRIMARY KEY (review_id);


--
-- Name: product_details product_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_details
    ADD CONSTRAINT product_details_pkey PRIMARY KEY (product_id);


--
-- Name: promotion_details promotion_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_details
    ADD CONSTRAINT promotion_details_pkey PRIMARY KEY (type_id);


--
-- Name: seller_data seller_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_data
    ADD CONSTRAINT seller_data_pkey PRIMARY KEY (seller_id);


--
-- Name: address_details_zip_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_details_zip_code_idx ON public.address_details USING btree (zip_code);


--
-- Name: i_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_customer ON public.customer_data USING btree (customer_id);


--
-- Name: i_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_email ON public.customer_data USING btree (email);


--
-- Name: i_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_index ON public.customer_data USING btree (email);


--
-- Name: i_zipcode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_zipcode ON public.customer_data USING btree (zipcode);


--
-- Name: idx_customer_data_zipcode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_data_zipcode ON public.customer_data USING btree (zipcode);


--
-- Name: idx_order_details_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_details_customer_id ON public.order_details USING btree (customer_id);


--
-- Name: idx_order_details_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_details_status ON public.order_details USING btree (status);


--
-- Name: idx_order_items_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);


--
-- Name: idx_order_items_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_product_id ON public.order_items USING btree (product_id);


--
-- Name: idx_order_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_payments_order_id ON public.order_payments USING btree (order_id);


--
-- Name: idx_order_reviews_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_reviews_order_id ON public.order_reviews USING btree (order_id);


--
-- Name: idx_product_details_category_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_details_category_name ON public.product_details USING btree (category_name);


--
-- Name: order_details_order_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_details_order_id_idx ON public.order_details USING btree (order_id);


--
-- Name: order_details_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_details_status_idx ON public.order_details USING btree (status);


--
-- Name: order_items_order_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_items_order_id_idx ON public.order_items USING btree (order_id);


--
-- Name: category_promotions category_promotions_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_promotions
    ADD CONSTRAINT category_promotions_fkey FOREIGN KEY (type_id) REFERENCES public.promotion_details(type_id) NOT VALID;


--
-- Name: category_promotions category_promotions_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_promotions
    ADD CONSTRAINT category_promotions_fkey2 FOREIGN KEY (category_name) REFERENCES public.category_name_translation(category_name_portugese) NOT VALID;


--
-- Name: order_details order_details_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_fkey FOREIGN KEY (customer_id) REFERENCES public.customer_data(customer_id) NOT VALID;


--
-- Name: order_items order_items_a_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_a_fkey FOREIGN KEY (seller_id) REFERENCES public.seller_data(seller_id) NOT VALID;


--
-- Name: order_items order_items_b_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_b_fkey FOREIGN KEY (order_id) REFERENCES public.order_details(order_id) NOT VALID;


--
-- Name: order_items order_items_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_fkey FOREIGN KEY (product_id) REFERENCES public.product_details(product_id) NOT VALID;


--
-- Name: order_payments order_payments_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_payments
    ADD CONSTRAINT order_payments_fkey FOREIGN KEY (order_id) REFERENCES public.order_details(order_id) NOT VALID;


--
-- Name: order_reviews order_review_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_reviews
    ADD CONSTRAINT order_review_fkey FOREIGN KEY (order_id) REFERENCES public.order_details(order_id) NOT VALID;


--
-- Name: product_details product_details_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_details
    ADD CONSTRAINT product_details_fkey FOREIGN KEY (category_name) REFERENCES public.category_name_translation(category_name_portugese) NOT VALID;


--
-- Name: seller_data seller_data_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_data
    ADD CONSTRAINT seller_data_fkey FOREIGN KEY (zip_code) REFERENCES public.address_details(zip_code) NOT VALID;


--
-- Name: customer_data zipcode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_data
    ADD CONSTRAINT zipcode_fkey FOREIGN KEY (zipcode) REFERENCES public.address_details(zip_code) NOT VALID;


--
-- PostgreSQL database dump complete
--

