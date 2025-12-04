--
-- PostgreSQL database dump
--

-- Dumped from database version 13.18 (Debian 13.18-1.pgdg120+1)
-- Dumped by pg_dump version 13.18 (Ubuntu 13.18-1.pgdg20.04+1)

-- Started on 2024-12-26 23:16:56 -03

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA IF NOT EXISTS public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 18076)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 18082)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 18085)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 18089)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 18098)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 18101)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 18107)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 18113)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 18132)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 18138)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 18141)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 18144)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 18147)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 18153)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 18159)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18166)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 18169)
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18175)
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18181)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18184)
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18190)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18196)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18199)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18203)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18209)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18215)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18221)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18224)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18230)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18233)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18240)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18243)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18249)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18255)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18262)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18265)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18278)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 18284)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18290)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 18296)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 18300)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 18307)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 18311)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 18320)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 18328)
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 18334)
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 18340)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 18346)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 18352)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 18358)
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 18392)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 18398)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 18401)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 18404)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 18407)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 18413)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 18421)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 18427)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 18430)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 18433)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 18439)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 18447)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 18454)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 18457)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 18460)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 18465)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 18471)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 18477)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 18484)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 18490)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 18493)
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 18496)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 18502)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 18505)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 18508)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 18515)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 18521)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 18524)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 18533)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 18539)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 18545)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 18551)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 18557)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 18560)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 18564)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 18567)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 18573)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- TOC entry 3845 (class 0 OID 18076)
-- Dependencies: 200
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 3846 (class 0 OID 18082)
-- Dependencies: 201
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 3847 (class 0 OID 18085)
-- Dependencies: 202
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
4cb38d25-6840-476c-b323-cb4c9e6605f4	\N	auth-cookie	bf3cd271-f79f-489d-a33a-e1aeca2849af	e48179f0-8957-479e-9d9a-fbb86745f579	2	10	f	\N	\N
30f822f1-c447-40c6-9fdc-fe5f18e38969	\N	auth-spnego	bf3cd271-f79f-489d-a33a-e1aeca2849af	e48179f0-8957-479e-9d9a-fbb86745f579	3	20	f	\N	\N
997bd2b6-bbe8-4250-8fd0-1fc9cf7570a7	\N	identity-provider-redirector	bf3cd271-f79f-489d-a33a-e1aeca2849af	e48179f0-8957-479e-9d9a-fbb86745f579	2	25	f	\N	\N
0bcc9e8c-a2f1-4e14-9d1f-a5e390cbd032	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	e48179f0-8957-479e-9d9a-fbb86745f579	2	30	t	757876ab-c1b4-49c3-a717-9087e7f478df	\N
f7252ffb-61da-47fd-9d31-7a80db68e2b3	\N	auth-username-password-form	bf3cd271-f79f-489d-a33a-e1aeca2849af	757876ab-c1b4-49c3-a717-9087e7f478df	0	10	f	\N	\N
90772faf-23e9-4b87-98c7-401937c4eade	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	757876ab-c1b4-49c3-a717-9087e7f478df	1	20	t	03d1db9a-018e-4c3c-8a8e-8d2b70ba53ce	\N
7363c3bd-827a-48b3-9c97-a4fc4a4b0974	\N	conditional-user-configured	bf3cd271-f79f-489d-a33a-e1aeca2849af	03d1db9a-018e-4c3c-8a8e-8d2b70ba53ce	0	10	f	\N	\N
a5d00910-e2ce-4b63-a5b1-1dd930bffaf7	\N	auth-otp-form	bf3cd271-f79f-489d-a33a-e1aeca2849af	03d1db9a-018e-4c3c-8a8e-8d2b70ba53ce	0	20	f	\N	\N
fd67de33-e9a0-4072-93da-be3c9fb108d3	\N	direct-grant-validate-username	bf3cd271-f79f-489d-a33a-e1aeca2849af	0fe48bc9-79fb-4f47-b123-69eb12ded4cc	0	10	f	\N	\N
d11d4b63-9bd2-478f-b7dd-97738995623e	\N	direct-grant-validate-password	bf3cd271-f79f-489d-a33a-e1aeca2849af	0fe48bc9-79fb-4f47-b123-69eb12ded4cc	0	20	f	\N	\N
23ced02b-ab83-42c7-98b0-aaa6db1ea5a8	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	0fe48bc9-79fb-4f47-b123-69eb12ded4cc	1	30	t	07baca30-f43b-4f52-a57e-1334e1a13609	\N
19d9c0c6-a953-409f-9373-28eb0e1acfd6	\N	conditional-user-configured	bf3cd271-f79f-489d-a33a-e1aeca2849af	07baca30-f43b-4f52-a57e-1334e1a13609	0	10	f	\N	\N
27654a89-2de4-45bc-92d9-a257d307a75e	\N	direct-grant-validate-otp	bf3cd271-f79f-489d-a33a-e1aeca2849af	07baca30-f43b-4f52-a57e-1334e1a13609	0	20	f	\N	\N
4db8a952-d876-4990-ab00-b42482e695f1	\N	registration-page-form	bf3cd271-f79f-489d-a33a-e1aeca2849af	36bd0b42-6171-4a84-a019-f308e618d6d1	0	10	t	6f7ac592-7025-4a4c-bb10-b4befb4a0d5b	\N
f914cb34-4920-4f0c-bf1b-749a566abd13	\N	registration-user-creation	bf3cd271-f79f-489d-a33a-e1aeca2849af	6f7ac592-7025-4a4c-bb10-b4befb4a0d5b	0	20	f	\N	\N
b32e00df-a8c0-4f29-b374-181c4398b14e	\N	registration-password-action	bf3cd271-f79f-489d-a33a-e1aeca2849af	6f7ac592-7025-4a4c-bb10-b4befb4a0d5b	0	50	f	\N	\N
f25d90f9-69c4-4c35-a9af-232c48934119	\N	registration-recaptcha-action	bf3cd271-f79f-489d-a33a-e1aeca2849af	6f7ac592-7025-4a4c-bb10-b4befb4a0d5b	3	60	f	\N	\N
1106cace-43f7-42ee-b036-9f26fa52906b	\N	registration-terms-and-conditions	bf3cd271-f79f-489d-a33a-e1aeca2849af	6f7ac592-7025-4a4c-bb10-b4befb4a0d5b	3	70	f	\N	\N
0e9791ff-9322-4452-8165-6e4e2884e460	\N	reset-credentials-choose-user	bf3cd271-f79f-489d-a33a-e1aeca2849af	2cf981d1-aa18-4ab4-8fb1-7e3278232253	0	10	f	\N	\N
067078dc-21e3-42b9-89b2-9cb48bbe575b	\N	reset-credential-email	bf3cd271-f79f-489d-a33a-e1aeca2849af	2cf981d1-aa18-4ab4-8fb1-7e3278232253	0	20	f	\N	\N
46ff5419-f061-494e-93bf-d2cb3586309c	\N	reset-password	bf3cd271-f79f-489d-a33a-e1aeca2849af	2cf981d1-aa18-4ab4-8fb1-7e3278232253	0	30	f	\N	\N
d21f9196-b951-45df-b5fd-93b90f997251	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	2cf981d1-aa18-4ab4-8fb1-7e3278232253	1	40	t	1255f50b-ac48-4134-8363-a02e37462540	\N
6796c6ad-32a1-4cb7-a20b-5148f6825c15	\N	conditional-user-configured	bf3cd271-f79f-489d-a33a-e1aeca2849af	1255f50b-ac48-4134-8363-a02e37462540	0	10	f	\N	\N
27d7284b-028f-4e84-9c8e-38a3f9b2db4d	\N	reset-otp	bf3cd271-f79f-489d-a33a-e1aeca2849af	1255f50b-ac48-4134-8363-a02e37462540	0	20	f	\N	\N
7937ceae-6392-496e-a276-40ab521a10be	\N	client-secret	bf3cd271-f79f-489d-a33a-e1aeca2849af	dc634955-6e64-44e1-96ec-ab22505298dc	2	10	f	\N	\N
b537619c-3b41-4632-996f-a11d25347f4c	\N	client-jwt	bf3cd271-f79f-489d-a33a-e1aeca2849af	dc634955-6e64-44e1-96ec-ab22505298dc	2	20	f	\N	\N
d9d1b763-0eea-40ef-a45d-ca4fca3c34c2	\N	client-secret-jwt	bf3cd271-f79f-489d-a33a-e1aeca2849af	dc634955-6e64-44e1-96ec-ab22505298dc	2	30	f	\N	\N
37fbafa1-4f0f-4f91-b0a5-0dcdb844e105	\N	client-x509	bf3cd271-f79f-489d-a33a-e1aeca2849af	dc634955-6e64-44e1-96ec-ab22505298dc	2	40	f	\N	\N
5b76b8d4-0c3a-4ac8-8541-717f718804bd	\N	idp-review-profile	bf3cd271-f79f-489d-a33a-e1aeca2849af	c0629136-b1a6-4f81-9a72-8edff1213c42	0	10	f	\N	fc1b0931-3990-4c4b-8f69-cdcc7958e376
9c7bcc48-5648-4790-a10d-56a037d1c69d	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	c0629136-b1a6-4f81-9a72-8edff1213c42	0	20	t	04677dc0-4f1c-4382-b40d-f95c8af0c334	\N
0e830982-1231-415b-be1c-7ab7e49a9a95	\N	idp-create-user-if-unique	bf3cd271-f79f-489d-a33a-e1aeca2849af	04677dc0-4f1c-4382-b40d-f95c8af0c334	2	10	f	\N	c179a0e1-fd6a-4d2f-9157-4a4c3e42a113
29f55c89-d07a-419f-80bc-331b9da196f1	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	04677dc0-4f1c-4382-b40d-f95c8af0c334	2	20	t	59a360bd-18a1-4a60-8cad-d1b43cfe446f	\N
92f3e8b1-a7dc-4fae-8dcd-d61c5a77e2d5	\N	idp-confirm-link	bf3cd271-f79f-489d-a33a-e1aeca2849af	59a360bd-18a1-4a60-8cad-d1b43cfe446f	0	10	f	\N	\N
f76fa6b4-a8a1-4e30-9115-4fdd8afa1022	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	59a360bd-18a1-4a60-8cad-d1b43cfe446f	0	20	t	4cfd91dc-3184-46a3-923d-184e56139431	\N
67660e72-b7ec-46cd-8915-6150e02e0a7d	\N	idp-email-verification	bf3cd271-f79f-489d-a33a-e1aeca2849af	4cfd91dc-3184-46a3-923d-184e56139431	2	10	f	\N	\N
8b035800-090a-4989-ad16-8a8c766b202b	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	4cfd91dc-3184-46a3-923d-184e56139431	2	20	t	0d15c2ef-fb87-4641-8358-c2c61659373f	\N
6207e631-a2a1-4130-b96f-6c44d8cdaadb	\N	idp-username-password-form	bf3cd271-f79f-489d-a33a-e1aeca2849af	0d15c2ef-fb87-4641-8358-c2c61659373f	0	10	f	\N	\N
0189d20c-f934-43b3-98eb-ba55e3928d20	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	0d15c2ef-fb87-4641-8358-c2c61659373f	1	20	t	ac10ca78-c96e-4a47-a649-b9b1b85f3ae0	\N
50f16e02-a39d-4e3c-b3a9-be4517185429	\N	conditional-user-configured	bf3cd271-f79f-489d-a33a-e1aeca2849af	ac10ca78-c96e-4a47-a649-b9b1b85f3ae0	0	10	f	\N	\N
a25ed000-02ab-4eaf-bdd6-e1e4aaf5a258	\N	auth-otp-form	bf3cd271-f79f-489d-a33a-e1aeca2849af	ac10ca78-c96e-4a47-a649-b9b1b85f3ae0	0	20	f	\N	\N
e733a389-de62-481e-acbc-f9cadcc5cc40	\N	http-basic-authenticator	bf3cd271-f79f-489d-a33a-e1aeca2849af	962ae3f4-fe08-40fa-a1f8-ef125ae7af96	0	10	f	\N	\N
3752e773-8e9f-424f-81c7-1e285f290730	\N	docker-http-basic-authenticator	bf3cd271-f79f-489d-a33a-e1aeca2849af	3ed1f255-8df3-455e-8097-d0186d2ce6f4	0	10	f	\N	\N
78401468-7373-4a5a-b92c-d09ba8a16f66	\N	auth-cookie	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	17a62cd8-7e35-4d7a-9907-cdc530d8557b	2	10	f	\N	\N
6dc81559-01a3-4cc0-90d4-677e3eab8d8d	\N	auth-spnego	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	17a62cd8-7e35-4d7a-9907-cdc530d8557b	3	20	f	\N	\N
9d0aedbb-2dd3-4067-a109-a50685246317	\N	identity-provider-redirector	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	17a62cd8-7e35-4d7a-9907-cdc530d8557b	2	25	f	\N	\N
d063ae94-93d3-4a83-9ea3-ba93cc8a95fc	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	17a62cd8-7e35-4d7a-9907-cdc530d8557b	2	30	t	f7e06ee7-5dcb-4ae7-b1b0-8dc80c6a0a3c	\N
c11f4eb9-f793-4919-8b17-ef849f966f28	\N	auth-username-password-form	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f7e06ee7-5dcb-4ae7-b1b0-8dc80c6a0a3c	0	10	f	\N	\N
10f43559-29bf-4b4a-a7de-3fcaa5431afa	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f7e06ee7-5dcb-4ae7-b1b0-8dc80c6a0a3c	1	20	t	758ded1e-70c8-4778-8849-6d8028881f14	\N
ba7a9999-f642-472a-bbcf-b875c16bfc68	\N	conditional-user-configured	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	758ded1e-70c8-4778-8849-6d8028881f14	0	10	f	\N	\N
6854b327-e646-4a2e-9a83-6cb99ff8b009	\N	auth-otp-form	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	758ded1e-70c8-4778-8849-6d8028881f14	0	20	f	\N	\N
c3b94d8d-d0ae-4999-9272-300edf9dfab3	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	17a62cd8-7e35-4d7a-9907-cdc530d8557b	2	26	t	f520ac7c-2466-41a6-91a9-4a24ff586924	\N
bc1e7c7b-1ec5-45dc-b55b-abca0c5aeb4f	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f520ac7c-2466-41a6-91a9-4a24ff586924	1	10	t	f9aa9790-4785-49ed-a306-08f4776595e0	\N
ababa637-5801-4f6c-855a-3497e42e753c	\N	conditional-user-configured	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f9aa9790-4785-49ed-a306-08f4776595e0	0	10	f	\N	\N
7ab44bff-b46f-41ef-a4bd-531166be00aa	\N	organization	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f9aa9790-4785-49ed-a306-08f4776595e0	2	20	f	\N	\N
3d086b06-c884-4a88-92b5-3130a48ac4c5	\N	direct-grant-validate-username	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	d7b3d4f3-f7fa-4224-a252-a621894904c4	0	10	f	\N	\N
cfeb9303-ffe8-4d7f-a075-017a0cb63f63	\N	direct-grant-validate-password	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	d7b3d4f3-f7fa-4224-a252-a621894904c4	0	20	f	\N	\N
e942a384-2d4d-4189-bed0-c8f9e6e61382	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	d7b3d4f3-f7fa-4224-a252-a621894904c4	1	30	t	dd7a0df3-a90f-438d-a2cd-bcebf1114cff	\N
e2ec7e90-f17b-4c62-9cbb-7a628db834ec	\N	conditional-user-configured	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dd7a0df3-a90f-438d-a2cd-bcebf1114cff	0	10	f	\N	\N
06ca25dc-9c59-4df3-a017-9a7f644c2c1f	\N	direct-grant-validate-otp	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dd7a0df3-a90f-438d-a2cd-bcebf1114cff	0	20	f	\N	\N
7732e9d4-33c3-48e2-afe2-10e4b62ffe80	\N	registration-page-form	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	a65ec2c7-5b40-417a-900c-e9fdc971f0f8	0	10	t	cc8ba1d0-b5a8-48ad-bae1-0d07da4de124	\N
28077a0c-0071-4926-9045-c4f9c865067d	\N	registration-user-creation	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	cc8ba1d0-b5a8-48ad-bae1-0d07da4de124	0	20	f	\N	\N
7d78fb1a-cdff-4f19-8071-bda5235e959d	\N	registration-password-action	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	cc8ba1d0-b5a8-48ad-bae1-0d07da4de124	0	50	f	\N	\N
292025d5-a7a5-480a-8ad3-b3552f22e069	\N	registration-recaptcha-action	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	cc8ba1d0-b5a8-48ad-bae1-0d07da4de124	3	60	f	\N	\N
12dcb172-2b46-4bc3-93f4-69189633a5df	\N	registration-terms-and-conditions	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	cc8ba1d0-b5a8-48ad-bae1-0d07da4de124	3	70	f	\N	\N
77fc3d54-c16b-4b44-a8c3-9813be0ef969	\N	reset-credentials-choose-user	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	ea8cd307-0a99-41bb-8977-58090aa8a001	0	10	f	\N	\N
3776e763-0a40-462a-8c98-cfe21c735a1b	\N	reset-credential-email	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	ea8cd307-0a99-41bb-8977-58090aa8a001	0	20	f	\N	\N
e9c00d84-ec1a-49dc-95fa-3311d1e8aa0a	\N	reset-password	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	ea8cd307-0a99-41bb-8977-58090aa8a001	0	30	f	\N	\N
624394ce-1fbe-4b9c-a5b4-92c4b4c75c27	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	ea8cd307-0a99-41bb-8977-58090aa8a001	1	40	t	1bbb43b6-d6a5-4812-b4a6-9b427219d48a	\N
bbdf852f-4bf1-4588-a44e-0a6d402e3237	\N	conditional-user-configured	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	1bbb43b6-d6a5-4812-b4a6-9b427219d48a	0	10	f	\N	\N
d6b611ca-0185-4bd5-8f25-a772667b8338	\N	reset-otp	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	1bbb43b6-d6a5-4812-b4a6-9b427219d48a	0	20	f	\N	\N
9ba32c49-d0d4-459f-ba0a-dda25b1b8c36	\N	client-secret	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	24cd17e5-ec8f-4f77-b552-292316a8707b	2	10	f	\N	\N
0f6c502b-9799-4f1d-9937-ed8ba2e582fb	\N	client-jwt	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	24cd17e5-ec8f-4f77-b552-292316a8707b	2	20	f	\N	\N
37e9cf0d-dc0f-4ce8-9502-0c3e17104a75	\N	client-secret-jwt	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	24cd17e5-ec8f-4f77-b552-292316a8707b	2	30	f	\N	\N
7d9e7371-0753-4909-89eb-6dc8c855ea07	\N	client-x509	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	24cd17e5-ec8f-4f77-b552-292316a8707b	2	40	f	\N	\N
47fcc3b5-fe0d-4e32-99a1-2b292e1c4b55	\N	idp-review-profile	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	fbcdeb53-6213-445f-9e81-8ba5c3255827	0	10	f	\N	c70aa9c3-ad09-463c-a67f-29df1598cf19
957f2c6d-27b7-4390-bd97-342cb6e3eecf	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	fbcdeb53-6213-445f-9e81-8ba5c3255827	0	20	t	88bccbf9-7ee4-4641-9d21-1c361b544890	\N
4b0be2a4-2f72-43b1-bb18-3dcbb388acf8	\N	idp-create-user-if-unique	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	88bccbf9-7ee4-4641-9d21-1c361b544890	2	10	f	\N	720584f6-d682-4716-9950-108ea0571ba0
133590bb-1a06-4169-b524-b2bb78735fba	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	88bccbf9-7ee4-4641-9d21-1c361b544890	2	20	t	dc6b423c-0647-4ccc-86d5-c7e3e77d28b1	\N
35c9fb79-eb1e-4d18-9f6f-17171a3eb9af	\N	idp-confirm-link	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dc6b423c-0647-4ccc-86d5-c7e3e77d28b1	0	10	f	\N	\N
79f3b57b-b287-4ef5-b045-8594d7b66a72	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dc6b423c-0647-4ccc-86d5-c7e3e77d28b1	0	20	t	9a82f4a9-1721-4fe2-abeb-c6cf5e38886a	\N
f440a773-9a93-435f-b7ae-2f55dd7b133e	\N	idp-email-verification	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	9a82f4a9-1721-4fe2-abeb-c6cf5e38886a	2	10	f	\N	\N
932fc277-4283-43b2-ad1d-20bdf8c1790b	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	9a82f4a9-1721-4fe2-abeb-c6cf5e38886a	2	20	t	5fa9b475-f2c2-4e81-a986-a5461afd6a78	\N
e7f1e058-cbaa-4f87-acbf-d394a39d78b0	\N	idp-username-password-form	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	5fa9b475-f2c2-4e81-a986-a5461afd6a78	0	10	f	\N	\N
6cf16837-d28f-4df1-aab2-83e81b22a556	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	5fa9b475-f2c2-4e81-a986-a5461afd6a78	1	20	t	e43c6106-67ef-4458-83ce-086f3be83893	\N
1d41e2ac-134f-4eed-a07b-a7c9056e8c94	\N	conditional-user-configured	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	e43c6106-67ef-4458-83ce-086f3be83893	0	10	f	\N	\N
d4b9645e-503b-40ae-8bd5-81931ec6ae4f	\N	auth-otp-form	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	e43c6106-67ef-4458-83ce-086f3be83893	0	20	f	\N	\N
d92d44af-be98-4dd6-a093-dbcb6851191c	\N	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	fbcdeb53-6213-445f-9e81-8ba5c3255827	1	50	t	341ebd31-17a0-4e45-ab74-69e616c00dc7	\N
4502c654-714e-4d44-950a-265533089971	\N	conditional-user-configured	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	341ebd31-17a0-4e45-ab74-69e616c00dc7	0	10	f	\N	\N
f5d53692-5e5e-4c8a-9f6c-d09b8f907745	\N	idp-add-organization-member	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	341ebd31-17a0-4e45-ab74-69e616c00dc7	0	20	f	\N	\N
8a9b5312-921c-40ad-ad30-8fa4fc038f48	\N	http-basic-authenticator	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	354473a1-9816-40ef-92fa-705423db80b3	0	10	f	\N	\N
2b7391f5-ca45-4805-af59-6364051ba86b	\N	docker-http-basic-authenticator	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	9ed044f7-b221-490c-aabf-30206d3d0560	0	10	f	\N	\N
\.


--
-- TOC entry 3848 (class 0 OID 18089)
-- Dependencies: 203
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
e48179f0-8957-479e-9d9a-fbb86745f579	browser	Browser based authentication	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
757876ab-c1b4-49c3-a717-9087e7f478df	forms	Username, password, otp and other auth forms.	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
03d1db9a-018e-4c3c-8a8e-8d2b70ba53ce	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
0fe48bc9-79fb-4f47-b123-69eb12ded4cc	direct grant	OpenID Connect Resource Owner Grant	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
07baca30-f43b-4f52-a57e-1334e1a13609	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
36bd0b42-6171-4a84-a019-f308e618d6d1	registration	Registration flow	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
6f7ac592-7025-4a4c-bb10-b4befb4a0d5b	registration form	Registration form	bf3cd271-f79f-489d-a33a-e1aeca2849af	form-flow	f	t
2cf981d1-aa18-4ab4-8fb1-7e3278232253	reset credentials	Reset credentials for a user if they forgot their password or something	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
1255f50b-ac48-4134-8363-a02e37462540	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
dc634955-6e64-44e1-96ec-ab22505298dc	clients	Base authentication for clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	client-flow	t	t
c0629136-b1a6-4f81-9a72-8edff1213c42	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
04677dc0-4f1c-4382-b40d-f95c8af0c334	User creation or linking	Flow for the existing/non-existing user alternatives	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
59a360bd-18a1-4a60-8cad-d1b43cfe446f	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
4cfd91dc-3184-46a3-923d-184e56139431	Account verification options	Method with which to verity the existing account	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
0d15c2ef-fb87-4641-8358-c2c61659373f	Verify Existing Account by Re-authentication	Reauthentication of existing account	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
ac10ca78-c96e-4a47-a649-b9b1b85f3ae0	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	f	t
962ae3f4-fe08-40fa-a1f8-ef125ae7af96	saml ecp	SAML ECP Profile Authentication Flow	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
3ed1f255-8df3-455e-8097-d0186d2ce6f4	docker auth	Used by Docker clients to authenticate against the IDP	bf3cd271-f79f-489d-a33a-e1aeca2849af	basic-flow	t	t
17a62cd8-7e35-4d7a-9907-cdc530d8557b	browser	Browser based authentication	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
f7e06ee7-5dcb-4ae7-b1b0-8dc80c6a0a3c	forms	Username, password, otp and other auth forms.	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
758ded1e-70c8-4778-8849-6d8028881f14	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
f520ac7c-2466-41a6-91a9-4a24ff586924	Organization	\N	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
f9aa9790-4785-49ed-a306-08f4776595e0	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
d7b3d4f3-f7fa-4224-a252-a621894904c4	direct grant	OpenID Connect Resource Owner Grant	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
dd7a0df3-a90f-438d-a2cd-bcebf1114cff	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
a65ec2c7-5b40-417a-900c-e9fdc971f0f8	registration	Registration flow	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
cc8ba1d0-b5a8-48ad-bae1-0d07da4de124	registration form	Registration form	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	form-flow	f	t
ea8cd307-0a99-41bb-8977-58090aa8a001	reset credentials	Reset credentials for a user if they forgot their password or something	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
1bbb43b6-d6a5-4812-b4a6-9b427219d48a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
24cd17e5-ec8f-4f77-b552-292316a8707b	clients	Base authentication for clients	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	client-flow	t	t
fbcdeb53-6213-445f-9e81-8ba5c3255827	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
88bccbf9-7ee4-4641-9d21-1c361b544890	User creation or linking	Flow for the existing/non-existing user alternatives	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
dc6b423c-0647-4ccc-86d5-c7e3e77d28b1	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
9a82f4a9-1721-4fe2-abeb-c6cf5e38886a	Account verification options	Method with which to verity the existing account	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
5fa9b475-f2c2-4e81-a986-a5461afd6a78	Verify Existing Account by Re-authentication	Reauthentication of existing account	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
e43c6106-67ef-4458-83ce-086f3be83893	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
341ebd31-17a0-4e45-ab74-69e616c00dc7	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	f	t
354473a1-9816-40ef-92fa-705423db80b3	saml ecp	SAML ECP Profile Authentication Flow	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
9ed044f7-b221-490c-aabf-30206d3d0560	docker auth	Used by Docker clients to authenticate against the IDP	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	basic-flow	t	t
\.


--
-- TOC entry 3849 (class 0 OID 18098)
-- Dependencies: 204
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
fc1b0931-3990-4c4b-8f69-cdcc7958e376	review profile config	bf3cd271-f79f-489d-a33a-e1aeca2849af
c179a0e1-fd6a-4d2f-9157-4a4c3e42a113	create unique user config	bf3cd271-f79f-489d-a33a-e1aeca2849af
c70aa9c3-ad09-463c-a67f-29df1598cf19	review profile config	9ca9b3d8-7910-4305-b1de-cc6d98ebf981
720584f6-d682-4716-9950-108ea0571ba0	create unique user config	9ca9b3d8-7910-4305-b1de-cc6d98ebf981
\.


--
-- TOC entry 3850 (class 0 OID 18101)
-- Dependencies: 205
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
c179a0e1-fd6a-4d2f-9157-4a4c3e42a113	false	require.password.update.after.registration
fc1b0931-3990-4c4b-8f69-cdcc7958e376	missing	update.profile.on.first.login
720584f6-d682-4716-9950-108ea0571ba0	false	require.password.update.after.registration
c70aa9c3-ad09-463c-a67f-29df1598cf19	missing	update.profile.on.first.login
\.


--
-- TOC entry 3851 (class 0 OID 18107)
-- Dependencies: 206
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 3852 (class 0 OID 18113)
-- Dependencies: 207
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	f	master-realm	0	f	\N	\N	t	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a9df6a75-0443-4041-97b5-1016a7d512fb	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a4e68fcd-909a-48cd-9bd1-8efbd950929a	t	f	broker	0	f	\N	\N	t	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
828fc677-1d7d-422a-ada8-d33ab175027d	t	t	admin-cli	0	t	\N	\N	f	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	f	proposal-management-realm	0	f	\N	\N	t	\N	f	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	0	f	f	proposal-management Realm	f	client-secret	\N	\N	\N	t	f	f	f
f34a27af-46aa-4315-9247-142cb401abbf	t	f	realm-management	0	f	\N	\N	t	\N	f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
dbf4bcf0-60b6-4aec-af0f-14a975689023	t	f	account	0	t	\N	/realms/proposal-management/account/	f	\N	f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	t	f	account-console	0	t	\N	/realms/proposal-management/account/	f	\N	f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a6bd137d-19f9-4691-a007-5aa4127adcaa	t	f	broker	0	f	\N	\N	t	\N	f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
fc9cf51f-87d1-4020-b812-9a127e479ccd	t	t	security-admin-console	0	t	\N	/admin/proposal-management/console/	f	\N	f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
8a84672d-a9e0-4e67-ba74-c431a34739f1	t	t	admin-cli	0	t	\N	\N	f	\N	f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
84da2b2c-e7d5-4b35-9982-218c0f159e0b	t	t	proposal-management-client-private	0	f	v4ctHK7d8Y6HZ6wmcrMuKtmp4ItWOH0m		f		f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- TOC entry 3853 (class 0 OID 18132)
-- Dependencies: 208
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	post.logout.redirect.uris	+
a9df6a75-0443-4041-97b5-1016a7d512fb	post.logout.redirect.uris	+
a9df6a75-0443-4041-97b5-1016a7d512fb	pkce.code.challenge.method	S256
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	post.logout.redirect.uris	+
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	pkce.code.challenge.method	S256
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	client.use.lightweight.access.token.enabled	true
828fc677-1d7d-422a-ada8-d33ab175027d	client.use.lightweight.access.token.enabled	true
dbf4bcf0-60b6-4aec-af0f-14a975689023	post.logout.redirect.uris	+
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	post.logout.redirect.uris	+
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	pkce.code.challenge.method	S256
fc9cf51f-87d1-4020-b812-9a127e479ccd	post.logout.redirect.uris	+
fc9cf51f-87d1-4020-b812-9a127e479ccd	pkce.code.challenge.method	S256
fc9cf51f-87d1-4020-b812-9a127e479ccd	client.use.lightweight.access.token.enabled	true
8a84672d-a9e0-4e67-ba74-c431a34739f1	client.use.lightweight.access.token.enabled	true
84da2b2c-e7d5-4b35-9982-218c0f159e0b	client.secret.creation.time	1735265525
84da2b2c-e7d5-4b35-9982-218c0f159e0b	oauth2.device.authorization.grant.enabled	false
84da2b2c-e7d5-4b35-9982-218c0f159e0b	oidc.ciba.grant.enabled	false
84da2b2c-e7d5-4b35-9982-218c0f159e0b	backchannel.logout.session.required	true
84da2b2c-e7d5-4b35-9982-218c0f159e0b	backchannel.logout.revoke.offline.tokens	false
\.


--
-- TOC entry 3854 (class 0 OID 18138)
-- Dependencies: 209
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 3855 (class 0 OID 18141)
-- Dependencies: 210
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 3856 (class 0 OID 18144)
-- Dependencies: 211
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 3857 (class 0 OID 18147)
-- Dependencies: 212
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	offline_access	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect built-in scope: offline_access	openid-connect
c07a62d9-68ff-404a-a20f-e9eb260ceca5	role_list	bf3cd271-f79f-489d-a33a-e1aeca2849af	SAML role list	saml
0e42659d-232f-48f9-85a6-26b16c65d76c	saml_organization	bf3cd271-f79f-489d-a33a-e1aeca2849af	Organization Membership	saml
0d4b0360-9364-4396-a059-281903d83c52	profile	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect built-in scope: profile	openid-connect
ed7292f9-f5c6-4dcf-beff-640ba072c94e	email	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect built-in scope: email	openid-connect
06c3c5f6-673f-4416-91e6-696d94818c99	address	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect built-in scope: address	openid-connect
c69bf813-3caa-47b0-ac87-57af202cad60	phone	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect built-in scope: phone	openid-connect
773ba6f5-099c-4d5e-b8e1-02aa82a70b91	roles	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect scope for add user roles to the access token	openid-connect
5076853e-f4a8-43c9-8489-ff40a6de64e8	web-origins	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect scope for add allowed web origins to the access token	openid-connect
fc7ba391-55e0-4225-acb7-554c5096caad	microprofile-jwt	bf3cd271-f79f-489d-a33a-e1aeca2849af	Microprofile - JWT built-in scope	openid-connect
d44e15d0-09d3-49d2-82af-1dd0c86388c0	acr	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
64a584f8-43ee-4d37-a71b-4bb7d0145da3	basic	bf3cd271-f79f-489d-a33a-e1aeca2849af	OpenID Connect scope for add all basic claims to the token	openid-connect
ff18f871-b157-425a-b7f1-f5b8eca1ecff	organization	bf3cd271-f79f-489d-a33a-e1aeca2849af	Additional claims about the organization a subject belongs to	openid-connect
512ec048-be84-4a1a-bae8-c6762276641d	offline_access	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect built-in scope: offline_access	openid-connect
0cc25f38-25d2-4ff5-b0b4-9b50f2b0cdc7	role_list	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	SAML role list	saml
c31d724d-7359-463b-9fb7-6248b8d2e896	saml_organization	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	Organization Membership	saml
c7560195-2713-42c6-b0c4-fde589d61209	profile	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect built-in scope: profile	openid-connect
72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	email	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect built-in scope: email	openid-connect
4fd1dced-51b1-4bef-864f-e2fa30c42b98	address	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect built-in scope: address	openid-connect
0a67fb41-44eb-4848-b5e3-eb3c04e9892e	phone	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect built-in scope: phone	openid-connect
67df8efa-16d5-45f0-9cc9-385cc9c770f3	roles	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect scope for add user roles to the access token	openid-connect
bf081ef6-7a73-42ae-9039-843cc153126e	web-origins	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect scope for add allowed web origins to the access token	openid-connect
c2be3976-92c4-4463-b593-4b6384ad7243	microprofile-jwt	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	Microprofile - JWT built-in scope	openid-connect
9ba54981-2673-4418-8dca-3a856130a574	acr	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
d67a9f3a-fef0-4b26-a26a-4dd58e989387	basic	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	OpenID Connect scope for add all basic claims to the token	openid-connect
c74a24bb-ee5b-427a-897c-579438cc4115	organization	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- TOC entry 3858 (class 0 OID 18153)
-- Dependencies: 213
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	true	display.on.consent.screen
b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	${offlineAccessScopeConsentText}	consent.screen.text
c07a62d9-68ff-404a-a20f-e9eb260ceca5	true	display.on.consent.screen
c07a62d9-68ff-404a-a20f-e9eb260ceca5	${samlRoleListScopeConsentText}	consent.screen.text
0e42659d-232f-48f9-85a6-26b16c65d76c	false	display.on.consent.screen
0d4b0360-9364-4396-a059-281903d83c52	true	display.on.consent.screen
0d4b0360-9364-4396-a059-281903d83c52	${profileScopeConsentText}	consent.screen.text
0d4b0360-9364-4396-a059-281903d83c52	true	include.in.token.scope
ed7292f9-f5c6-4dcf-beff-640ba072c94e	true	display.on.consent.screen
ed7292f9-f5c6-4dcf-beff-640ba072c94e	${emailScopeConsentText}	consent.screen.text
ed7292f9-f5c6-4dcf-beff-640ba072c94e	true	include.in.token.scope
06c3c5f6-673f-4416-91e6-696d94818c99	true	display.on.consent.screen
06c3c5f6-673f-4416-91e6-696d94818c99	${addressScopeConsentText}	consent.screen.text
06c3c5f6-673f-4416-91e6-696d94818c99	true	include.in.token.scope
c69bf813-3caa-47b0-ac87-57af202cad60	true	display.on.consent.screen
c69bf813-3caa-47b0-ac87-57af202cad60	${phoneScopeConsentText}	consent.screen.text
c69bf813-3caa-47b0-ac87-57af202cad60	true	include.in.token.scope
773ba6f5-099c-4d5e-b8e1-02aa82a70b91	true	display.on.consent.screen
773ba6f5-099c-4d5e-b8e1-02aa82a70b91	${rolesScopeConsentText}	consent.screen.text
773ba6f5-099c-4d5e-b8e1-02aa82a70b91	false	include.in.token.scope
5076853e-f4a8-43c9-8489-ff40a6de64e8	false	display.on.consent.screen
5076853e-f4a8-43c9-8489-ff40a6de64e8		consent.screen.text
5076853e-f4a8-43c9-8489-ff40a6de64e8	false	include.in.token.scope
fc7ba391-55e0-4225-acb7-554c5096caad	false	display.on.consent.screen
fc7ba391-55e0-4225-acb7-554c5096caad	true	include.in.token.scope
d44e15d0-09d3-49d2-82af-1dd0c86388c0	false	display.on.consent.screen
d44e15d0-09d3-49d2-82af-1dd0c86388c0	false	include.in.token.scope
64a584f8-43ee-4d37-a71b-4bb7d0145da3	false	display.on.consent.screen
64a584f8-43ee-4d37-a71b-4bb7d0145da3	false	include.in.token.scope
ff18f871-b157-425a-b7f1-f5b8eca1ecff	true	display.on.consent.screen
ff18f871-b157-425a-b7f1-f5b8eca1ecff	${organizationScopeConsentText}	consent.screen.text
ff18f871-b157-425a-b7f1-f5b8eca1ecff	true	include.in.token.scope
512ec048-be84-4a1a-bae8-c6762276641d	true	display.on.consent.screen
512ec048-be84-4a1a-bae8-c6762276641d	${offlineAccessScopeConsentText}	consent.screen.text
0cc25f38-25d2-4ff5-b0b4-9b50f2b0cdc7	true	display.on.consent.screen
0cc25f38-25d2-4ff5-b0b4-9b50f2b0cdc7	${samlRoleListScopeConsentText}	consent.screen.text
c31d724d-7359-463b-9fb7-6248b8d2e896	false	display.on.consent.screen
c7560195-2713-42c6-b0c4-fde589d61209	true	display.on.consent.screen
c7560195-2713-42c6-b0c4-fde589d61209	${profileScopeConsentText}	consent.screen.text
c7560195-2713-42c6-b0c4-fde589d61209	true	include.in.token.scope
72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	true	display.on.consent.screen
72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	${emailScopeConsentText}	consent.screen.text
72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	true	include.in.token.scope
4fd1dced-51b1-4bef-864f-e2fa30c42b98	true	display.on.consent.screen
4fd1dced-51b1-4bef-864f-e2fa30c42b98	${addressScopeConsentText}	consent.screen.text
4fd1dced-51b1-4bef-864f-e2fa30c42b98	true	include.in.token.scope
0a67fb41-44eb-4848-b5e3-eb3c04e9892e	true	display.on.consent.screen
0a67fb41-44eb-4848-b5e3-eb3c04e9892e	${phoneScopeConsentText}	consent.screen.text
0a67fb41-44eb-4848-b5e3-eb3c04e9892e	true	include.in.token.scope
67df8efa-16d5-45f0-9cc9-385cc9c770f3	true	display.on.consent.screen
67df8efa-16d5-45f0-9cc9-385cc9c770f3	${rolesScopeConsentText}	consent.screen.text
67df8efa-16d5-45f0-9cc9-385cc9c770f3	false	include.in.token.scope
bf081ef6-7a73-42ae-9039-843cc153126e	false	display.on.consent.screen
bf081ef6-7a73-42ae-9039-843cc153126e		consent.screen.text
bf081ef6-7a73-42ae-9039-843cc153126e	false	include.in.token.scope
c2be3976-92c4-4463-b593-4b6384ad7243	false	display.on.consent.screen
c2be3976-92c4-4463-b593-4b6384ad7243	true	include.in.token.scope
9ba54981-2673-4418-8dca-3a856130a574	false	display.on.consent.screen
9ba54981-2673-4418-8dca-3a856130a574	false	include.in.token.scope
d67a9f3a-fef0-4b26-a26a-4dd58e989387	false	display.on.consent.screen
d67a9f3a-fef0-4b26-a26a-4dd58e989387	false	include.in.token.scope
c74a24bb-ee5b-427a-897c-579438cc4115	true	display.on.consent.screen
c74a24bb-ee5b-427a-897c-579438cc4115	${organizationScopeConsentText}	consent.screen.text
c74a24bb-ee5b-427a-897c-579438cc4115	true	include.in.token.scope
\.


--
-- TOC entry 3859 (class 0 OID 18159)
-- Dependencies: 214
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	0d4b0360-9364-4396-a059-281903d83c52	t
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	06c3c5f6-673f-4416-91e6-696d94818c99	f
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	fc7ba391-55e0-4225-acb7-554c5096caad	f
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	c69bf813-3caa-47b0-ac87-57af202cad60	f
a9df6a75-0443-4041-97b5-1016a7d512fb	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
a9df6a75-0443-4041-97b5-1016a7d512fb	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
a9df6a75-0443-4041-97b5-1016a7d512fb	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
a9df6a75-0443-4041-97b5-1016a7d512fb	0d4b0360-9364-4396-a059-281903d83c52	t
a9df6a75-0443-4041-97b5-1016a7d512fb	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
a9df6a75-0443-4041-97b5-1016a7d512fb	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
a9df6a75-0443-4041-97b5-1016a7d512fb	06c3c5f6-673f-4416-91e6-696d94818c99	f
a9df6a75-0443-4041-97b5-1016a7d512fb	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
a9df6a75-0443-4041-97b5-1016a7d512fb	fc7ba391-55e0-4225-acb7-554c5096caad	f
a9df6a75-0443-4041-97b5-1016a7d512fb	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
a9df6a75-0443-4041-97b5-1016a7d512fb	c69bf813-3caa-47b0-ac87-57af202cad60	f
828fc677-1d7d-422a-ada8-d33ab175027d	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
828fc677-1d7d-422a-ada8-d33ab175027d	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
828fc677-1d7d-422a-ada8-d33ab175027d	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
828fc677-1d7d-422a-ada8-d33ab175027d	0d4b0360-9364-4396-a059-281903d83c52	t
828fc677-1d7d-422a-ada8-d33ab175027d	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
828fc677-1d7d-422a-ada8-d33ab175027d	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
828fc677-1d7d-422a-ada8-d33ab175027d	06c3c5f6-673f-4416-91e6-696d94818c99	f
828fc677-1d7d-422a-ada8-d33ab175027d	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
828fc677-1d7d-422a-ada8-d33ab175027d	fc7ba391-55e0-4225-acb7-554c5096caad	f
828fc677-1d7d-422a-ada8-d33ab175027d	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
828fc677-1d7d-422a-ada8-d33ab175027d	c69bf813-3caa-47b0-ac87-57af202cad60	f
a4e68fcd-909a-48cd-9bd1-8efbd950929a	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
a4e68fcd-909a-48cd-9bd1-8efbd950929a	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
a4e68fcd-909a-48cd-9bd1-8efbd950929a	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
a4e68fcd-909a-48cd-9bd1-8efbd950929a	0d4b0360-9364-4396-a059-281903d83c52	t
a4e68fcd-909a-48cd-9bd1-8efbd950929a	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
a4e68fcd-909a-48cd-9bd1-8efbd950929a	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
a4e68fcd-909a-48cd-9bd1-8efbd950929a	06c3c5f6-673f-4416-91e6-696d94818c99	f
a4e68fcd-909a-48cd-9bd1-8efbd950929a	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
a4e68fcd-909a-48cd-9bd1-8efbd950929a	fc7ba391-55e0-4225-acb7-554c5096caad	f
a4e68fcd-909a-48cd-9bd1-8efbd950929a	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
a4e68fcd-909a-48cd-9bd1-8efbd950929a	c69bf813-3caa-47b0-ac87-57af202cad60	f
be3f8dd2-4e37-4c5f-9e78-d249a0216110	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
be3f8dd2-4e37-4c5f-9e78-d249a0216110	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
be3f8dd2-4e37-4c5f-9e78-d249a0216110	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
be3f8dd2-4e37-4c5f-9e78-d249a0216110	0d4b0360-9364-4396-a059-281903d83c52	t
be3f8dd2-4e37-4c5f-9e78-d249a0216110	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
be3f8dd2-4e37-4c5f-9e78-d249a0216110	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
be3f8dd2-4e37-4c5f-9e78-d249a0216110	06c3c5f6-673f-4416-91e6-696d94818c99	f
be3f8dd2-4e37-4c5f-9e78-d249a0216110	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
be3f8dd2-4e37-4c5f-9e78-d249a0216110	fc7ba391-55e0-4225-acb7-554c5096caad	f
be3f8dd2-4e37-4c5f-9e78-d249a0216110	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
be3f8dd2-4e37-4c5f-9e78-d249a0216110	c69bf813-3caa-47b0-ac87-57af202cad60	f
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	0d4b0360-9364-4396-a059-281903d83c52	t
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	06c3c5f6-673f-4416-91e6-696d94818c99	f
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	fc7ba391-55e0-4225-acb7-554c5096caad	f
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	c69bf813-3caa-47b0-ac87-57af202cad60	f
dbf4bcf0-60b6-4aec-af0f-14a975689023	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
dbf4bcf0-60b6-4aec-af0f-14a975689023	c7560195-2713-42c6-b0c4-fde589d61209	t
dbf4bcf0-60b6-4aec-af0f-14a975689023	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
dbf4bcf0-60b6-4aec-af0f-14a975689023	bf081ef6-7a73-42ae-9039-843cc153126e	t
dbf4bcf0-60b6-4aec-af0f-14a975689023	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
dbf4bcf0-60b6-4aec-af0f-14a975689023	9ba54981-2673-4418-8dca-3a856130a574	t
dbf4bcf0-60b6-4aec-af0f-14a975689023	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
dbf4bcf0-60b6-4aec-af0f-14a975689023	c2be3976-92c4-4463-b593-4b6384ad7243	f
dbf4bcf0-60b6-4aec-af0f-14a975689023	c74a24bb-ee5b-427a-897c-579438cc4115	f
dbf4bcf0-60b6-4aec-af0f-14a975689023	512ec048-be84-4a1a-bae8-c6762276641d	f
dbf4bcf0-60b6-4aec-af0f-14a975689023	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	c7560195-2713-42c6-b0c4-fde589d61209	t
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	bf081ef6-7a73-42ae-9039-843cc153126e	t
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	9ba54981-2673-4418-8dca-3a856130a574	t
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	c2be3976-92c4-4463-b593-4b6384ad7243	f
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	c74a24bb-ee5b-427a-897c-579438cc4115	f
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	512ec048-be84-4a1a-bae8-c6762276641d	f
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
8a84672d-a9e0-4e67-ba74-c431a34739f1	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
8a84672d-a9e0-4e67-ba74-c431a34739f1	c7560195-2713-42c6-b0c4-fde589d61209	t
8a84672d-a9e0-4e67-ba74-c431a34739f1	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
8a84672d-a9e0-4e67-ba74-c431a34739f1	bf081ef6-7a73-42ae-9039-843cc153126e	t
8a84672d-a9e0-4e67-ba74-c431a34739f1	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
8a84672d-a9e0-4e67-ba74-c431a34739f1	9ba54981-2673-4418-8dca-3a856130a574	t
8a84672d-a9e0-4e67-ba74-c431a34739f1	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
8a84672d-a9e0-4e67-ba74-c431a34739f1	c2be3976-92c4-4463-b593-4b6384ad7243	f
8a84672d-a9e0-4e67-ba74-c431a34739f1	c74a24bb-ee5b-427a-897c-579438cc4115	f
8a84672d-a9e0-4e67-ba74-c431a34739f1	512ec048-be84-4a1a-bae8-c6762276641d	f
8a84672d-a9e0-4e67-ba74-c431a34739f1	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
a6bd137d-19f9-4691-a007-5aa4127adcaa	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
a6bd137d-19f9-4691-a007-5aa4127adcaa	c7560195-2713-42c6-b0c4-fde589d61209	t
a6bd137d-19f9-4691-a007-5aa4127adcaa	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
a6bd137d-19f9-4691-a007-5aa4127adcaa	bf081ef6-7a73-42ae-9039-843cc153126e	t
a6bd137d-19f9-4691-a007-5aa4127adcaa	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
a6bd137d-19f9-4691-a007-5aa4127adcaa	9ba54981-2673-4418-8dca-3a856130a574	t
a6bd137d-19f9-4691-a007-5aa4127adcaa	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
a6bd137d-19f9-4691-a007-5aa4127adcaa	c2be3976-92c4-4463-b593-4b6384ad7243	f
a6bd137d-19f9-4691-a007-5aa4127adcaa	c74a24bb-ee5b-427a-897c-579438cc4115	f
a6bd137d-19f9-4691-a007-5aa4127adcaa	512ec048-be84-4a1a-bae8-c6762276641d	f
a6bd137d-19f9-4691-a007-5aa4127adcaa	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
f34a27af-46aa-4315-9247-142cb401abbf	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
f34a27af-46aa-4315-9247-142cb401abbf	c7560195-2713-42c6-b0c4-fde589d61209	t
f34a27af-46aa-4315-9247-142cb401abbf	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
f34a27af-46aa-4315-9247-142cb401abbf	bf081ef6-7a73-42ae-9039-843cc153126e	t
f34a27af-46aa-4315-9247-142cb401abbf	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
f34a27af-46aa-4315-9247-142cb401abbf	9ba54981-2673-4418-8dca-3a856130a574	t
f34a27af-46aa-4315-9247-142cb401abbf	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
f34a27af-46aa-4315-9247-142cb401abbf	c2be3976-92c4-4463-b593-4b6384ad7243	f
f34a27af-46aa-4315-9247-142cb401abbf	c74a24bb-ee5b-427a-897c-579438cc4115	f
f34a27af-46aa-4315-9247-142cb401abbf	512ec048-be84-4a1a-bae8-c6762276641d	f
f34a27af-46aa-4315-9247-142cb401abbf	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
fc9cf51f-87d1-4020-b812-9a127e479ccd	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
fc9cf51f-87d1-4020-b812-9a127e479ccd	c7560195-2713-42c6-b0c4-fde589d61209	t
fc9cf51f-87d1-4020-b812-9a127e479ccd	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
fc9cf51f-87d1-4020-b812-9a127e479ccd	bf081ef6-7a73-42ae-9039-843cc153126e	t
fc9cf51f-87d1-4020-b812-9a127e479ccd	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
fc9cf51f-87d1-4020-b812-9a127e479ccd	9ba54981-2673-4418-8dca-3a856130a574	t
fc9cf51f-87d1-4020-b812-9a127e479ccd	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
fc9cf51f-87d1-4020-b812-9a127e479ccd	c2be3976-92c4-4463-b593-4b6384ad7243	f
fc9cf51f-87d1-4020-b812-9a127e479ccd	c74a24bb-ee5b-427a-897c-579438cc4115	f
fc9cf51f-87d1-4020-b812-9a127e479ccd	512ec048-be84-4a1a-bae8-c6762276641d	f
fc9cf51f-87d1-4020-b812-9a127e479ccd	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
84da2b2c-e7d5-4b35-9982-218c0f159e0b	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
84da2b2c-e7d5-4b35-9982-218c0f159e0b	c7560195-2713-42c6-b0c4-fde589d61209	t
84da2b2c-e7d5-4b35-9982-218c0f159e0b	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
84da2b2c-e7d5-4b35-9982-218c0f159e0b	bf081ef6-7a73-42ae-9039-843cc153126e	t
84da2b2c-e7d5-4b35-9982-218c0f159e0b	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
84da2b2c-e7d5-4b35-9982-218c0f159e0b	9ba54981-2673-4418-8dca-3a856130a574	t
84da2b2c-e7d5-4b35-9982-218c0f159e0b	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
84da2b2c-e7d5-4b35-9982-218c0f159e0b	c2be3976-92c4-4463-b593-4b6384ad7243	f
84da2b2c-e7d5-4b35-9982-218c0f159e0b	c74a24bb-ee5b-427a-897c-579438cc4115	f
84da2b2c-e7d5-4b35-9982-218c0f159e0b	512ec048-be84-4a1a-bae8-c6762276641d	f
84da2b2c-e7d5-4b35-9982-218c0f159e0b	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
\.


--
-- TOC entry 3860 (class 0 OID 18166)
-- Dependencies: 215
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	31d4e102-ed35-4180-92d4-682babba664d
512ec048-be84-4a1a-bae8-c6762276641d	b6eb6994-4cd3-494d-ab28-52e9ed7c7a0b
\.


--
-- TOC entry 3861 (class 0 OID 18169)
-- Dependencies: 216
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
e81cc2be-6625-4af0-bad6-b57feb873f89	Trusted Hosts	bf3cd271-f79f-489d-a33a-e1aeca2849af	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	anonymous
6445fde8-9928-4803-bfd9-952f50cc7b8a	Consent Required	bf3cd271-f79f-489d-a33a-e1aeca2849af	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	anonymous
f376386d-aab5-434e-9475-8e2b57c7d159	Full Scope Disabled	bf3cd271-f79f-489d-a33a-e1aeca2849af	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	anonymous
2e0c1fc6-ca98-4033-90f3-837b4d72f5ea	Max Clients Limit	bf3cd271-f79f-489d-a33a-e1aeca2849af	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	anonymous
782fe490-3f49-47fb-bc32-e1eb6618010a	Allowed Protocol Mapper Types	bf3cd271-f79f-489d-a33a-e1aeca2849af	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	anonymous
d80fc6a5-67e1-486d-b214-7f7a2956beba	Allowed Client Scopes	bf3cd271-f79f-489d-a33a-e1aeca2849af	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	anonymous
9d60a787-7dba-45f6-b1ce-de915617dbd6	Allowed Protocol Mapper Types	bf3cd271-f79f-489d-a33a-e1aeca2849af	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	authenticated
bc4f0120-92f7-4dd2-aafc-741d2fe36de0	Allowed Client Scopes	bf3cd271-f79f-489d-a33a-e1aeca2849af	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	authenticated
d6082ede-d489-477d-8356-8d3fad4b9ff3	rsa-generated	bf3cd271-f79f-489d-a33a-e1aeca2849af	rsa-generated	org.keycloak.keys.KeyProvider	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N
2ed0d12f-f431-4e77-bee7-abad37de815f	rsa-enc-generated	bf3cd271-f79f-489d-a33a-e1aeca2849af	rsa-enc-generated	org.keycloak.keys.KeyProvider	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N
b94c6df1-f2c8-43a2-b536-9856a51ccaed	hmac-generated-hs512	bf3cd271-f79f-489d-a33a-e1aeca2849af	hmac-generated	org.keycloak.keys.KeyProvider	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N
a050f117-f5fa-48a4-b65f-ee6634b27f92	aes-generated	bf3cd271-f79f-489d-a33a-e1aeca2849af	aes-generated	org.keycloak.keys.KeyProvider	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N
9554ed65-5a4b-4fad-9a33-05a5d1a68018	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N
ca548ba3-4de1-4f69-8286-ca99c61edd10	rsa-generated	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	rsa-generated	org.keycloak.keys.KeyProvider	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N
9152a578-6966-4945-b7e7-c95a8ea501a8	rsa-enc-generated	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	rsa-enc-generated	org.keycloak.keys.KeyProvider	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N
d68344c6-b32b-4efb-9820-88746a2e9f6d	hmac-generated-hs512	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	hmac-generated	org.keycloak.keys.KeyProvider	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N
738c3cf2-579e-42f1-a5b5-806f3a362098	aes-generated	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	aes-generated	org.keycloak.keys.KeyProvider	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N
908ef444-cb02-4029-a062-71d5e0ffd198	Trusted Hosts	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	anonymous
838633f4-b0b5-40d7-a0ea-9306075cb7de	Consent Required	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	anonymous
c082b0d2-d065-4698-b5e4-438739bef3f2	Full Scope Disabled	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	anonymous
6b0618ba-d798-4531-810d-b9729010c993	Max Clients Limit	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	anonymous
a72b1e84-4270-4743-b229-3fd14b42677f	Allowed Protocol Mapper Types	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	anonymous
3f338f4c-dbe9-4f97-a5dd-469ac75e5441	Allowed Client Scopes	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	anonymous
00c531ff-9e00-4994-8f46-0ee49e03c57d	Allowed Protocol Mapper Types	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	authenticated
3ae5bc33-2f08-47e6-ad00-34c89fea45d1	Allowed Client Scopes	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	authenticated
\.


--
-- TOC entry 3862 (class 0 OID 18175)
-- Dependencies: 217
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
7b315c04-9290-4f2b-8d27-6e2cf72a57be	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	saml-role-list-mapper
835ca890-49f3-418e-92b9-7ae10515b9a6	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	saml-user-property-mapper
fff8223e-3348-4a40-b304-d563e381f6a3	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
0ab6348e-56f1-4232-8ece-8d5f6a0357b1	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c3091c60-ff8e-4f2f-9651-cf3debd147b8	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	oidc-address-mapper
48182a27-8940-461d-969a-fa185d5c94bf	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
bf8f0171-8d0d-42fb-ae13-a4fd8cab7a08	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	saml-user-attribute-mapper
8e01d9b7-437b-4287-844e-2966b111ca5d	782fe490-3f49-47fb-bc32-e1eb6618010a	allowed-protocol-mapper-types	oidc-full-name-mapper
1eff17f2-c9b7-4385-aab7-981884221f94	2e0c1fc6-ca98-4033-90f3-837b4d72f5ea	max-clients	200
846a0c4d-7cd2-4c58-a8e0-996376af2170	bc4f0120-92f7-4dd2-aafc-741d2fe36de0	allow-default-scopes	true
7aeb9cf4-5509-4faf-8eb8-6daf88acb8aa	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	saml-user-property-mapper
4ce31750-fa2b-4725-8f0c-5f33cdb9543c	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	saml-role-list-mapper
bf25c9e7-3949-4d96-b02b-99d48178e8b8	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
fc46250d-7923-4a16-b2c5-61e50e079061	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	saml-user-attribute-mapper
5d4e4d0c-cd56-4cc7-8fcb-82c23ccb2607	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a15c662f-5cdc-4a53-8177-5c43a741c584	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	oidc-full-name-mapper
66a2c527-e152-43aa-88e8-e0c77b498e15	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	oidc-address-mapper
7e25937c-6a1b-4d33-b194-576ba63cdac6	9d60a787-7dba-45f6-b1ce-de915617dbd6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
78768719-d4aa-45db-b530-03edec5f625e	d80fc6a5-67e1-486d-b214-7f7a2956beba	allow-default-scopes	true
da2499c3-85e2-41af-b944-58eb09577991	e81cc2be-6625-4af0-bad6-b57feb873f89	client-uris-must-match	true
fefde45c-e1a3-494c-a46d-940c8a38007e	e81cc2be-6625-4af0-bad6-b57feb873f89	host-sending-registration-request-must-match	true
bd47845c-b913-4c5e-95b6-5b023b0950fe	b94c6df1-f2c8-43a2-b536-9856a51ccaed	kid	79275994-d325-459d-87e5-1fa21f212713
af7d536b-9fe4-434f-a6f3-f8503aa88c46	b94c6df1-f2c8-43a2-b536-9856a51ccaed	priority	100
be03f18d-c24f-4988-9c9f-c501d4759a07	b94c6df1-f2c8-43a2-b536-9856a51ccaed	algorithm	HS512
ef3e50a9-8836-4418-bbbb-07af944b35e6	b94c6df1-f2c8-43a2-b536-9856a51ccaed	secret	zpw9VmMusn4Pz9Y8BYS1GdZcuc7-i59wLFtuNGVe2WATLksiyoieP7AEynvy3HwadjSvdQm6VJHWhn5Q8-OfcgIGNd6NtoYEvDBUTWOcfMjUYXRkLLJJkq-xYYuxdiX4Dxh_O_WM5LuwptBCYHYqFU9KQTowY7t0r-DcF3BSolE
0fd41e1d-b766-4ed5-a98a-25f528d34a5d	a050f117-f5fa-48a4-b65f-ee6634b27f92	priority	100
de114663-e646-4166-9759-10ef3057fcf6	a050f117-f5fa-48a4-b65f-ee6634b27f92	kid	228eb3b0-8e00-4f88-974c-b0a362918245
c535fde3-8fad-44f4-81b3-5efea644d547	a050f117-f5fa-48a4-b65f-ee6634b27f92	secret	SKgTDxbWNw-n5lGeeDyN0w
ff958f90-84ad-4160-a44b-9aad17a61dfc	2ed0d12f-f431-4e77-bee7-abad37de815f	keyUse	ENC
3521cc76-008c-4df4-9ca8-50ba34f328c4	2ed0d12f-f431-4e77-bee7-abad37de815f	priority	100
0f897a3f-dfd3-48e2-b956-88c0612a3152	2ed0d12f-f431-4e77-bee7-abad37de815f	algorithm	RSA-OAEP
fa2f33c8-34e1-4164-8777-984d3baea989	2ed0d12f-f431-4e77-bee7-abad37de815f	privateKey	MIIEowIBAAKCAQEAxPD2TYL1eA/QJ2l/sjrnwHKjW79dpQ/0i8pW3ovuGwLWNqXXUszDUI1KhJzXVNTkvya3B2+D6pyv0tqJukBBtSHSk1T03/gaQKI7GuLAmrUIpZiyRCWY9ZXN+Dg2gjdpPmnZ8Lm2CJbnSRAytf4MiOBo7khh/V9xfjh6GuYTDwaGJ7zj7f1pBApQ4p5oZRSV7swnSFO5OylZ0k7qlPEppfJXO2hu+TNsgF3swg2iCQvmMLxNcuSFVIshqx77HT1E7ufp0NbxTX8Gj/xFeQFdoFPWTIzWjkB6GUxBem+OI6IGyFaRbRko4F2OSHWpboSGmlfnDlrgkZwrceTt3WbDpQIDAQABAoIBABoX360LE2aPbcxdrCzF+jZjhKUKI1L/MgRNeu9XNI/WneGKso9GuwAStaisC9RdCrEQOkLdcb8leHQ5k/LzQuFytEQ6BuHKglaa8rV6t/sneO2misQAWUD8qAK3Fp3FJV1pcpX0UnEr5plQcJpFU+LUx4JUC8uhbYJEOFq/rg8Y2ff+/4XMC74PuU0vI7YHVLb5cnCpfhx1M++mAa/TgujF84dMyxdkw8ZTqlBbg1TvuWYlsbsudd5SPNKMWbIw9rneCAeJSwyzltJ5o7kqBvs2B4v7krAFewh+fE3fhxODFiRAHpuR7ikNgdmwGt2SCLJEfHI9cR23n7SpEYnTeRcCgYEA9Lua+He4dcQra4ReEsZpUtibocCg33jUgPGPGQs8ByXcQxKu5Z8za/E0XMZDKTKJpwBp+vR4NFv6MOwydmuzCbr5a3zrGFIqzQVnpYp9YW9nE4VtVry1RlahKokXrhS6KgvkRVfNM2h5gZUaLmZ/4wAlAkRaFLq6tGPJFPPMoqcCgYEAzgIXJzvPC1VZfM/RqS65LOqyxaurR8Tbj1u4xu8iu7nzDf6p47gfJnTAu94J274o3b0bVhvtRAAQ+Rh57taojmgvtiBEv7/8n0r0M1qjuTXGPU+aYazLQsICY0lX2OSRtxtSn2PHDjggG6R0kYfvYl+lfDfpYHSCwV3lBiL4LNMCgYAPRe4D96TBZL649QfR8CP+kZoU3CquB6JrcafWjkbuw0Qdw3q6xda1s9XqvEzQs2C31WTHzp351oukpfj4PvxrbQnH1YHugKI/LUksoZn1jLhIFZmfQiOmAh4Iw4mAybZcjWVvlm0t+iUrGx0JLEhq6EVnANEGXijsvRV9g0GQHQKBgQCjFDSP8mCscBwvGbS3YS1lyUVMBeHJJqVIjytvD89HHKSz521Fv3OpVbNdBSB4u8hOAG2rdOAWfJbzGdUspPE6Cm/6lQDXanvo/cTjAlWpQFB2KJXlzIv7hOmu/1hzcj2H3jFBzBK/xt5kA4Pj0OBH17+A3iH5IUKBIHs0qGod0QKBgBeKeRA22JvtQIbiqNi8WqcvHKztg2AH43FOGWte8sxSlB1Bu6yWrVPxCGdftTbTV9pgoUhE8yt0DBwZzVmp2Qq137I+EIadZwQ1/ubUjeJJWN/vu5VS5cxm1+G21CFn/XOKuoNTa5/G2+RvUpby7vSDJNrYM4VcmhTKRFJ/nYiT
b4338d11-f94d-4998-80e4-5274be0518b9	2ed0d12f-f431-4e77-bee7-abad37de815f	certificate	MIICmzCCAYMCBgGUBdpEYjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMjI3MDIwMTE4WhcNMzQxMjI3MDIwMjU4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE8PZNgvV4D9AnaX+yOufAcqNbv12lD/SLylbei+4bAtY2pddSzMNQjUqEnNdU1OS/JrcHb4PqnK/S2om6QEG1IdKTVPTf+BpAojsa4sCatQilmLJEJZj1lc34ODaCN2k+adnwubYIludJEDK1/gyI4GjuSGH9X3F+OHoa5hMPBoYnvOPt/WkEClDinmhlFJXuzCdIU7k7KVnSTuqU8Sml8lc7aG75M2yAXezCDaIJC+YwvE1y5IVUiyGrHvsdPUTu5+nQ1vFNfwaP/EV5AV2gU9ZMjNaOQHoZTEF6b44jogbIVpFtGSjgXY5IdaluhIaaV+cOWuCRnCtx5O3dZsOlAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFe+c49QuuuxvMiHyMopxDLJmBWsaePihffen8ygyDn7lZC9SFdkCVB4fgyVwWcP7I/aLz1rDqkMvHwuyEu8PsapgvG+bKysVFdUCLfVm+AE9Klssckl9fm+rp2gjUdpjDzgVdguUQjOEksC7NfD3+8kIyTjqwzlUxqPlBpIQF1Myrsdv1nqB3wb+g/LjUAGBoRIDnq4EMSchP5xHKqQdR8pgS9i5AUA0RT5mqu1nwMBLzWCxxuJKC6SYFRAOxUDVpwBK2bJuJn0P2nU7WGLmEF9jWS+VlzKy06+IWNNQHXGqb0/kpYQqlYjxp5z9RuHXXgGMDelWVvua7T4rIokwy4=
0becb78a-3915-4b25-b2cb-486df021d803	9554ed65-5a4b-4fad-9a33-05a5d1a68018	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
7c2be44c-44e1-4fce-a8fb-19d596e102ed	d6082ede-d489-477d-8356-8d3fad4b9ff3	privateKey	MIIEogIBAAKCAQEAsieFeTtmjs3d8WgYjXEanSusQSDw3+L9FYs3z6MVxzs4tj68P4b26rAyIksiR6NUsZ2aBLDOcFv3MgbkCO23mwr1JkVg9sLcWwhUupZlBdKPF5mJF7Cb7OqGaAoHwYLf3II623j+BYE9eXgZocASGZyV6CmctZubKQC92Fcqi63FLLmsmqPjLbMECILjktYbllt1XRypI8MVpz/TuOW2K8hynYU+Kkh+1s3qpDV1GH2OAI7GzKbuT+9F7nAUKjg6FC7K+Ypy/Bvow/u1ydnuynH8wjD9CV9tk8HZKUFoIP3wj/S/Uyoia/5nOF0D4aDwdG5BkmBGufcPZrSpdr9xUQIDAQABAoIBABFC/w3GEaPYkp6nZWmfAeMkriYJWQ14YulJefjmZl/Nfys5XOgS3a3TsKfd+85RJw2mpZu6veXpI0R3onSzA81D/IjexAxkyREQ95S0qckso6y3ta7T7+e+uZMvFZ1MXwBwpd9KE+LYqOoyFtmzUI2mvGeoUITQNPJ+HebuWzL5U83L/6VmAXpdn9bBjPZuWm+xNF637A5iW8rBCdHJoMk+3QaS9ZfDfLrPTS9Z387T2WHlLv87w+bTbMfxafkhEl64dodKDm8huHkOQejCbiP4bPGel75xuLqWApE6JJnYTwSCcX+LdCrc/gb368qgTq5UNxLnKpblzmULXlyy6nkCgYEA6Lx+zIstKe8awsi4swx1+skNrl66rKg1EZzgGrXdofn9IDnyzKJnIJinlyVxwtpxTw/g7fmb+9oJo1Qbj4FFTKlEVjmjd+/yU/wbpfi7EsMvsSDBGOfRBFUJuEn5F/bF9hieyQXkf8HTN5Nxy6xjyocMTTyGfQ3rRJ72cnFeGScCgYEAw/ZTVBx1jziqENsbjnWhznobtCEfWs6q38r3H2DoNPnFQ36+s9ws+qcg7JXIKjD/5qkjNUpDgOjnBY+t3Ap4EU5rfoQNITfbjB8/pmR/lEBnG0A3UIlZOoxBZQkFJ8USc2DH+PaOdLFg7iye/l/Oto08UwfKkbZZyi55n28dfMcCgYAQFzAhDiJCOvC7tMroPh1OCGZ0vsHjPAHnRNRNpHM9Rp5Ugw0hTr0YiNVVYtZZpWaeE7f2XAKHyAxQiXkaU9KpuS4rU/LUUPeNDOoQcIDmjC4Y7e3LvgM6bHKulhatrHcFS7B2r3ybxJfIyN3eOf3wO6QDFwMpVDQG24KoaOQbkwKBgBx0K+1OpJNDOw5vgjTRR8lfWZ5yIMdistUD95YK0CzBB6+hO7eKBM3wbotrxEC8FKw9autV+S9Coijgj/IfYwfAR0N7kRx9q9dQwkE63nt8Tnxaeq2rA9XIf8ZX5PO9Xcx7BQ5VXqH7D4QF3qA48R74qwWzX+qAe9ErpmVMERAJAoGAYBDpbySElBEEUJzfVeCry5c0g8/Yf0z4H0JdCPPC57PBX5aPV3mMiOSmzIe/qSzRmTj6ESOy07wBtPjZRIvHILwjAkmYat/vEXyoWv7ZaHhXUTmN5xo5KzHaW2vgXh1/g6UXDzCCRGYDPb7wfAb4LK9toLZiF+9zb6o6vhzmjc0=
a777382f-0d05-46bf-92c0-22c2d9784e5b	d6082ede-d489-477d-8356-8d3fad4b9ff3	keyUse	SIG
4dd1e7df-c671-49f8-8c99-3e551f7ddc3e	d6082ede-d489-477d-8356-8d3fad4b9ff3	certificate	MIICmzCCAYMCBgGUBdpDyTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMjI3MDIwMTE3WhcNMzQxMjI3MDIwMjU3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyJ4V5O2aOzd3xaBiNcRqdK6xBIPDf4v0VizfPoxXHOzi2Prw/hvbqsDIiSyJHo1SxnZoEsM5wW/cyBuQI7bebCvUmRWD2wtxbCFS6lmUF0o8XmYkXsJvs6oZoCgfBgt/cgjrbeP4FgT15eBmhwBIZnJXoKZy1m5spAL3YVyqLrcUsuayao+MtswQIguOS1huWW3VdHKkjwxWnP9O45bYryHKdhT4qSH7WzeqkNXUYfY4AjsbMpu5P70XucBQqODoULsr5inL8G+jD+7XJ2e7KcfzCMP0JX22TwdkpQWgg/fCP9L9TKiJr/mc4XQPhoPB0bkGSYEa59w9mtKl2v3FRAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF0XiFmGheJqE/NpxtXs023UgY67d+A95RL/K7Se0M6aq13dIX2Iv5cWKnugWvb7Smw41qML0z9o9aafIOgmZLccQCPTzBZEuLb0FKqAotEzKoEcvqBfh0SM6Bhhv3GCJi7D3EB8hFkOj654Bbjb8u/EcV+cnQ6qrrrdsAWAC5FnIh/JtKpOYGTDEbu4Eim5P01gXudTdXuqhC3fqZ9If/qRL97Ami/hDEnxaku9A8Je+5HQE0iK7L7NI1Z8hioSuKEd6ohQMPshhK44weqy5QiaG2hU3WRstG/qrAhmB09gBv+7BSE44WEBKCkOro/gEVKrmFwumZgadsfHbQr1GGo=
a1b06504-1d03-45bf-91ba-4dd691ff6e96	d6082ede-d489-477d-8356-8d3fad4b9ff3	priority	100
d845781e-294f-4ab8-a670-6536e7377756	9152a578-6966-4945-b7e7-c95a8ea501a8	priority	100
64a4f4ab-6224-4e75-aaa5-10f42d6909c0	9152a578-6966-4945-b7e7-c95a8ea501a8	keyUse	ENC
a9d281f3-1654-4b3a-b05f-23a42b54ffd3	9152a578-6966-4945-b7e7-c95a8ea501a8	certificate	MIICtTCCAZ0CBgGUBeJD4jANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNwcm9wb3NhbC1tYW5hZ2VtZW50MB4XDTI0MTIyNzAyMTAwMloXDTM0MTIyNzAyMTE0MlowHjEcMBoGA1UEAwwTcHJvcG9zYWwtbWFuYWdlbWVudDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKKbMyZZOEB4f41z1nVC5RulSSZNnWfyrjPhAhq1EJBKDHqCx3iaNWHPpHi4SkLQHCTWAMAWud4jfa021tJM7dyJRMsiYgJlrIn1q7v4IJo9GP7MzsTo7mou2FwUg1gl6fDMXP+S7oZ+QW/9/uBP7gKNsPa+LpDVVKu74/YItwFHZDLX5p7S3lmCk2RpuTWlBiLqJNbp5VX0SdSzI8A1u2OSaBV3XRqS3Lcu162b7V2PFd9MDu/ClKgvl9YLyslzYT8/fYUtD8SIlmDA4tvN/rL+BUZqdgTITa4FxgRnZ6/TghFknssBUF1oDm5fT6O+z5QeklK/pcTEpyvdHTdyF9cCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAoUFYKiGAufNr08CpTML2cbQuvgdST9CPytgKSkyvi6ted9UZmdnCSakibDqNoppt3O+HGomWFWdMuzkEzbB1kvjmkwaA5sNiQJh2CtheDpUnszH8lXE4ixFCdOxGfXdXng1oOC2WXxnqz5Xh1KbTR5e1PTv3R6GSRxOFI+rJd890r8C+NLzi7lzZodiE43RAOfV3jTsAYELPOAch3l+S75d/CK8BdoZOLyPlM3MeGRQoCDvESZD6EVziF7YOYmXM9/wCgM09dkfWiZGyhbnZx+eaB2yAMGKFeRhlnHdavVyAfqQzqlX73IdMguA1GNC8U+945YQ/jFrhHFW57Dih/A==
04006b15-da5b-4186-b834-e2932a386acd	9152a578-6966-4945-b7e7-c95a8ea501a8	algorithm	RSA-OAEP
fd335912-cd30-416b-82c5-d10d3183d602	9152a578-6966-4945-b7e7-c95a8ea501a8	privateKey	MIIEowIBAAKCAQEAopszJlk4QHh/jXPWdULlG6VJJk2dZ/KuM+ECGrUQkEoMeoLHeJo1Yc+keLhKQtAcJNYAwBa53iN9rTbW0kzt3IlEyyJiAmWsifWru/ggmj0Y/szOxOjuai7YXBSDWCXp8Mxc/5Luhn5Bb/3+4E/uAo2w9r4ukNVUq7vj9gi3AUdkMtfmntLeWYKTZGm5NaUGIuok1unlVfRJ1LMjwDW7Y5JoFXddGpLcty7XrZvtXY8V30wO78KUqC+X1gvKyXNhPz99hS0PxIiWYMDi283+sv4FRmp2BMhNrgXGBGdnr9OCEWSeywFQXWgObl9Po77PlB6SUr+lxMSnK90dN3IX1wIDAQABAoIBADGB4klnOa67YU5+ecma8+l+Ye6lC+s1op9N/xeFkET2HqWAQt4vyVf94dwVdBqyhRccBv91C+Mb2CxQOYiu/m66ZnUYg1GqhiU85KwmyDpdpsoRLlUafFhc6efjIPhKFteHSTtRD4loUGEaKqs9+r/RRxNg5QmYwh5FZwsmLR3Yk+ZwMOCKIzPH8PfrGZHDMLYIN6jO6Uw0aGyy59iRp00mA8SD2jmir9lUgobUeDga3Hf7bvVIPN5iuRtXR3TzGhSzpwQoVJGWvrDIz98UbhOxrAjZe4G7qqO0rzzX0KwzVXCm6wBuDnN4Gu8sZfPzheS8yEb/QEt5ElPpQunDpa0CgYEAzJzjKnSBYeiFSE3VdSi7sYA9oWRVrisS3ld+gdPtnQoZTf6TPDnW9f5jv+T2LlUk/QOLOeiy7mnOHt7SefMyej27rJxqC25D9dYRrTEI8gnm/fXskNxx3dUJ9/pEW+90VwRB4gc5jVaX042qEZP2wQq9cb7MyPBG4DLWN6GAGxsCgYEAy3GYV+dVZWZozdhfc7Vm+tl1SprMsOiD/3D5euHTTfuX19/RSolWnCXzinCJ5Fw8sqOFeCMIuCcMbHZUmdrfG0o84It4vf34Gz7v46QU3kQpMVNOxeUZx3OIs+emTsSSzM22l78J+MBObOkYK+9eAeVarHU9eIK/bhaCPRdb5fUCgYABrgAHZzFwtlHxyAHKlm0EBgN7gbFaXqwm+xzkv/KhaWXPyBk5U1g6aL404xJKSxSkpxTLgueFIYU5p6aerapqantR7W7JbTxNllZKz649HmuxBgXNIqIkqg0M5hcNkieoVzabPmfwixdv+ye8QTSzXP01I9XWiHJsgL5VcpP0pQKBgF47m6j7yh5RtTHDi1L5L135485OrYkz6hAjsCsu9sUkSE0BqtuviaKCIbB6OCTCZIsKGwRulddWnvaOSNmK+9SUKmaHs8GtJYLZQBxdIB1jzQC/6bjYSXyNE0Dhh7LscmLS1kSrhF7oFGt1/HA9S3ntVnaTR4nOZgUEAAd0DmkRAoGBALGb9TfGXwVl8yNHf+PO1vbI1MCVoPhdVygicDJfC59TSanAE1QACC8VS0NAp5FAMG1Hl33GLoWyzLBDsedtT4eMMX/f9anUyrFcue478UnlL72nepcUeaGE2O13G/ThM6mBeQmHPRO70aJpbyHpMGUIKErgk89iXyMJmD3n7W8t
ccac76ae-fdb1-4b9f-8441-9a03546e18f2	ca548ba3-4de1-4f69-8286-ca99c61edd10	keyUse	SIG
4eaa0865-77e2-4ae1-b392-bc7c1500dbd6	ca548ba3-4de1-4f69-8286-ca99c61edd10	privateKey	MIIEpQIBAAKCAQEAo6rPrOa1CrzLJb40qNFvOssb/3c/WSHb/Hyy++no7SXp2/LwWRORKALxHaoBD/lnF9yHWpyt2abtflMDNRfWZG3fw44kJpkJsLZIBKfaOCNWCFHwONtLEUs/O386pQPshqYwsKJSeo/h86gii2rgUeazAUvFPZ7R1EhfaAbWoiYeFf8DSIM8XqlvrjroQY1yUPhGJrQ742OfxTmF1XaD51wWKKi/JjtT/OSLr+j3D7P6wOSDCnTNFofUe3bCJNFuGDM1UaXzlVfnSvVWtf73aA6l+ixiUSU6inF5JZozYxyHVdXvusb1f21/rgf60zxYTXEiTaCxl+qCdVay0jgsvQIDAQABAoIBADMUPKNMD2WN/WLGpX2oe2vgdtj4ePtS32rB6kRHwMu+gOmFvPA39J4FqQWmiJVZM40VZOLpMjLS75z0wHQCAAWw6tyH0I2BRq5xfTGCx06s7I1FMVE1U4zOrKnfb8iPXHK7jEecKVyZ6h1WtI1Jaj/1XZmCccjk97ymZ6w6MiNBfLtku5XAZjHrDCMexzalrhBFe5ECJfftaRDN9dWyglok8SEbGuRSDUfNEVA7+U8sIYkXunyXaB1FkYbK1kXpdopBO4DZB8S30gWuS2QjeO9XJ0Tx82ItCO/rXHypd6kZmzhkZm/SfLob5avd3QHE5aMxF4LRfAMvsibDTpSVumsCgYEA40q3sMmlo2IOLt74NjToJKDiuthxAQvW+MlBq2rrfJIeddkaYGUe1uqR0sOgparGrxhnUIVaGrVM90gZp2G4FTYhB+JjZ7kkv9llNgECo833CPwqSWCyM3Ye0cU/zAW2cZAtjGBvzvI7olH5PIE/3fPA/Tn+HdUUhTXKPhcANl8CgYEAuFbY3fnrNaqw8WrTTBS1HXN2HWnjsat4Ccc0sVLTrAm1Q92UqnJsM/Qsa96XqfAwatOyqmCVVyWjVtqBtRPRuunYrlzpKRRIpctprVb8BneKSQat3ZX7uMwjYzgaBDRWB222EghKnXERwDmQAYsHrlw7dCyGCT+bc/o1nt5SmmMCgYEAyJ1pVsQUzAm/RQWOhaHbCIFsvchOrcK6gqp4qQldQn1iH1h5nH2EY+N0xFfhEniSl3dtsTeSmSJPBbAA3Kk2ppo5O1FJtgJHeoIygCESKGyhz69qz4tmnl9ywmpcbgLYzpGYcl+oMDvEAPhjiVD3gzsjqx6lucUaMJ2SnY0FpfcCgYEApW0ir4nBX+bvZadlOah3pJdiTyEguefUEIpZqixXUtNffSjTambG3ZTpbGBUoKew+51BgA6u1ocrXx02O4cuttt2nXs5rqjKTScPjgQ6pZ8PVVuOGgWn4X4o37iP+GfzMDVvqB0SwNmggW3m4sueuAWDQU1Xd+NCIUFQb2K6pFsCgYEAjaBg/AK9L0CSZ/FeJBw/GXTCgnU3HPvf6FiM6OhCfrpLUYJfd6GRJ8zGbJPOVJvc3msHWuVTUE9Xbvr8bJgK9Gkd/jhcMYrw66myJbjsc2VZsLdE1XCxQygpzc/PUjtHj0UwtWGH7Dno6RQQkOdgOOB+4MsA+xPyiXjyz7mFXdM=
41ed1584-5ce5-4aa4-937b-815c73206907	ca548ba3-4de1-4f69-8286-ca99c61edd10	certificate	MIICtTCCAZ0CBgGUBeJDtDANBgkqhkiG9w0BAQsFADAeMRwwGgYDVQQDDBNwcm9wb3NhbC1tYW5hZ2VtZW50MB4XDTI0MTIyNzAyMTAwMloXDTM0MTIyNzAyMTE0MlowHjEcMBoGA1UEAwwTcHJvcG9zYWwtbWFuYWdlbWVudDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKOqz6zmtQq8yyW+NKjRbzrLG/93P1kh2/x8svvp6O0l6dvy8FkTkSgC8R2qAQ/5Zxfch1qcrdmm7X5TAzUX1mRt38OOJCaZCbC2SASn2jgjVghR8DjbSxFLPzt/OqUD7IamMLCiUnqP4fOoIotq4FHmswFLxT2e0dRIX2gG1qImHhX/A0iDPF6pb6466EGNclD4Ria0O+Njn8U5hdV2g+dcFiiovyY7U/zki6/o9w+z+sDkgwp0zRaH1Ht2wiTRbhgzNVGl85VX50r1VrX+92gOpfosYlElOopxeSWaM2Mch1XV77rG9X9tf64H+tM8WE1xIk2gsZfqgnVWstI4LL0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAL4nCFBbWzvl1THGgxxEEAvuMPVuzDyqP8UbqwlVPBt9a5XmUABRC3U0ifq/bYwh9CfCYKQWHB5OsqXBXn84buZGUtBtA7MoqXMrITHiMwmLpEMzU/WAMKB1Bq9z7dxOFldCNddzur1MgUQPmuvFEU53ALut4d6R2ZzpPUjIorRxFOtFbpriCQl9+FmPNE5asSrvqO82LOdTQ96ngMWtc4mr8QBsOWpmrlToUNipSo3HFvA7ZEuBGjSwtLVXFafgYvC3uvNBp2RfeYEmLRnCOJYYuilgC1zCEM7rAKnODPsxLiwqALCvbf/8z7I7qnrmisNeDAZK77QnO+FRfAdx2ug==
647e9260-f7d7-4da4-ac3b-42596c86f051	ca548ba3-4de1-4f69-8286-ca99c61edd10	priority	100
af869f98-27c7-4794-a5b8-84e41d983a88	738c3cf2-579e-42f1-a5b5-806f3a362098	kid	b51b237a-5a70-4d32-9f93-1d2bbb693285
639e4d18-ff14-4b3f-9168-c8aad868bcb8	738c3cf2-579e-42f1-a5b5-806f3a362098	priority	100
6bf43a54-1f12-44c2-af44-c399469218e9	738c3cf2-579e-42f1-a5b5-806f3a362098	secret	B5ZrT4KCDX5tnqlYHj-gJA
b3181f77-1a78-477e-9040-dcb59d1673c2	d68344c6-b32b-4efb-9820-88746a2e9f6d	algorithm	HS512
11497e12-c889-4bf2-a92e-9d74aedf181b	d68344c6-b32b-4efb-9820-88746a2e9f6d	kid	3d3ca881-d968-4c77-84b9-1eadc2bdfb74
8fa0a769-7305-4d8d-9a21-3de9546798ea	d68344c6-b32b-4efb-9820-88746a2e9f6d	secret	jsi_TNLEdoZncSAX7Xsme3uMj8Wo4ZB7LOQsCEDnrs21TjjK1lbRn7EB7Exp4bidaOkNEHLbFE2AbDxwjYtvNP6wuXXNfPd0WQw0VtQJ39kbV_glXpgCJVjQ84YM6l5trKnh6RrqS_Fw4OgjWBtT1H8Ve5-smXG7s6KDmcQKwlg
87e33de1-ca2b-4afb-a2d2-f009cd3894ca	d68344c6-b32b-4efb-9820-88746a2e9f6d	priority	100
75e7a246-99d3-4689-8210-3e8fd150669a	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	saml-user-property-mapper
28e9973e-7394-4d58-8db8-39f082b366b8	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	oidc-full-name-mapper
a8ef78b7-074e-452c-9e0f-faa78ecb8bc0	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	saml-user-attribute-mapper
36169e57-0469-4037-b42f-c435683e8450	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0f3e9815-4884-404c-b181-0b07af148d3d	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	oidc-address-mapper
cc95bead-3506-49ad-a616-3ac31b1a218b	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9f552fa6-1ace-40ad-9a9f-11f415c084df	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1076e665-bd74-409b-8dc6-c9f9530b8e89	a72b1e84-4270-4743-b229-3fd14b42677f	allowed-protocol-mapper-types	saml-role-list-mapper
391963f5-67e4-4aeb-aee9-a317107890da	3ae5bc33-2f08-47e6-ad00-34c89fea45d1	allow-default-scopes	true
76e3a4c6-644d-470d-b606-2c30ad2c1adb	3f338f4c-dbe9-4f97-a5dd-469ac75e5441	allow-default-scopes	true
eec0edec-67f7-4aa4-9f59-79a95ca54d65	908ef444-cb02-4029-a062-71d5e0ffd198	host-sending-registration-request-must-match	true
62775868-5756-4fc0-80d1-5cd71325cc6c	908ef444-cb02-4029-a062-71d5e0ffd198	client-uris-must-match	true
07a4b32c-da12-4d67-8f98-a75334d20529	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
0467430f-6d89-476f-90e1-0a21a2e703ab	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	oidc-full-name-mapper
7a9ca793-3bd2-4ed0-8e67-617ffff3ff80	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	saml-user-attribute-mapper
23c1018d-d40f-45df-9e22-8b206037ca3c	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f8ae0959-3341-4106-ae7a-59d19eb6f3ed	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	saml-role-list-mapper
15b89981-ebda-4c34-b0f2-d561f88c19c9	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	saml-user-property-mapper
8812124b-b326-4e85-b6d1-ceeb15d22240	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ed3db86c-efe3-4e2b-b0d9-f70a3179a9cb	00c531ff-9e00-4994-8f46-0ee49e03c57d	allowed-protocol-mapper-types	oidc-address-mapper
f38073b7-ac37-405c-9aee-1320b2f9f54e	6b0618ba-d798-4531-810d-b9729010c993	max-clients	200
\.


--
-- TOC entry 3863 (class 0 OID 18181)
-- Dependencies: 218
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
b4debcf6-d58c-46fb-9b9c-a09722443bc3	8f20434b-197c-4474-a7cc-675f9a90e1e7
b4debcf6-d58c-46fb-9b9c-a09722443bc3	0801606b-fa8b-4c60-a592-3d4049b25289
b4debcf6-d58c-46fb-9b9c-a09722443bc3	35876926-2148-47a7-aa00-de6835e49f42
b4debcf6-d58c-46fb-9b9c-a09722443bc3	46ecacbd-a374-44ba-9ab1-c2738a4f220a
b4debcf6-d58c-46fb-9b9c-a09722443bc3	6a5b9e6a-4348-4cf6-ae90-d782c92f69c5
b4debcf6-d58c-46fb-9b9c-a09722443bc3	f1c183da-9d37-4466-a414-05f716d3a3d9
b4debcf6-d58c-46fb-9b9c-a09722443bc3	d89973ec-b812-440f-a5da-0459306362e3
b4debcf6-d58c-46fb-9b9c-a09722443bc3	95d6c8d3-018a-4685-8c1c-663729ae0f9b
b4debcf6-d58c-46fb-9b9c-a09722443bc3	f4ae45fe-88b9-458a-9cc0-36c5322dfd84
b4debcf6-d58c-46fb-9b9c-a09722443bc3	a013aade-e67a-408a-9f9c-a8294825fe84
b4debcf6-d58c-46fb-9b9c-a09722443bc3	5aea1f1b-39f1-4f8e-b4a1-48c63d33918a
b4debcf6-d58c-46fb-9b9c-a09722443bc3	4b57de25-e7f7-49c7-9527-10da5f4499bf
b4debcf6-d58c-46fb-9b9c-a09722443bc3	046b55f9-fe33-42e1-85b0-879dd39fe18a
b4debcf6-d58c-46fb-9b9c-a09722443bc3	9c867d0d-aa90-4db0-8ba1-3853f0c598be
b4debcf6-d58c-46fb-9b9c-a09722443bc3	f9c8fbfa-667d-4dc6-b194-8a2a3d5a489e
b4debcf6-d58c-46fb-9b9c-a09722443bc3	7258fd24-345f-498c-a875-01968be66e88
b4debcf6-d58c-46fb-9b9c-a09722443bc3	256618aa-b0f1-4ad6-9b59-e1cf37c3ad42
b4debcf6-d58c-46fb-9b9c-a09722443bc3	922c497b-7663-445a-b42b-661b278f57c9
082b3aa4-4a07-4c14-8002-168ef58ad8ca	484347c7-68f3-4a99-938a-a5d248e50902
46ecacbd-a374-44ba-9ab1-c2738a4f220a	922c497b-7663-445a-b42b-661b278f57c9
46ecacbd-a374-44ba-9ab1-c2738a4f220a	f9c8fbfa-667d-4dc6-b194-8a2a3d5a489e
6a5b9e6a-4348-4cf6-ae90-d782c92f69c5	7258fd24-345f-498c-a875-01968be66e88
082b3aa4-4a07-4c14-8002-168ef58ad8ca	18a467e5-7c41-4c4f-9033-0cd02f04eece
18a467e5-7c41-4c4f-9033-0cd02f04eece	7ecbd9b6-87b9-49eb-bedf-4d293bb144b6
7760c1a3-f1e1-4d72-87ae-fe1d60ea63be	edfb1c96-9fa4-440f-ab0e-0fc2fedd3cea
b4debcf6-d58c-46fb-9b9c-a09722443bc3	975e696e-1588-48e4-bfd3-34aef5e50574
082b3aa4-4a07-4c14-8002-168ef58ad8ca	31d4e102-ed35-4180-92d4-682babba664d
082b3aa4-4a07-4c14-8002-168ef58ad8ca	b4002fef-4a8b-4fdc-8e7a-cf65ce10a651
b4debcf6-d58c-46fb-9b9c-a09722443bc3	4c978834-6e30-4e8c-9803-fc6cb57df0a0
b4debcf6-d58c-46fb-9b9c-a09722443bc3	b6fbd37a-adf6-4559-9afb-afff986cc7f8
b4debcf6-d58c-46fb-9b9c-a09722443bc3	6b475cdb-5c10-4b07-9df4-8d2d83aaf1e0
b4debcf6-d58c-46fb-9b9c-a09722443bc3	81dcd1a8-5eb3-41f7-8e80-6f35dcf8e474
b4debcf6-d58c-46fb-9b9c-a09722443bc3	46d89910-33cd-4509-ab91-07f42bb9cb88
b4debcf6-d58c-46fb-9b9c-a09722443bc3	d86d0366-283f-4056-8233-7c1d4573be84
b4debcf6-d58c-46fb-9b9c-a09722443bc3	a8622636-7ff9-4e44-8723-8ad76a26f7b4
b4debcf6-d58c-46fb-9b9c-a09722443bc3	66d47bad-a87b-496d-8238-2dd15c1c7dad
b4debcf6-d58c-46fb-9b9c-a09722443bc3	15438547-66d4-4ca4-9a5b-e444a0ee0a2a
b4debcf6-d58c-46fb-9b9c-a09722443bc3	d5cb008a-9b4a-4cdd-8f1c-2a23d24b678d
b4debcf6-d58c-46fb-9b9c-a09722443bc3	d67cb152-68db-4839-b9d0-7d8e628079a8
b4debcf6-d58c-46fb-9b9c-a09722443bc3	9bd69e09-b995-4400-a5cc-8318dd41feb6
b4debcf6-d58c-46fb-9b9c-a09722443bc3	dd88bd11-ba80-461d-9ce7-15d22878870a
b4debcf6-d58c-46fb-9b9c-a09722443bc3	17ad7bed-5747-47b9-8b21-18614a4c8b6b
b4debcf6-d58c-46fb-9b9c-a09722443bc3	dc08043e-e9db-4252-a511-2d92400f20dc
b4debcf6-d58c-46fb-9b9c-a09722443bc3	0d00bfd5-e930-426b-a802-a44f0f7bd147
b4debcf6-d58c-46fb-9b9c-a09722443bc3	0c48ee54-5c87-40f9-8077-1cfc9c2d695c
6b475cdb-5c10-4b07-9df4-8d2d83aaf1e0	0c48ee54-5c87-40f9-8077-1cfc9c2d695c
6b475cdb-5c10-4b07-9df4-8d2d83aaf1e0	17ad7bed-5747-47b9-8b21-18614a4c8b6b
81dcd1a8-5eb3-41f7-8e80-6f35dcf8e474	dc08043e-e9db-4252-a511-2d92400f20dc
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	cabdc449-d9c5-44d9-9f04-5c17924abaf2
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	1bff0f9e-f591-4d3e-83b6-d95101033e75
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	84642d3e-1540-4a4f-b4a1-eb0b8340a969
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	50863b87-5590-44bb-a9d4-4756f20b3332
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	623f1480-8572-46f7-912c-5c34255d1199
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	e27a6ae3-0648-4e7d-ba21-2a730482d75e
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	42ca6f50-a1f5-4626-b80d-4149da2d4712
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	0255271e-59df-4895-9cd3-2923b5f1cc13
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	e2529853-592b-46c8-9398-0b5c1ae0ec02
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	a55ebe33-19cb-4c20-8fb0-3384409c0ac4
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	1d8bc5dd-e262-46d8-85f8-fba373fcb9ed
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	ca8966b3-176a-4e42-8b6a-4949506bbf95
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	b6a6c6db-547f-49e9-ae1b-f3649f59ae75
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	9ef80488-4450-4c37-bc28-65bb5db464ed
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	404fa9a2-3db8-4906-a97d-4c6daaa37e6b
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	9f044762-a929-4a28-a427-3e876aace143
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	7476b86b-8faf-45a0-b4b5-2d88b37fc03d
50863b87-5590-44bb-a9d4-4756f20b3332	404fa9a2-3db8-4906-a97d-4c6daaa37e6b
84642d3e-1540-4a4f-b4a1-eb0b8340a969	9ef80488-4450-4c37-bc28-65bb5db464ed
84642d3e-1540-4a4f-b4a1-eb0b8340a969	7476b86b-8faf-45a0-b4b5-2d88b37fc03d
e1a9ef4a-c7fa-44f7-b0aa-d5470c1c447f	9acaf1a6-8c46-4e00-88c8-b7b7ae22da96
e1a9ef4a-c7fa-44f7-b0aa-d5470c1c447f	dd86b0e6-16e6-4666-8041-635a99500c14
dd86b0e6-16e6-4666-8041-635a99500c14	b2eb50ba-6605-4fd8-a834-c13f93a2c561
46250e6b-de82-47e2-b204-8a7f273fb8bb	3f4e2a34-5114-43bd-b483-73227deb920d
b4debcf6-d58c-46fb-9b9c-a09722443bc3	356cb6d6-6385-4b41-a7ca-3a443e400800
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	cc152e1f-3cbc-40aa-ba17-acbe047c627f
e1a9ef4a-c7fa-44f7-b0aa-d5470c1c447f	b6eb6994-4cd3-494d-ab28-52e9ed7c7a0b
e1a9ef4a-c7fa-44f7-b0aa-d5470c1c447f	e0af49b8-5226-4aad-9bd0-acb4a4a2c2e2
\.


--
-- TOC entry 3864 (class 0 OID 18184)
-- Dependencies: 219
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
c812c978-9500-4856-9b9a-e7291ad9158f	\N	password	5c48c26b-6882-4d15-81cb-cca156d198e5	1735264978345	\N	{"value":"OmxLykTchxPuG/z62WxZKV21u63ZprEcUiFLFW2e2is=","salt":"2KpakJAjgfZDMeD8mLmOBw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
00f39e08-dac2-4237-bebe-0c3887b09632	\N	password	81e1abc6-74a4-45e6-b690-0504b1ef071d	1735265625411	Password	{"value":"JAEPPOW673Xcemb+yxCqSSGbHAwMydylwdbyeRg6Vnw=","salt":"zJLu8jVlA9YP3vCMHf/Ftg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- TOC entry 3865 (class 0 OID 18190)
-- Dependencies: 220
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-12-27 02:02:43.883893	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5264963118
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-12-27 02:02:43.898695	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5264963118
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-12-27 02:02:43.969803	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	5264963118
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-12-27 02:02:43.977174	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5264963118
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-12-27 02:02:44.142655	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5264963118
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-12-27 02:02:44.170862	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5264963118
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-12-27 02:02:44.363512	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5264963118
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-12-27 02:02:44.375301	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5264963118
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-12-27 02:02:44.385707	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	5264963118
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-12-27 02:02:44.540615	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	5264963118
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-12-27 02:02:44.632369	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5264963118
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-12-27 02:02:44.640817	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5264963118
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-12-27 02:02:44.680686	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5264963118
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-12-27 02:02:44.71758	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	5264963118
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-12-27 02:02:44.721777	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-12-27 02:02:44.726841	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	5264963118
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-12-27 02:02:44.735039	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	5264963118
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-12-27 02:02:44.809558	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	5264963118
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-12-27 02:02:44.883214	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5264963118
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-12-27 02:02:44.891232	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5264963118
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.864032	144	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	5264963118
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-12-27 02:02:44.896653	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5264963118
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-12-27 02:02:44.90091	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5264963118
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-12-27 02:02:45.026591	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	5264963118
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-12-27 02:02:45.036667	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5264963118
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-12-27 02:02:45.03952	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5264963118
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-12-27 02:02:45.697648	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	5264963118
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-12-27 02:02:45.824476	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	5264963118
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-12-27 02:02:45.837817	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5264963118
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-12-27 02:02:46.015981	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	5264963118
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-12-27 02:02:46.039452	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	5264963118
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-12-27 02:02:46.086114	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	5264963118
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-12-27 02:02:46.095811	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	5264963118
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-12-27 02:02:46.106471	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-12-27 02:02:46.111626	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5264963118
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-12-27 02:02:46.162276	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5264963118
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-12-27 02:02:46.180922	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	5264963118
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-12-27 02:02:46.200282	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5264963118
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-12-27 02:02:46.217902	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	5264963118
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-12-27 02:02:46.229033	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	5264963118
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-12-27 02:02:46.232134	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5264963118
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-12-27 02:02:46.236542	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5264963118
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-12-27 02:02:46.247215	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	5264963118
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-12-27 02:02:49.317759	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	5264963118
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-12-27 02:02:49.327296	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	5264963118
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-12-27 02:02:49.363369	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5264963118
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-12-27 02:02:49.381662	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	5264963118
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-12-27 02:02:49.40055	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5264963118
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-12-27 02:02:49.78138	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	5264963118
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-12-27 02:02:49.796836	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	5264963118
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-12-27 02:02:49.891673	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	5264963118
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-12-27 02:02:50.755001	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	5264963118
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-12-27 02:02:50.762188	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-12-27 02:02:50.766905	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	5264963118
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-12-27 02:02:50.771959	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	5264963118
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-12-27 02:02:50.783514	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	5264963118
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-12-27 02:02:50.788594	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	5264963118
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-12-27 02:02:50.952578	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	5264963118
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-12-27 02:02:51.894225	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	5264963118
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-12-27 02:02:51.990276	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	5264963118
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-12-27 02:02:52.025634	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5264963118
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-12-27 02:02:52.06186	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	5264963118
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-12-27 02:02:52.083283	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	5264963118
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-12-27 02:02:52.094156	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5264963118
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-12-27 02:02:52.105654	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5264963118
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-12-27 02:02:52.124248	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	5264963118
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-12-27 02:02:52.222818	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	5264963118
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-12-27 02:02:52.295969	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	5264963118
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-12-27 02:02:52.305	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	5264963118
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-12-27 02:02:52.409382	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	5264963118
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-12-27 02:02:52.445209	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	5264963118
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-12-27 02:02:52.456061	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5264963118
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-12-27 02:02:52.467826	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5264963118
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-12-27 02:02:52.4863	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5264963118
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-12-27 02:02:52.500773	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5264963118
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-12-27 02:02:52.542074	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	5264963118
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-12-27 02:02:52.609125	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	5264963118
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-12-27 02:02:52.617661	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	5264963118
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-12-27 02:02:52.61974	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	5264963118
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-12-27 02:02:52.643403	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	5264963118
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-12-27 02:02:52.646532	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	5264963118
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-12-27 02:02:52.702902	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	5264963118
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-12-27 02:02:52.705119	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5264963118
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-12-27 02:02:52.713637	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5264963118
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-12-27 02:02:52.715577	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5264963118
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-12-27 02:02:52.766639	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5264963118
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-12-27 02:02:52.775312	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	5264963118
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-12-27 02:02:52.81578	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	5264963118
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-12-27 02:02:52.859801	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	5264963118
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:52.899239	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	5264963118
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:52.910254	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	5264963118
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:52.973156	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:52.996919	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	5264963118
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:53.002127	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5264963118
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:53.031379	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5264963118
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:53.034501	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	5264963118
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-12-27 02:02:53.043387	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	5264963118
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.207221	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.212463	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.232601	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.337226	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.340815	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.408948	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	5264963118
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-12-27 02:02:53.414992	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	5264963118
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-12-27 02:02:53.428382	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	5264963118
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-12-27 02:02:53.494133	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	5264963118
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-12-27 02:02:53.557387	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5264963118
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2024-12-27 02:02:53.628943	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	5264963118
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-12-27 02:02:53.636416	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	5264963118
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-12-27 02:02:53.703122	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5264963118
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-12-27 02:02:53.706543	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5264963118
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-12-27 02:02:53.731961	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-12-27 02:02:53.745017	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	5264963118
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-12-27 02:02:53.798895	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5264963118
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-12-27 02:02:53.802916	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	5264963118
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-12-27 02:02:53.812041	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	5264963118
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-12-27 02:02:53.814503	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	5264963118
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-12-27 02:02:53.825632	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	5264963118
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-12-27 02:02:53.829844	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5264963118
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-12-27 02:02:54.029873	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	5264963118
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-12-27 02:02:54.034523	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	5264963118
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-12-27 02:02:54.041616	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-12-27 02:02:54.095325	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-12-27 02:02:54.104017	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	5264963118
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-12-27 02:02:54.106594	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-12-27 02:02:54.112362	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5264963118
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.122256	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5264963118
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.182068	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.188701	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.29.1	\N	\N	5264963118
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.190575	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.235114	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5264963118
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.257164	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5264963118
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.270285	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5264963118
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.274417	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5264963118
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-12-27 02:02:54.389874	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	5264963118
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.405686	135	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	5264963118
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.451794	136	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	5264963118
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.543938	137	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5264963118
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.574147	138	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	5264963118
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.589334	139	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5264963118
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.646631	140	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5264963118
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.759417	141	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	5264963118
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.820417	142	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5264963118
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2024-12-27 02:02:54.854341	143	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	5264963118
\.


--
-- TOC entry 3866 (class 0 OID 18196)
-- Dependencies: 221
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- TOC entry 3867 (class 0 OID 18199)
-- Dependencies: 222
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
bf3cd271-f79f-489d-a33a-e1aeca2849af	b9ed316a-a552-4e5b-aa2a-2dfe929b5ab3	f
bf3cd271-f79f-489d-a33a-e1aeca2849af	c07a62d9-68ff-404a-a20f-e9eb260ceca5	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	0e42659d-232f-48f9-85a6-26b16c65d76c	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	0d4b0360-9364-4396-a059-281903d83c52	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	ed7292f9-f5c6-4dcf-beff-640ba072c94e	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	06c3c5f6-673f-4416-91e6-696d94818c99	f
bf3cd271-f79f-489d-a33a-e1aeca2849af	c69bf813-3caa-47b0-ac87-57af202cad60	f
bf3cd271-f79f-489d-a33a-e1aeca2849af	773ba6f5-099c-4d5e-b8e1-02aa82a70b91	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	5076853e-f4a8-43c9-8489-ff40a6de64e8	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	fc7ba391-55e0-4225-acb7-554c5096caad	f
bf3cd271-f79f-489d-a33a-e1aeca2849af	d44e15d0-09d3-49d2-82af-1dd0c86388c0	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	64a584f8-43ee-4d37-a71b-4bb7d0145da3	t
bf3cd271-f79f-489d-a33a-e1aeca2849af	ff18f871-b157-425a-b7f1-f5b8eca1ecff	f
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	512ec048-be84-4a1a-bae8-c6762276641d	f
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	0cc25f38-25d2-4ff5-b0b4-9b50f2b0cdc7	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	c31d724d-7359-463b-9fb7-6248b8d2e896	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	c7560195-2713-42c6-b0c4-fde589d61209	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	4fd1dced-51b1-4bef-864f-e2fa30c42b98	f
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	0a67fb41-44eb-4848-b5e3-eb3c04e9892e	f
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	67df8efa-16d5-45f0-9cc9-385cc9c770f3	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	bf081ef6-7a73-42ae-9039-843cc153126e	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	c2be3976-92c4-4463-b593-4b6384ad7243	f
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	9ba54981-2673-4418-8dca-3a856130a574	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	d67a9f3a-fef0-4b26-a26a-4dd58e989387	t
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	c74a24bb-ee5b-427a-897c-579438cc4115	f
\.


--
-- TOC entry 3868 (class 0 OID 18203)
-- Dependencies: 223
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- TOC entry 3869 (class 0 OID 18209)
-- Dependencies: 224
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- TOC entry 3870 (class 0 OID 18215)
-- Dependencies: 225
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3871 (class 0 OID 18221)
-- Dependencies: 226
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3872 (class 0 OID 18224)
-- Dependencies: 227
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 3873 (class 0 OID 18230)
-- Dependencies: 228
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3874 (class 0 OID 18233)
-- Dependencies: 229
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3875 (class 0 OID 18240)
-- Dependencies: 230
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3876 (class 0 OID 18243)
-- Dependencies: 231
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 3877 (class 0 OID 18249)
-- Dependencies: 232
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 3878 (class 0 OID 18255)
-- Dependencies: 233
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 3879 (class 0 OID 18262)
-- Dependencies: 234
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 3880 (class 0 OID 18265)
-- Dependencies: 235
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- TOC entry 3881 (class 0 OID 18278)
-- Dependencies: 236
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 3882 (class 0 OID 18284)
-- Dependencies: 237
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 3883 (class 0 OID 18290)
-- Dependencies: 238
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 3884 (class 0 OID 18296)
-- Dependencies: 239
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- TOC entry 3885 (class 0 OID 18300)
-- Dependencies: 240
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
082b3aa4-4a07-4c14-8002-168ef58ad8ca	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	${role_default-roles}	default-roles-master	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	\N
8f20434b-197c-4474-a7cc-675f9a90e1e7	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	${role_create-realm}	create-realm	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	\N
b4debcf6-d58c-46fb-9b9c-a09722443bc3	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	${role_admin}	admin	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	\N
0801606b-fa8b-4c60-a592-3d4049b25289	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_create-client}	create-client	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
35876926-2148-47a7-aa00-de6835e49f42	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_view-realm}	view-realm	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
46ecacbd-a374-44ba-9ab1-c2738a4f220a	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_view-users}	view-users	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
6a5b9e6a-4348-4cf6-ae90-d782c92f69c5	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_view-clients}	view-clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
f1c183da-9d37-4466-a414-05f716d3a3d9	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_view-events}	view-events	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
d89973ec-b812-440f-a5da-0459306362e3	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_view-identity-providers}	view-identity-providers	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
95d6c8d3-018a-4685-8c1c-663729ae0f9b	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_view-authorization}	view-authorization	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
f4ae45fe-88b9-458a-9cc0-36c5322dfd84	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_manage-realm}	manage-realm	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
a013aade-e67a-408a-9f9c-a8294825fe84	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_manage-users}	manage-users	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
5aea1f1b-39f1-4f8e-b4a1-48c63d33918a	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_manage-clients}	manage-clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
4b57de25-e7f7-49c7-9527-10da5f4499bf	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_manage-events}	manage-events	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
046b55f9-fe33-42e1-85b0-879dd39fe18a	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_manage-identity-providers}	manage-identity-providers	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
9c867d0d-aa90-4db0-8ba1-3853f0c598be	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_manage-authorization}	manage-authorization	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
f9c8fbfa-667d-4dc6-b194-8a2a3d5a489e	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_query-users}	query-users	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
7258fd24-345f-498c-a875-01968be66e88	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_query-clients}	query-clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
256618aa-b0f1-4ad6-9b59-e1cf37c3ad42	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_query-realms}	query-realms	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
922c497b-7663-445a-b42b-661b278f57c9	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_query-groups}	query-groups	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
484347c7-68f3-4a99-938a-a5d248e50902	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_view-profile}	view-profile	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
18a467e5-7c41-4c4f-9033-0cd02f04eece	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_manage-account}	manage-account	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
7ecbd9b6-87b9-49eb-bedf-4d293bb144b6	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_manage-account-links}	manage-account-links	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
5ea7325b-70eb-4d3f-81d3-68ce89091293	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_view-applications}	view-applications	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
edfb1c96-9fa4-440f-ab0e-0fc2fedd3cea	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_view-consent}	view-consent	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
7760c1a3-f1e1-4d72-87ae-fe1d60ea63be	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_manage-consent}	manage-consent	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
261f9ec2-0978-41e1-94ca-ac33f5f2258b	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_view-groups}	view-groups	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
24e71e4c-d26e-4a82-af65-8af30142a73b	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	t	${role_delete-account}	delete-account	bf3cd271-f79f-489d-a33a-e1aeca2849af	78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	\N
372b2338-41fb-40c6-b325-02493eed0948	a4e68fcd-909a-48cd-9bd1-8efbd950929a	t	${role_read-token}	read-token	bf3cd271-f79f-489d-a33a-e1aeca2849af	a4e68fcd-909a-48cd-9bd1-8efbd950929a	\N
975e696e-1588-48e4-bfd3-34aef5e50574	be3f8dd2-4e37-4c5f-9e78-d249a0216110	t	${role_impersonation}	impersonation	bf3cd271-f79f-489d-a33a-e1aeca2849af	be3f8dd2-4e37-4c5f-9e78-d249a0216110	\N
31d4e102-ed35-4180-92d4-682babba664d	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	${role_offline-access}	offline_access	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	\N
b4002fef-4a8b-4fdc-8e7a-cf65ce10a651	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	${role_uma_authorization}	uma_authorization	bf3cd271-f79f-489d-a33a-e1aeca2849af	\N	\N
e1a9ef4a-c7fa-44f7-b0aa-d5470c1c447f	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f	${role_default-roles}	default-roles-proposal-management	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N	\N
4c978834-6e30-4e8c-9803-fc6cb57df0a0	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_create-client}	create-client	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
b6fbd37a-adf6-4559-9afb-afff986cc7f8	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_view-realm}	view-realm	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
6b475cdb-5c10-4b07-9df4-8d2d83aaf1e0	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_view-users}	view-users	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
81dcd1a8-5eb3-41f7-8e80-6f35dcf8e474	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_view-clients}	view-clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
46d89910-33cd-4509-ab91-07f42bb9cb88	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_view-events}	view-events	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
d86d0366-283f-4056-8233-7c1d4573be84	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_view-identity-providers}	view-identity-providers	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
a8622636-7ff9-4e44-8723-8ad76a26f7b4	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_view-authorization}	view-authorization	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
66d47bad-a87b-496d-8238-2dd15c1c7dad	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_manage-realm}	manage-realm	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
15438547-66d4-4ca4-9a5b-e444a0ee0a2a	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_manage-users}	manage-users	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
d5cb008a-9b4a-4cdd-8f1c-2a23d24b678d	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_manage-clients}	manage-clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
d67cb152-68db-4839-b9d0-7d8e628079a8	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_manage-events}	manage-events	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
9bd69e09-b995-4400-a5cc-8318dd41feb6	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_manage-identity-providers}	manage-identity-providers	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
dd88bd11-ba80-461d-9ce7-15d22878870a	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_manage-authorization}	manage-authorization	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
17ad7bed-5747-47b9-8b21-18614a4c8b6b	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_query-users}	query-users	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
dc08043e-e9db-4252-a511-2d92400f20dc	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_query-clients}	query-clients	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
0d00bfd5-e930-426b-a802-a44f0f7bd147	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_query-realms}	query-realms	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
0c48ee54-5c87-40f9-8077-1cfc9c2d695c	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_query-groups}	query-groups	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
09b3f7c3-5e2f-4f2b-9009-e36dd479328c	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_realm-admin}	realm-admin	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
cabdc449-d9c5-44d9-9f04-5c17924abaf2	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_create-client}	create-client	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
1bff0f9e-f591-4d3e-83b6-d95101033e75	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_view-realm}	view-realm	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
84642d3e-1540-4a4f-b4a1-eb0b8340a969	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_view-users}	view-users	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
50863b87-5590-44bb-a9d4-4756f20b3332	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_view-clients}	view-clients	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
623f1480-8572-46f7-912c-5c34255d1199	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_view-events}	view-events	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
e27a6ae3-0648-4e7d-ba21-2a730482d75e	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_view-identity-providers}	view-identity-providers	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
42ca6f50-a1f5-4626-b80d-4149da2d4712	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_view-authorization}	view-authorization	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
0255271e-59df-4895-9cd3-2923b5f1cc13	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_manage-realm}	manage-realm	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
e2529853-592b-46c8-9398-0b5c1ae0ec02	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_manage-users}	manage-users	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
a55ebe33-19cb-4c20-8fb0-3384409c0ac4	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_manage-clients}	manage-clients	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
1d8bc5dd-e262-46d8-85f8-fba373fcb9ed	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_manage-events}	manage-events	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
ca8966b3-176a-4e42-8b6a-4949506bbf95	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_manage-identity-providers}	manage-identity-providers	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
b6a6c6db-547f-49e9-ae1b-f3649f59ae75	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_manage-authorization}	manage-authorization	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
9ef80488-4450-4c37-bc28-65bb5db464ed	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_query-users}	query-users	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
404fa9a2-3db8-4906-a97d-4c6daaa37e6b	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_query-clients}	query-clients	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
9f044762-a929-4a28-a427-3e876aace143	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_query-realms}	query-realms	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
7476b86b-8faf-45a0-b4b5-2d88b37fc03d	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_query-groups}	query-groups	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
9acaf1a6-8c46-4e00-88c8-b7b7ae22da96	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_view-profile}	view-profile	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
dd86b0e6-16e6-4666-8041-635a99500c14	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_manage-account}	manage-account	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
b2eb50ba-6605-4fd8-a834-c13f93a2c561	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_manage-account-links}	manage-account-links	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
b7e6a5d1-9d61-4bd4-bb24-9fda2385c40a	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_view-applications}	view-applications	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
3f4e2a34-5114-43bd-b483-73227deb920d	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_view-consent}	view-consent	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
46250e6b-de82-47e2-b204-8a7f273fb8bb	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_manage-consent}	manage-consent	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
38d448cf-3e76-4804-9c37-b333e542f44a	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_view-groups}	view-groups	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
b6476ab3-2c7e-4b50-a7ee-1d27d071e0bc	dbf4bcf0-60b6-4aec-af0f-14a975689023	t	${role_delete-account}	delete-account	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	dbf4bcf0-60b6-4aec-af0f-14a975689023	\N
356cb6d6-6385-4b41-a7ca-3a443e400800	bd2903a0-56b6-44ae-afd9-c6e9558afd40	t	${role_impersonation}	impersonation	bf3cd271-f79f-489d-a33a-e1aeca2849af	bd2903a0-56b6-44ae-afd9-c6e9558afd40	\N
cc152e1f-3cbc-40aa-ba17-acbe047c627f	f34a27af-46aa-4315-9247-142cb401abbf	t	${role_impersonation}	impersonation	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f34a27af-46aa-4315-9247-142cb401abbf	\N
223dae98-56ed-49f5-8669-4022cdf938c6	a6bd137d-19f9-4691-a007-5aa4127adcaa	t	${role_read-token}	read-token	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	a6bd137d-19f9-4691-a007-5aa4127adcaa	\N
b6eb6994-4cd3-494d-ab28-52e9ed7c7a0b	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f	${role_offline-access}	offline_access	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N	\N
e0af49b8-5226-4aad-9bd0-acb4a4a2c2e2	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f	${role_uma_authorization}	uma_authorization	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	\N	\N
91d15d0e-c0fd-441f-badb-28a96937dae2	84da2b2c-e7d5-4b35-9982-218c0f159e0b	t		BASIC	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	84da2b2c-e7d5-4b35-9982-218c0f159e0b	\N
\.


--
-- TOC entry 3886 (class 0 OID 18307)
-- Dependencies: 241
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ehc3v	26.0.1	1735264975
\.


--
-- TOC entry 3887 (class 0 OID 18311)
-- Dependencies: 242
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
2ac4896c-e9eb-4c44-9b26-f981b4fa1b95	8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	0	1735265733	{"authMethod":"openid-connect","redirectUri":"http://localhost:9090/admin/master/console/#/proposal-management/users/81e1abc6-74a4-45e6-b690-0504b1ef071d/settings","notes":{"clientId":"8fd24b9b-98f6-4f4f-9705-53f47b2bfe23","iss":"http://localhost:9090/realms/master","startedAt":"1735265493","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"e2cf238e-9915-40ec-a739-a5c53f294512","response_mode":"query","scope":"openid","userSessionStartedAt":"1735265493","redirect_uri":"http://localhost:9090/admin/master/console/#/proposal-management/users/81e1abc6-74a4-45e6-b690-0504b1ef071d/settings","state":"46ec06a3-cc32-4a19-8969-24d35c264402","code_challenge":"n-BnVCsWE8G-0O7XcYTLuKBGSctTvx0FODwokBOdzos","prompt":"none","SSO_AUTH":"true"}}	local	local	4
92e527fc-a5dc-40ce-972d-b1e6378b3a2f	84da2b2c-e7d5-4b35-9982-218c0f159e0b	0	1735265740	{"authMethod":"openid-connect","notes":{"clientId":"84da2b2c-e7d5-4b35-9982-218c0f159e0b","userSessionStartedAt":"1735265740","iss":"http://localhost:9090/realms/proposal-management","startedAt":"1735265740","level-of-authentication":"-1"}}	local	local	0
\.


--
-- TOC entry 3888 (class 0 OID 18320)
-- Dependencies: 243
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
2ac4896c-e9eb-4c44-9b26-f981b4fa1b95	5c48c26b-6882-4d15-81cb-cca156d198e5	bf3cd271-f79f-489d-a33a-e1aeca2849af	1735265493	0	{"ipAddress":"172.22.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjIuMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRWRnZS8xMzEuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1735265493","authenticators-completed":"{\\"f7252ffb-61da-47fd-9d31-7a80db68e2b3\\":1735265493,\\"4cb38d25-6840-476c-b323-cb4c9e6605f4\\":1735265641}"},"state":"LOGGED_IN"}	1735265733	\N	4
92e527fc-a5dc-40ce-972d-b1e6378b3a2f	81e1abc6-74a4-45e6-b690-0504b1ef071d	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	1735265740	0	{"ipAddress":"172.22.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjIuMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","authenticators-completed":"{\\"3d086b06-c884-4a88-92b5-3130a48ac4c5\\":1735265740,\\"cfeb9303-ffe8-4d7f-a075-017a0cb63f63\\":1735265740}"},"state":"LOGGED_IN"}	1735265740	\N	0
\.


--
-- TOC entry 3889 (class 0 OID 18328)
-- Dependencies: 244
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- TOC entry 3890 (class 0 OID 18334)
-- Dependencies: 245
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- TOC entry 3891 (class 0 OID 18340)
-- Dependencies: 246
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 3892 (class 0 OID 18346)
-- Dependencies: 247
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
39a29d2a-cf28-4bc4-9a59-37b7ac1d49c4	audience resolve	openid-connect	oidc-audience-resolve-mapper	a9df6a75-0443-4041-97b5-1016a7d512fb	\N
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	locale	openid-connect	oidc-usermodel-attribute-mapper	8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	\N
ae442bb9-058a-46b4-883f-7e9fd5d9c326	role list	saml	saml-role-list-mapper	\N	c07a62d9-68ff-404a-a20f-e9eb260ceca5
fc638767-f085-40de-a252-291e3ce66f6f	organization	saml	saml-organization-membership-mapper	\N	0e42659d-232f-48f9-85a6-26b16c65d76c
1521e74d-e031-46af-a571-403beb3621c1	full name	openid-connect	oidc-full-name-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
cb499af8-e742-4f1f-9d94-4ddc40777bf5	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
3f7393c5-83f4-469a-a60e-c77e51eec531	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
13e88339-e741-4fe2-9242-e0f1d40e248b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
b7a8d830-d210-44ac-a09a-d9e199301ee6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
e1d46228-7fe0-40ac-af74-4917e4effee0	username	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
37df9a48-9f35-4ebc-8fca-7c42f9e70306	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
a3373b58-27ee-447b-b37f-b146624d8593	website	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
a2f74a6d-498c-4b7c-8f13-3257c1971977	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
7612e467-3fe7-41d8-9bb0-bd844399223a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	0d4b0360-9364-4396-a059-281903d83c52
b3c05376-791d-4a06-a712-74770558146f	email	openid-connect	oidc-usermodel-attribute-mapper	\N	ed7292f9-f5c6-4dcf-beff-640ba072c94e
aa87a040-0fae-442d-a31f-fe3b370bb1f9	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ed7292f9-f5c6-4dcf-beff-640ba072c94e
dc58171c-4c6e-431f-91e5-eafe54014d7d	address	openid-connect	oidc-address-mapper	\N	06c3c5f6-673f-4416-91e6-696d94818c99
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c69bf813-3caa-47b0-ac87-57af202cad60
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c69bf813-3caa-47b0-ac87-57af202cad60
68510a72-e9af-4364-bc31-6dd25b5c7ff7	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	773ba6f5-099c-4d5e-b8e1-02aa82a70b91
24387468-1097-48a2-a139-7d280c2c8882	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	773ba6f5-099c-4d5e-b8e1-02aa82a70b91
8885b267-9de0-449e-af6f-9fd5a5ba5f17	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	773ba6f5-099c-4d5e-b8e1-02aa82a70b91
eaf9504c-38e5-439f-a6cd-a4ae3296f7e5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5076853e-f4a8-43c9-8489-ff40a6de64e8
4d896139-78fc-4d2d-ad96-f888be79c0c9	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	fc7ba391-55e0-4225-acb7-554c5096caad
3862238d-5581-4047-8708-133f3617830b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	fc7ba391-55e0-4225-acb7-554c5096caad
695e164e-3759-43a2-af08-1420601aff06	acr loa level	openid-connect	oidc-acr-mapper	\N	d44e15d0-09d3-49d2-82af-1dd0c86388c0
0a8477f2-0c24-4270-aa8e-0357432065a6	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	64a584f8-43ee-4d37-a71b-4bb7d0145da3
151cb502-8261-42b1-9b52-68d77ffcb0f9	sub	openid-connect	oidc-sub-mapper	\N	64a584f8-43ee-4d37-a71b-4bb7d0145da3
e62d30a4-8063-4755-b574-58ec6a46af94	organization	openid-connect	oidc-organization-membership-mapper	\N	ff18f871-b157-425a-b7f1-f5b8eca1ecff
63761063-1400-4c01-aef4-d2f7edfc90c2	audience resolve	openid-connect	oidc-audience-resolve-mapper	e4ccd477-dbcc-4967-a9fc-5d9de7da3386	\N
53d45e01-c647-4f06-8608-52a596ec225c	role list	saml	saml-role-list-mapper	\N	0cc25f38-25d2-4ff5-b0b4-9b50f2b0cdc7
ba5ada57-62ae-49a0-bc2b-540117593f6b	organization	saml	saml-organization-membership-mapper	\N	c31d724d-7359-463b-9fb7-6248b8d2e896
7e4c9c22-6c62-4895-a919-1df2ab60f452	full name	openid-connect	oidc-full-name-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
61941942-7fde-4999-b91b-26bfe30e7d8a	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
7891aa77-6eed-4dca-90f9-790d048bdb4f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
524c14a1-9cf4-46b5-afcb-0247cb2707b2	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	username	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
4d4a99c9-b065-4713-a421-e1d3ad34aefd	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
60491814-e2cf-4010-92cd-d810c1512d70	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
c80da40e-3bbd-41fa-94c4-786c38d2a050	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
332793c2-0e9e-4478-95b9-2f2ea665616e	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
9fd3c21b-68ff-4807-9e56-886e5cb9c805	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
f763915c-6f91-479f-b623-45cecafa736c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
72e78387-af1e-461c-b01c-d4b4024b9889	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c7560195-2713-42c6-b0c4-fde589d61209
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	email	openid-connect	oidc-usermodel-attribute-mapper	\N	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af
772457a8-8884-4333-975d-cbc85320f9e4	email verified	openid-connect	oidc-usermodel-property-mapper	\N	72ea9e57-3b5e-4ad7-af71-797ed2e6f5af
342a3e70-1d12-4587-863a-f183b959b961	address	openid-connect	oidc-address-mapper	\N	4fd1dced-51b1-4bef-864f-e2fa30c42b98
f595e9f1-468c-48d8-b65a-f55002326542	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	0a67fb41-44eb-4848-b5e3-eb3c04e9892e
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	0a67fb41-44eb-4848-b5e3-eb3c04e9892e
4ee672ed-4321-499f-8dd8-02c57d39c8ea	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	67df8efa-16d5-45f0-9cc9-385cc9c770f3
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	67df8efa-16d5-45f0-9cc9-385cc9c770f3
b8022b3d-838b-42cd-9a4b-e7e927360d76	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	67df8efa-16d5-45f0-9cc9-385cc9c770f3
fb3b0899-55b5-4403-a03c-cf353ef1a81c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	bf081ef6-7a73-42ae-9039-843cc153126e
a4e7c086-268b-4784-88f8-e96799619837	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	c2be3976-92c4-4463-b593-4b6384ad7243
b22b27d9-5480-43a9-8abd-5af2f2168b1d	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	c2be3976-92c4-4463-b593-4b6384ad7243
b3eb2a30-5c21-43e7-9671-a1e5d02ff515	acr loa level	openid-connect	oidc-acr-mapper	\N	9ba54981-2673-4418-8dca-3a856130a574
037625c5-4947-4a81-9381-e12d5f055a2e	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	d67a9f3a-fef0-4b26-a26a-4dd58e989387
83fecc2e-3f53-46ac-b892-54059e03fe45	sub	openid-connect	oidc-sub-mapper	\N	d67a9f3a-fef0-4b26-a26a-4dd58e989387
ab9249f3-9505-418a-9085-19f498a063a0	organization	openid-connect	oidc-organization-membership-mapper	\N	c74a24bb-ee5b-427a-897c-579438cc4115
18505d25-c376-40c1-a20c-055290fb70c5	locale	openid-connect	oidc-usermodel-attribute-mapper	fc9cf51f-87d1-4020-b812-9a127e479ccd	\N
\.


--
-- TOC entry 3893 (class 0 OID 18352)
-- Dependencies: 248
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	true	introspection.token.claim
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	true	userinfo.token.claim
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	locale	user.attribute
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	true	id.token.claim
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	true	access.token.claim
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	locale	claim.name
d4bbe613-24dc-4cf0-8fff-c77d2d2c00ba	String	jsonType.label
ae442bb9-058a-46b4-883f-7e9fd5d9c326	false	single
ae442bb9-058a-46b4-883f-7e9fd5d9c326	Basic	attribute.nameformat
ae442bb9-058a-46b4-883f-7e9fd5d9c326	Role	attribute.name
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	true	introspection.token.claim
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	true	userinfo.token.claim
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	profile	user.attribute
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	true	id.token.claim
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	true	access.token.claim
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	profile	claim.name
01c75101-b9f2-4b7f-9f0c-6c57a5c6bc50	String	jsonType.label
13e88339-e741-4fe2-9242-e0f1d40e248b	true	introspection.token.claim
13e88339-e741-4fe2-9242-e0f1d40e248b	true	userinfo.token.claim
13e88339-e741-4fe2-9242-e0f1d40e248b	middleName	user.attribute
13e88339-e741-4fe2-9242-e0f1d40e248b	true	id.token.claim
13e88339-e741-4fe2-9242-e0f1d40e248b	true	access.token.claim
13e88339-e741-4fe2-9242-e0f1d40e248b	middle_name	claim.name
13e88339-e741-4fe2-9242-e0f1d40e248b	String	jsonType.label
1521e74d-e031-46af-a571-403beb3621c1	true	introspection.token.claim
1521e74d-e031-46af-a571-403beb3621c1	true	userinfo.token.claim
1521e74d-e031-46af-a571-403beb3621c1	true	id.token.claim
1521e74d-e031-46af-a571-403beb3621c1	true	access.token.claim
37df9a48-9f35-4ebc-8fca-7c42f9e70306	true	introspection.token.claim
37df9a48-9f35-4ebc-8fca-7c42f9e70306	true	userinfo.token.claim
37df9a48-9f35-4ebc-8fca-7c42f9e70306	picture	user.attribute
37df9a48-9f35-4ebc-8fca-7c42f9e70306	true	id.token.claim
37df9a48-9f35-4ebc-8fca-7c42f9e70306	true	access.token.claim
37df9a48-9f35-4ebc-8fca-7c42f9e70306	picture	claim.name
37df9a48-9f35-4ebc-8fca-7c42f9e70306	String	jsonType.label
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	true	introspection.token.claim
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	true	userinfo.token.claim
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	birthdate	user.attribute
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	true	id.token.claim
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	true	access.token.claim
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	birthdate	claim.name
3c1f4471-af4f-4c3c-b4b9-280521a2ae47	String	jsonType.label
3f7393c5-83f4-469a-a60e-c77e51eec531	true	introspection.token.claim
3f7393c5-83f4-469a-a60e-c77e51eec531	true	userinfo.token.claim
3f7393c5-83f4-469a-a60e-c77e51eec531	firstName	user.attribute
3f7393c5-83f4-469a-a60e-c77e51eec531	true	id.token.claim
3f7393c5-83f4-469a-a60e-c77e51eec531	true	access.token.claim
3f7393c5-83f4-469a-a60e-c77e51eec531	given_name	claim.name
3f7393c5-83f4-469a-a60e-c77e51eec531	String	jsonType.label
7612e467-3fe7-41d8-9bb0-bd844399223a	true	introspection.token.claim
7612e467-3fe7-41d8-9bb0-bd844399223a	true	userinfo.token.claim
7612e467-3fe7-41d8-9bb0-bd844399223a	updatedAt	user.attribute
7612e467-3fe7-41d8-9bb0-bd844399223a	true	id.token.claim
7612e467-3fe7-41d8-9bb0-bd844399223a	true	access.token.claim
7612e467-3fe7-41d8-9bb0-bd844399223a	updated_at	claim.name
7612e467-3fe7-41d8-9bb0-bd844399223a	long	jsonType.label
a2f74a6d-498c-4b7c-8f13-3257c1971977	true	introspection.token.claim
a2f74a6d-498c-4b7c-8f13-3257c1971977	true	userinfo.token.claim
a2f74a6d-498c-4b7c-8f13-3257c1971977	gender	user.attribute
a2f74a6d-498c-4b7c-8f13-3257c1971977	true	id.token.claim
a2f74a6d-498c-4b7c-8f13-3257c1971977	true	access.token.claim
a2f74a6d-498c-4b7c-8f13-3257c1971977	gender	claim.name
a2f74a6d-498c-4b7c-8f13-3257c1971977	String	jsonType.label
a3373b58-27ee-447b-b37f-b146624d8593	true	introspection.token.claim
a3373b58-27ee-447b-b37f-b146624d8593	true	userinfo.token.claim
a3373b58-27ee-447b-b37f-b146624d8593	website	user.attribute
a3373b58-27ee-447b-b37f-b146624d8593	true	id.token.claim
a3373b58-27ee-447b-b37f-b146624d8593	true	access.token.claim
a3373b58-27ee-447b-b37f-b146624d8593	website	claim.name
a3373b58-27ee-447b-b37f-b146624d8593	String	jsonType.label
b7a8d830-d210-44ac-a09a-d9e199301ee6	true	introspection.token.claim
b7a8d830-d210-44ac-a09a-d9e199301ee6	true	userinfo.token.claim
b7a8d830-d210-44ac-a09a-d9e199301ee6	nickname	user.attribute
b7a8d830-d210-44ac-a09a-d9e199301ee6	true	id.token.claim
b7a8d830-d210-44ac-a09a-d9e199301ee6	true	access.token.claim
b7a8d830-d210-44ac-a09a-d9e199301ee6	nickname	claim.name
b7a8d830-d210-44ac-a09a-d9e199301ee6	String	jsonType.label
cb499af8-e742-4f1f-9d94-4ddc40777bf5	true	introspection.token.claim
cb499af8-e742-4f1f-9d94-4ddc40777bf5	true	userinfo.token.claim
cb499af8-e742-4f1f-9d94-4ddc40777bf5	lastName	user.attribute
cb499af8-e742-4f1f-9d94-4ddc40777bf5	true	id.token.claim
cb499af8-e742-4f1f-9d94-4ddc40777bf5	true	access.token.claim
cb499af8-e742-4f1f-9d94-4ddc40777bf5	family_name	claim.name
cb499af8-e742-4f1f-9d94-4ddc40777bf5	String	jsonType.label
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	true	introspection.token.claim
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	true	userinfo.token.claim
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	zoneinfo	user.attribute
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	true	id.token.claim
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	true	access.token.claim
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	zoneinfo	claim.name
cbed20ff-77dd-4bfa-ba0b-2f8875db8104	String	jsonType.label
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	true	introspection.token.claim
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	true	userinfo.token.claim
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	locale	user.attribute
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	true	id.token.claim
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	true	access.token.claim
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	locale	claim.name
cedb9c5c-013f-4195-85c7-b6bfc2e328b1	String	jsonType.label
e1d46228-7fe0-40ac-af74-4917e4effee0	true	introspection.token.claim
e1d46228-7fe0-40ac-af74-4917e4effee0	true	userinfo.token.claim
e1d46228-7fe0-40ac-af74-4917e4effee0	username	user.attribute
e1d46228-7fe0-40ac-af74-4917e4effee0	true	id.token.claim
e1d46228-7fe0-40ac-af74-4917e4effee0	true	access.token.claim
e1d46228-7fe0-40ac-af74-4917e4effee0	preferred_username	claim.name
e1d46228-7fe0-40ac-af74-4917e4effee0	String	jsonType.label
aa87a040-0fae-442d-a31f-fe3b370bb1f9	true	introspection.token.claim
aa87a040-0fae-442d-a31f-fe3b370bb1f9	true	userinfo.token.claim
aa87a040-0fae-442d-a31f-fe3b370bb1f9	emailVerified	user.attribute
aa87a040-0fae-442d-a31f-fe3b370bb1f9	true	id.token.claim
aa87a040-0fae-442d-a31f-fe3b370bb1f9	true	access.token.claim
aa87a040-0fae-442d-a31f-fe3b370bb1f9	email_verified	claim.name
aa87a040-0fae-442d-a31f-fe3b370bb1f9	boolean	jsonType.label
b3c05376-791d-4a06-a712-74770558146f	true	introspection.token.claim
b3c05376-791d-4a06-a712-74770558146f	true	userinfo.token.claim
b3c05376-791d-4a06-a712-74770558146f	email	user.attribute
b3c05376-791d-4a06-a712-74770558146f	true	id.token.claim
b3c05376-791d-4a06-a712-74770558146f	true	access.token.claim
b3c05376-791d-4a06-a712-74770558146f	email	claim.name
b3c05376-791d-4a06-a712-74770558146f	String	jsonType.label
dc58171c-4c6e-431f-91e5-eafe54014d7d	formatted	user.attribute.formatted
dc58171c-4c6e-431f-91e5-eafe54014d7d	country	user.attribute.country
dc58171c-4c6e-431f-91e5-eafe54014d7d	true	introspection.token.claim
dc58171c-4c6e-431f-91e5-eafe54014d7d	postal_code	user.attribute.postal_code
dc58171c-4c6e-431f-91e5-eafe54014d7d	true	userinfo.token.claim
dc58171c-4c6e-431f-91e5-eafe54014d7d	street	user.attribute.street
dc58171c-4c6e-431f-91e5-eafe54014d7d	true	id.token.claim
dc58171c-4c6e-431f-91e5-eafe54014d7d	region	user.attribute.region
dc58171c-4c6e-431f-91e5-eafe54014d7d	true	access.token.claim
dc58171c-4c6e-431f-91e5-eafe54014d7d	locality	user.attribute.locality
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	true	introspection.token.claim
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	true	userinfo.token.claim
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	phoneNumber	user.attribute
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	true	id.token.claim
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	true	access.token.claim
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	phone_number	claim.name
5a46a0e4-c926-4a4b-8bf7-4cf3b21951c3	String	jsonType.label
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	true	introspection.token.claim
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	true	userinfo.token.claim
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	phoneNumberVerified	user.attribute
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	true	id.token.claim
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	true	access.token.claim
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	phone_number_verified	claim.name
7654a80a-f2f8-409d-91f4-e19f7c49ee8f	boolean	jsonType.label
24387468-1097-48a2-a139-7d280c2c8882	true	introspection.token.claim
24387468-1097-48a2-a139-7d280c2c8882	true	multivalued
24387468-1097-48a2-a139-7d280c2c8882	foo	user.attribute
24387468-1097-48a2-a139-7d280c2c8882	true	access.token.claim
24387468-1097-48a2-a139-7d280c2c8882	resource_access.${client_id}.roles	claim.name
24387468-1097-48a2-a139-7d280c2c8882	String	jsonType.label
68510a72-e9af-4364-bc31-6dd25b5c7ff7	true	introspection.token.claim
68510a72-e9af-4364-bc31-6dd25b5c7ff7	true	multivalued
68510a72-e9af-4364-bc31-6dd25b5c7ff7	foo	user.attribute
68510a72-e9af-4364-bc31-6dd25b5c7ff7	true	access.token.claim
68510a72-e9af-4364-bc31-6dd25b5c7ff7	realm_access.roles	claim.name
68510a72-e9af-4364-bc31-6dd25b5c7ff7	String	jsonType.label
8885b267-9de0-449e-af6f-9fd5a5ba5f17	true	introspection.token.claim
8885b267-9de0-449e-af6f-9fd5a5ba5f17	true	access.token.claim
eaf9504c-38e5-439f-a6cd-a4ae3296f7e5	true	introspection.token.claim
eaf9504c-38e5-439f-a6cd-a4ae3296f7e5	true	access.token.claim
3862238d-5581-4047-8708-133f3617830b	true	introspection.token.claim
3862238d-5581-4047-8708-133f3617830b	true	multivalued
3862238d-5581-4047-8708-133f3617830b	foo	user.attribute
3862238d-5581-4047-8708-133f3617830b	true	id.token.claim
3862238d-5581-4047-8708-133f3617830b	true	access.token.claim
3862238d-5581-4047-8708-133f3617830b	groups	claim.name
3862238d-5581-4047-8708-133f3617830b	String	jsonType.label
4d896139-78fc-4d2d-ad96-f888be79c0c9	true	introspection.token.claim
4d896139-78fc-4d2d-ad96-f888be79c0c9	true	userinfo.token.claim
4d896139-78fc-4d2d-ad96-f888be79c0c9	username	user.attribute
4d896139-78fc-4d2d-ad96-f888be79c0c9	true	id.token.claim
4d896139-78fc-4d2d-ad96-f888be79c0c9	true	access.token.claim
4d896139-78fc-4d2d-ad96-f888be79c0c9	upn	claim.name
4d896139-78fc-4d2d-ad96-f888be79c0c9	String	jsonType.label
695e164e-3759-43a2-af08-1420601aff06	true	introspection.token.claim
695e164e-3759-43a2-af08-1420601aff06	true	id.token.claim
695e164e-3759-43a2-af08-1420601aff06	true	access.token.claim
0a8477f2-0c24-4270-aa8e-0357432065a6	AUTH_TIME	user.session.note
0a8477f2-0c24-4270-aa8e-0357432065a6	true	introspection.token.claim
0a8477f2-0c24-4270-aa8e-0357432065a6	true	id.token.claim
0a8477f2-0c24-4270-aa8e-0357432065a6	true	access.token.claim
0a8477f2-0c24-4270-aa8e-0357432065a6	auth_time	claim.name
0a8477f2-0c24-4270-aa8e-0357432065a6	long	jsonType.label
151cb502-8261-42b1-9b52-68d77ffcb0f9	true	introspection.token.claim
151cb502-8261-42b1-9b52-68d77ffcb0f9	true	access.token.claim
e62d30a4-8063-4755-b574-58ec6a46af94	true	introspection.token.claim
e62d30a4-8063-4755-b574-58ec6a46af94	true	multivalued
e62d30a4-8063-4755-b574-58ec6a46af94	true	id.token.claim
e62d30a4-8063-4755-b574-58ec6a46af94	true	access.token.claim
e62d30a4-8063-4755-b574-58ec6a46af94	organization	claim.name
e62d30a4-8063-4755-b574-58ec6a46af94	String	jsonType.label
53d45e01-c647-4f06-8608-52a596ec225c	false	single
53d45e01-c647-4f06-8608-52a596ec225c	Basic	attribute.nameformat
53d45e01-c647-4f06-8608-52a596ec225c	Role	attribute.name
332793c2-0e9e-4478-95b9-2f2ea665616e	true	introspection.token.claim
332793c2-0e9e-4478-95b9-2f2ea665616e	true	userinfo.token.claim
332793c2-0e9e-4478-95b9-2f2ea665616e	gender	user.attribute
332793c2-0e9e-4478-95b9-2f2ea665616e	true	id.token.claim
332793c2-0e9e-4478-95b9-2f2ea665616e	true	access.token.claim
332793c2-0e9e-4478-95b9-2f2ea665616e	gender	claim.name
332793c2-0e9e-4478-95b9-2f2ea665616e	String	jsonType.label
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	true	introspection.token.claim
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	true	userinfo.token.claim
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	updatedAt	user.attribute
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	true	id.token.claim
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	true	access.token.claim
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	updated_at	claim.name
3c9bce47-dddb-41ea-999d-fb7e57eb20d7	long	jsonType.label
4d4a99c9-b065-4713-a421-e1d3ad34aefd	true	introspection.token.claim
4d4a99c9-b065-4713-a421-e1d3ad34aefd	true	userinfo.token.claim
4d4a99c9-b065-4713-a421-e1d3ad34aefd	profile	user.attribute
4d4a99c9-b065-4713-a421-e1d3ad34aefd	true	id.token.claim
4d4a99c9-b065-4713-a421-e1d3ad34aefd	true	access.token.claim
4d4a99c9-b065-4713-a421-e1d3ad34aefd	profile	claim.name
4d4a99c9-b065-4713-a421-e1d3ad34aefd	String	jsonType.label
524c14a1-9cf4-46b5-afcb-0247cb2707b2	true	introspection.token.claim
524c14a1-9cf4-46b5-afcb-0247cb2707b2	true	userinfo.token.claim
524c14a1-9cf4-46b5-afcb-0247cb2707b2	middleName	user.attribute
524c14a1-9cf4-46b5-afcb-0247cb2707b2	true	id.token.claim
524c14a1-9cf4-46b5-afcb-0247cb2707b2	true	access.token.claim
524c14a1-9cf4-46b5-afcb-0247cb2707b2	middle_name	claim.name
524c14a1-9cf4-46b5-afcb-0247cb2707b2	String	jsonType.label
60491814-e2cf-4010-92cd-d810c1512d70	true	introspection.token.claim
60491814-e2cf-4010-92cd-d810c1512d70	true	userinfo.token.claim
60491814-e2cf-4010-92cd-d810c1512d70	picture	user.attribute
60491814-e2cf-4010-92cd-d810c1512d70	true	id.token.claim
60491814-e2cf-4010-92cd-d810c1512d70	true	access.token.claim
60491814-e2cf-4010-92cd-d810c1512d70	picture	claim.name
60491814-e2cf-4010-92cd-d810c1512d70	String	jsonType.label
61941942-7fde-4999-b91b-26bfe30e7d8a	true	introspection.token.claim
61941942-7fde-4999-b91b-26bfe30e7d8a	true	userinfo.token.claim
61941942-7fde-4999-b91b-26bfe30e7d8a	lastName	user.attribute
61941942-7fde-4999-b91b-26bfe30e7d8a	true	id.token.claim
61941942-7fde-4999-b91b-26bfe30e7d8a	true	access.token.claim
61941942-7fde-4999-b91b-26bfe30e7d8a	family_name	claim.name
61941942-7fde-4999-b91b-26bfe30e7d8a	String	jsonType.label
72e78387-af1e-461c-b01c-d4b4024b9889	true	introspection.token.claim
72e78387-af1e-461c-b01c-d4b4024b9889	true	userinfo.token.claim
72e78387-af1e-461c-b01c-d4b4024b9889	locale	user.attribute
72e78387-af1e-461c-b01c-d4b4024b9889	true	id.token.claim
72e78387-af1e-461c-b01c-d4b4024b9889	true	access.token.claim
72e78387-af1e-461c-b01c-d4b4024b9889	locale	claim.name
72e78387-af1e-461c-b01c-d4b4024b9889	String	jsonType.label
7891aa77-6eed-4dca-90f9-790d048bdb4f	true	introspection.token.claim
7891aa77-6eed-4dca-90f9-790d048bdb4f	true	userinfo.token.claim
7891aa77-6eed-4dca-90f9-790d048bdb4f	firstName	user.attribute
7891aa77-6eed-4dca-90f9-790d048bdb4f	true	id.token.claim
7891aa77-6eed-4dca-90f9-790d048bdb4f	true	access.token.claim
7891aa77-6eed-4dca-90f9-790d048bdb4f	given_name	claim.name
7891aa77-6eed-4dca-90f9-790d048bdb4f	String	jsonType.label
7e4c9c22-6c62-4895-a919-1df2ab60f452	true	introspection.token.claim
7e4c9c22-6c62-4895-a919-1df2ab60f452	true	userinfo.token.claim
7e4c9c22-6c62-4895-a919-1df2ab60f452	true	id.token.claim
7e4c9c22-6c62-4895-a919-1df2ab60f452	true	access.token.claim
9fd3c21b-68ff-4807-9e56-886e5cb9c805	true	introspection.token.claim
9fd3c21b-68ff-4807-9e56-886e5cb9c805	true	userinfo.token.claim
9fd3c21b-68ff-4807-9e56-886e5cb9c805	birthdate	user.attribute
9fd3c21b-68ff-4807-9e56-886e5cb9c805	true	id.token.claim
9fd3c21b-68ff-4807-9e56-886e5cb9c805	true	access.token.claim
9fd3c21b-68ff-4807-9e56-886e5cb9c805	birthdate	claim.name
9fd3c21b-68ff-4807-9e56-886e5cb9c805	String	jsonType.label
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	true	introspection.token.claim
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	true	userinfo.token.claim
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	username	user.attribute
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	true	id.token.claim
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	true	access.token.claim
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	preferred_username	claim.name
a4c3dafd-0eb2-4121-9e15-23cdfbdfcb12	String	jsonType.label
c80da40e-3bbd-41fa-94c4-786c38d2a050	true	introspection.token.claim
c80da40e-3bbd-41fa-94c4-786c38d2a050	true	userinfo.token.claim
c80da40e-3bbd-41fa-94c4-786c38d2a050	website	user.attribute
c80da40e-3bbd-41fa-94c4-786c38d2a050	true	id.token.claim
c80da40e-3bbd-41fa-94c4-786c38d2a050	true	access.token.claim
c80da40e-3bbd-41fa-94c4-786c38d2a050	website	claim.name
c80da40e-3bbd-41fa-94c4-786c38d2a050	String	jsonType.label
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	true	introspection.token.claim
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	true	userinfo.token.claim
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	nickname	user.attribute
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	true	id.token.claim
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	true	access.token.claim
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	nickname	claim.name
e1af8df6-fc51-4070-a094-a8f5d7fe0ccc	String	jsonType.label
f763915c-6f91-479f-b623-45cecafa736c	true	introspection.token.claim
f763915c-6f91-479f-b623-45cecafa736c	true	userinfo.token.claim
f763915c-6f91-479f-b623-45cecafa736c	zoneinfo	user.attribute
f763915c-6f91-479f-b623-45cecafa736c	true	id.token.claim
f763915c-6f91-479f-b623-45cecafa736c	true	access.token.claim
f763915c-6f91-479f-b623-45cecafa736c	zoneinfo	claim.name
f763915c-6f91-479f-b623-45cecafa736c	String	jsonType.label
772457a8-8884-4333-975d-cbc85320f9e4	true	introspection.token.claim
772457a8-8884-4333-975d-cbc85320f9e4	true	userinfo.token.claim
772457a8-8884-4333-975d-cbc85320f9e4	emailVerified	user.attribute
772457a8-8884-4333-975d-cbc85320f9e4	true	id.token.claim
772457a8-8884-4333-975d-cbc85320f9e4	true	access.token.claim
772457a8-8884-4333-975d-cbc85320f9e4	email_verified	claim.name
772457a8-8884-4333-975d-cbc85320f9e4	boolean	jsonType.label
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	true	introspection.token.claim
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	true	userinfo.token.claim
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	email	user.attribute
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	true	id.token.claim
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	true	access.token.claim
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	email	claim.name
8ed3b280-f2a1-4eba-836f-6a8f468b35ad	String	jsonType.label
342a3e70-1d12-4587-863a-f183b959b961	formatted	user.attribute.formatted
342a3e70-1d12-4587-863a-f183b959b961	country	user.attribute.country
342a3e70-1d12-4587-863a-f183b959b961	true	introspection.token.claim
342a3e70-1d12-4587-863a-f183b959b961	postal_code	user.attribute.postal_code
342a3e70-1d12-4587-863a-f183b959b961	true	userinfo.token.claim
342a3e70-1d12-4587-863a-f183b959b961	street	user.attribute.street
342a3e70-1d12-4587-863a-f183b959b961	true	id.token.claim
342a3e70-1d12-4587-863a-f183b959b961	region	user.attribute.region
342a3e70-1d12-4587-863a-f183b959b961	true	access.token.claim
342a3e70-1d12-4587-863a-f183b959b961	locality	user.attribute.locality
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	true	introspection.token.claim
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	true	userinfo.token.claim
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	phoneNumberVerified	user.attribute
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	true	id.token.claim
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	true	access.token.claim
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	phone_number_verified	claim.name
a3bdf4c1-aa59-4f14-9d9d-dfadc28a92a7	boolean	jsonType.label
f595e9f1-468c-48d8-b65a-f55002326542	true	introspection.token.claim
f595e9f1-468c-48d8-b65a-f55002326542	true	userinfo.token.claim
f595e9f1-468c-48d8-b65a-f55002326542	phoneNumber	user.attribute
f595e9f1-468c-48d8-b65a-f55002326542	true	id.token.claim
f595e9f1-468c-48d8-b65a-f55002326542	true	access.token.claim
f595e9f1-468c-48d8-b65a-f55002326542	phone_number	claim.name
f595e9f1-468c-48d8-b65a-f55002326542	String	jsonType.label
4ee672ed-4321-499f-8dd8-02c57d39c8ea	true	introspection.token.claim
4ee672ed-4321-499f-8dd8-02c57d39c8ea	true	multivalued
4ee672ed-4321-499f-8dd8-02c57d39c8ea	foo	user.attribute
4ee672ed-4321-499f-8dd8-02c57d39c8ea	true	access.token.claim
4ee672ed-4321-499f-8dd8-02c57d39c8ea	realm_access.roles	claim.name
4ee672ed-4321-499f-8dd8-02c57d39c8ea	String	jsonType.label
b8022b3d-838b-42cd-9a4b-e7e927360d76	true	introspection.token.claim
b8022b3d-838b-42cd-9a4b-e7e927360d76	true	access.token.claim
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	true	introspection.token.claim
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	true	multivalued
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	foo	user.attribute
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	true	access.token.claim
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	resource_access.${client_id}.roles	claim.name
ca80433f-c3ec-4eb9-8d85-9e9c54ac21f1	String	jsonType.label
fb3b0899-55b5-4403-a03c-cf353ef1a81c	true	introspection.token.claim
fb3b0899-55b5-4403-a03c-cf353ef1a81c	true	access.token.claim
a4e7c086-268b-4784-88f8-e96799619837	true	introspection.token.claim
a4e7c086-268b-4784-88f8-e96799619837	true	userinfo.token.claim
a4e7c086-268b-4784-88f8-e96799619837	username	user.attribute
a4e7c086-268b-4784-88f8-e96799619837	true	id.token.claim
a4e7c086-268b-4784-88f8-e96799619837	true	access.token.claim
a4e7c086-268b-4784-88f8-e96799619837	upn	claim.name
a4e7c086-268b-4784-88f8-e96799619837	String	jsonType.label
b22b27d9-5480-43a9-8abd-5af2f2168b1d	true	introspection.token.claim
b22b27d9-5480-43a9-8abd-5af2f2168b1d	true	multivalued
b22b27d9-5480-43a9-8abd-5af2f2168b1d	foo	user.attribute
b22b27d9-5480-43a9-8abd-5af2f2168b1d	true	id.token.claim
b22b27d9-5480-43a9-8abd-5af2f2168b1d	true	access.token.claim
b22b27d9-5480-43a9-8abd-5af2f2168b1d	groups	claim.name
b22b27d9-5480-43a9-8abd-5af2f2168b1d	String	jsonType.label
b3eb2a30-5c21-43e7-9671-a1e5d02ff515	true	introspection.token.claim
b3eb2a30-5c21-43e7-9671-a1e5d02ff515	true	id.token.claim
b3eb2a30-5c21-43e7-9671-a1e5d02ff515	true	access.token.claim
037625c5-4947-4a81-9381-e12d5f055a2e	AUTH_TIME	user.session.note
037625c5-4947-4a81-9381-e12d5f055a2e	true	introspection.token.claim
037625c5-4947-4a81-9381-e12d5f055a2e	true	id.token.claim
037625c5-4947-4a81-9381-e12d5f055a2e	true	access.token.claim
037625c5-4947-4a81-9381-e12d5f055a2e	auth_time	claim.name
037625c5-4947-4a81-9381-e12d5f055a2e	long	jsonType.label
83fecc2e-3f53-46ac-b892-54059e03fe45	true	introspection.token.claim
83fecc2e-3f53-46ac-b892-54059e03fe45	true	access.token.claim
ab9249f3-9505-418a-9085-19f498a063a0	true	introspection.token.claim
ab9249f3-9505-418a-9085-19f498a063a0	true	multivalued
ab9249f3-9505-418a-9085-19f498a063a0	true	id.token.claim
ab9249f3-9505-418a-9085-19f498a063a0	true	access.token.claim
ab9249f3-9505-418a-9085-19f498a063a0	organization	claim.name
ab9249f3-9505-418a-9085-19f498a063a0	String	jsonType.label
18505d25-c376-40c1-a20c-055290fb70c5	true	introspection.token.claim
18505d25-c376-40c1-a20c-055290fb70c5	true	userinfo.token.claim
18505d25-c376-40c1-a20c-055290fb70c5	locale	user.attribute
18505d25-c376-40c1-a20c-055290fb70c5	true	id.token.claim
18505d25-c376-40c1-a20c-055290fb70c5	true	access.token.claim
18505d25-c376-40c1-a20c-055290fb70c5	locale	claim.name
18505d25-c376-40c1-a20c-055290fb70c5	String	jsonType.label
\.


--
-- TOC entry 3894 (class 0 OID 18358)
-- Dependencies: 249
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
bf3cd271-f79f-489d-a33a-e1aeca2849af	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	be3f8dd2-4e37-4c5f-9e78-d249a0216110	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e48179f0-8957-479e-9d9a-fbb86745f579	36bd0b42-6171-4a84-a019-f308e618d6d1	0fe48bc9-79fb-4f47-b123-69eb12ded4cc	2cf981d1-aa18-4ab4-8fb1-7e3278232253	dc634955-6e64-44e1-96ec-ab22505298dc	2592000	f	900	t	f	3ed1f255-8df3-455e-8097-d0186d2ce6f4	0	f	0	0	082b3aa4-4a07-4c14-8002-168ef58ad8ca
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	60	300	300	\N	\N	\N	t	f	0	\N	proposal-management	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	bd2903a0-56b6-44ae-afd9-c6e9558afd40	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	17a62cd8-7e35-4d7a-9907-cdc530d8557b	a65ec2c7-5b40-417a-900c-e9fdc971f0f8	d7b3d4f3-f7fa-4224-a252-a621894904c4	ea8cd307-0a99-41bb-8977-58090aa8a001	24cd17e5-ec8f-4f77-b552-292316a8707b	2592000	f	900	t	f	9ed044f7-b221-490c-aabf-30206d3d0560	0	f	0	0	e1a9ef4a-c7fa-44f7-b0aa-d5470c1c447f
\.


--
-- TOC entry 3895 (class 0 OID 18392)
-- Dependencies: 250
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	bf3cd271-f79f-489d-a33a-e1aeca2849af	
_browser_header.xContentTypeOptions	bf3cd271-f79f-489d-a33a-e1aeca2849af	nosniff
_browser_header.referrerPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	no-referrer
_browser_header.xRobotsTag	bf3cd271-f79f-489d-a33a-e1aeca2849af	none
_browser_header.xFrameOptions	bf3cd271-f79f-489d-a33a-e1aeca2849af	SAMEORIGIN
_browser_header.contentSecurityPolicy	bf3cd271-f79f-489d-a33a-e1aeca2849af	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	bf3cd271-f79f-489d-a33a-e1aeca2849af	1; mode=block
_browser_header.strictTransportSecurity	bf3cd271-f79f-489d-a33a-e1aeca2849af	max-age=31536000; includeSubDomains
bruteForceProtected	bf3cd271-f79f-489d-a33a-e1aeca2849af	false
permanentLockout	bf3cd271-f79f-489d-a33a-e1aeca2849af	false
maxTemporaryLockouts	bf3cd271-f79f-489d-a33a-e1aeca2849af	0
maxFailureWaitSeconds	bf3cd271-f79f-489d-a33a-e1aeca2849af	900
minimumQuickLoginWaitSeconds	bf3cd271-f79f-489d-a33a-e1aeca2849af	60
waitIncrementSeconds	bf3cd271-f79f-489d-a33a-e1aeca2849af	60
quickLoginCheckMilliSeconds	bf3cd271-f79f-489d-a33a-e1aeca2849af	1000
maxDeltaTimeSeconds	bf3cd271-f79f-489d-a33a-e1aeca2849af	43200
failureFactor	bf3cd271-f79f-489d-a33a-e1aeca2849af	30
realmReusableOtpCode	bf3cd271-f79f-489d-a33a-e1aeca2849af	false
firstBrokerLoginFlowId	bf3cd271-f79f-489d-a33a-e1aeca2849af	c0629136-b1a6-4f81-9a72-8edff1213c42
displayName	bf3cd271-f79f-489d-a33a-e1aeca2849af	Keycloak
displayNameHtml	bf3cd271-f79f-489d-a33a-e1aeca2849af	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	bf3cd271-f79f-489d-a33a-e1aeca2849af	RS256
offlineSessionMaxLifespanEnabled	bf3cd271-f79f-489d-a33a-e1aeca2849af	false
offlineSessionMaxLifespan	bf3cd271-f79f-489d-a33a-e1aeca2849af	5184000
_browser_header.contentSecurityPolicyReportOnly	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	
_browser_header.xContentTypeOptions	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	nosniff
_browser_header.referrerPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	no-referrer
_browser_header.xRobotsTag	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	none
_browser_header.xFrameOptions	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	SAMEORIGIN
_browser_header.contentSecurityPolicy	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	1; mode=block
_browser_header.strictTransportSecurity	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	max-age=31536000; includeSubDomains
bruteForceProtected	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	false
permanentLockout	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	false
maxTemporaryLockouts	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	0
maxFailureWaitSeconds	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	900
minimumQuickLoginWaitSeconds	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	60
waitIncrementSeconds	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	60
quickLoginCheckMilliSeconds	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	1000
maxDeltaTimeSeconds	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	43200
failureFactor	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	30
realmReusableOtpCode	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	false
defaultSignatureAlgorithm	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	RS256
offlineSessionMaxLifespanEnabled	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	false
offlineSessionMaxLifespan	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	5184000
actionTokenGeneratedByAdminLifespan	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	43200
actionTokenGeneratedByUserLifespan	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	300
oauth2DeviceCodeLifespan	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	600
oauth2DevicePollingInterval	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	5
webAuthnPolicyRpEntityName	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	keycloak
webAuthnPolicySignatureAlgorithms	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	ES256,RS256
webAuthnPolicyRpId	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	
webAuthnPolicyAttestationConveyancePreference	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyAuthenticatorAttachment	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyRequireResidentKey	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyUserVerificationRequirement	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyCreateTimeout	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	0
webAuthnPolicyAvoidSameAuthenticatorRegister	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	false
webAuthnPolicyRpEntityNamePasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	ES256,RS256
webAuthnPolicyRpIdPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	
webAuthnPolicyAttestationConveyancePreferencePasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyRequireResidentKeyPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	not specified
webAuthnPolicyCreateTimeoutPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	false
cibaBackchannelTokenDeliveryMode	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	poll
cibaExpiresIn	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	120
cibaInterval	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	5
cibaAuthRequestedUserHint	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	login_hint
parRequestUriLifespan	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	60
firstBrokerLoginFlowId	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	fbcdeb53-6213-445f-9e81-8ba5c3255827
\.


--
-- TOC entry 3896 (class 0 OID 18398)
-- Dependencies: 251
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 3897 (class 0 OID 18401)
-- Dependencies: 252
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- TOC entry 3898 (class 0 OID 18404)
-- Dependencies: 253
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
bf3cd271-f79f-489d-a33a-e1aeca2849af	jboss-logging
9ca9b3d8-7910-4305-b1de-cc6d98ebf981	jboss-logging
\.


--
-- TOC entry 3899 (class 0 OID 18407)
-- Dependencies: 254
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 3900 (class 0 OID 18413)
-- Dependencies: 255
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	bf3cd271-f79f-489d-a33a-e1aeca2849af
password	password	t	t	9ca9b3d8-7910-4305-b1de-cc6d98ebf981
\.


--
-- TOC entry 3901 (class 0 OID 18421)
-- Dependencies: 256
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- TOC entry 3902 (class 0 OID 18427)
-- Dependencies: 257
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 3903 (class 0 OID 18430)
-- Dependencies: 258
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
78a22c7d-95c7-4b5f-b0e6-19c30bdc50dc	/realms/master/account/*
a9df6a75-0443-4041-97b5-1016a7d512fb	/realms/master/account/*
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	/admin/master/console/*
dbf4bcf0-60b6-4aec-af0f-14a975689023	/realms/proposal-management/account/*
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	/realms/proposal-management/account/*
fc9cf51f-87d1-4020-b812-9a127e479ccd	/admin/proposal-management/console/*
84da2b2c-e7d5-4b35-9982-218c0f159e0b	/*
\.


--
-- TOC entry 3904 (class 0 OID 18433)
-- Dependencies: 259
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 3905 (class 0 OID 18439)
-- Dependencies: 260
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
9eb464ba-2962-4ced-b470-05a165d9015d	VERIFY_EMAIL	Verify Email	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	VERIFY_EMAIL	50
1cdd31ba-a2e4-4731-9f1a-5186a01a3dd4	UPDATE_PROFILE	Update Profile	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	UPDATE_PROFILE	40
0847fc62-ea56-4e81-adf1-40b464499ec6	CONFIGURE_TOTP	Configure OTP	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	CONFIGURE_TOTP	10
f896c6c2-65e2-4431-8ee4-580c22110fa8	UPDATE_PASSWORD	Update Password	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	UPDATE_PASSWORD	30
eee7a998-2c17-4d13-ac37-7760a938229b	TERMS_AND_CONDITIONS	Terms and Conditions	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	f	TERMS_AND_CONDITIONS	20
308d7163-d08b-4067-ba1b-eb94e84d19e1	delete_account	Delete Account	bf3cd271-f79f-489d-a33a-e1aeca2849af	f	f	delete_account	60
3b850bbb-8b15-43d5-ba0c-d6df0450907c	delete_credential	Delete Credential	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	delete_credential	100
136fb699-3f7e-43c5-b449-5c1957497ae7	update_user_locale	Update User Locale	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	update_user_locale	1000
a1d18def-8a52-4391-b4c3-78c6c5c5b8ab	webauthn-register	Webauthn Register	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	webauthn-register	70
dde1e8bf-f5be-4c7b-877d-5efb0af5942c	webauthn-register-passwordless	Webauthn Register Passwordless	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	webauthn-register-passwordless	80
ecc17c4d-5b92-443d-b6e3-1919b1f364d5	VERIFY_PROFILE	Verify Profile	bf3cd271-f79f-489d-a33a-e1aeca2849af	t	f	VERIFY_PROFILE	90
40bc6e7d-5dea-45dd-8652-51e4d01c3060	VERIFY_EMAIL	Verify Email	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	VERIFY_EMAIL	50
add52b64-ef55-4c5a-a952-8a2f86e4768a	UPDATE_PROFILE	Update Profile	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	UPDATE_PROFILE	40
ab719608-fe90-4186-b05f-dab019d1fcbc	CONFIGURE_TOTP	Configure OTP	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	CONFIGURE_TOTP	10
40532a97-4f99-4613-9feb-282629fd876f	UPDATE_PASSWORD	Update Password	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	UPDATE_PASSWORD	30
bb404e2a-a6fd-4d6e-9151-6bf4e101316c	TERMS_AND_CONDITIONS	Terms and Conditions	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f	f	TERMS_AND_CONDITIONS	20
a4548d43-0120-4d98-912b-8e743096096d	delete_account	Delete Account	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	f	f	delete_account	60
d10dd634-143a-47d8-b8ab-097e523c0874	delete_credential	Delete Credential	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	delete_credential	100
a73e8e65-623b-4744-ba74-4e51e3b7997f	update_user_locale	Update User Locale	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	update_user_locale	1000
53a24563-8ea7-4363-bece-1fd12718283e	webauthn-register	Webauthn Register	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	webauthn-register	70
3dbdf90a-5ef2-49fc-a384-8c8f5428d3cd	webauthn-register-passwordless	Webauthn Register Passwordless	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	webauthn-register-passwordless	80
e6e7f7db-4bd1-405f-8916-84995058bd8d	VERIFY_PROFILE	Verify Profile	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	t	f	VERIFY_PROFILE	90
\.


--
-- TOC entry 3906 (class 0 OID 18447)
-- Dependencies: 261
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 3907 (class 0 OID 18454)
-- Dependencies: 262
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3908 (class 0 OID 18457)
-- Dependencies: 263
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3909 (class 0 OID 18460)
-- Dependencies: 264
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- TOC entry 3910 (class 0 OID 18465)
-- Dependencies: 265
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3911 (class 0 OID 18471)
-- Dependencies: 266
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 3912 (class 0 OID 18477)
-- Dependencies: 267
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 3913 (class 0 OID 18484)
-- Dependencies: 268
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 3914 (class 0 OID 18490)
-- Dependencies: 269
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 3915 (class 0 OID 18493)
-- Dependencies: 270
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- TOC entry 3916 (class 0 OID 18496)
-- Dependencies: 271
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 3917 (class 0 OID 18502)
-- Dependencies: 272
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
a9df6a75-0443-4041-97b5-1016a7d512fb	18a467e5-7c41-4c4f-9033-0cd02f04eece
a9df6a75-0443-4041-97b5-1016a7d512fb	261f9ec2-0978-41e1-94ca-ac33f5f2258b
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	38d448cf-3e76-4804-9c37-b333e542f44a
e4ccd477-dbcc-4967-a9fc-5d9de7da3386	dd86b0e6-16e6-4666-8041-635a99500c14
\.


--
-- TOC entry 3918 (class 0 OID 18505)
-- Dependencies: 273
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3919 (class 0 OID 18508)
-- Dependencies: 274
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	5c48c26b-6882-4d15-81cb-cca156d198e5	5a611da9-1fe5-4361-8ef0-5356816d9ffd	\N	\N	\N
\.


--
-- TOC entry 3920 (class 0 OID 18515)
-- Dependencies: 275
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3921 (class 0 OID 18521)
-- Dependencies: 276
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3922 (class 0 OID 18524)
-- Dependencies: 277
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
5c48c26b-6882-4d15-81cb-cca156d198e5	\N	08cf55d4-e815-4bff-948e-7c2411fbaf57	f	t	\N	\N	\N	bf3cd271-f79f-489d-a33a-e1aeca2849af	admin	1735264978177	\N	0
81e1abc6-74a4-45e6-b690-0504b1ef071d	userdefault@gmail.com	userdefault@gmail.com	t	t	\N	user	default	9ca9b3d8-7910-4305-b1de-cc6d98ebf981	user-default	1735265603938	\N	0
\.


--
-- TOC entry 3923 (class 0 OID 18533)
-- Dependencies: 278
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 3924 (class 0 OID 18539)
-- Dependencies: 279
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 3925 (class 0 OID 18545)
-- Dependencies: 280
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 3926 (class 0 OID 18551)
-- Dependencies: 281
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 3927 (class 0 OID 18557)
-- Dependencies: 282
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- TOC entry 3928 (class 0 OID 18560)
-- Dependencies: 283
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 3929 (class 0 OID 18564)
-- Dependencies: 284
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
082b3aa4-4a07-4c14-8002-168ef58ad8ca	5c48c26b-6882-4d15-81cb-cca156d198e5
b4debcf6-d58c-46fb-9b9c-a09722443bc3	5c48c26b-6882-4d15-81cb-cca156d198e5
91d15d0e-c0fd-441f-badb-28a96937dae2	81e1abc6-74a4-45e6-b690-0504b1ef071d
\.


--
-- TOC entry 3930 (class 0 OID 18567)
-- Dependencies: 285
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 3931 (class 0 OID 18573)
-- Dependencies: 286
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
8fd24b9b-98f6-4f4f-9705-53f47b2bfe23	+
fc9cf51f-87d1-4020-b812-9a127e479ccd	+
84da2b2c-e7d5-4b35-9982-218c0f159e0b	/*
\.


--
-- TOC entry 3644 (class 2606 OID 18577)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3507 (class 2606 OID 18579)
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- TOC entry 3499 (class 2606 OID 18581)
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 18583)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3378 (class 2606 OID 18585)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3393 (class 2606 OID 18587)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3380 (class 2606 OID 18589)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3526 (class 2606 OID 18591)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3368 (class 2606 OID 18593)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3405 (class 2606 OID 18595)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3401 (class 2606 OID 18597)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3444 (class 2606 OID 18599)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3424 (class 2606 OID 18601)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3429 (class 2606 OID 18603)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3436 (class 2606 OID 18605)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3440 (class 2606 OID 18607)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3448 (class 2606 OID 18609)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3456 (class 2606 OID 18611)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3528 (class 2606 OID 18613)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3531 (class 2606 OID 18615)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3534 (class 2606 OID 18617)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3543 (class 2606 OID 18619)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3465 (class 2606 OID 18621)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3375 (class 2606 OID 18623)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3421 (class 2606 OID 18625)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3452 (class 2606 OID 18627)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3518 (class 2606 OID 18629)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3632 (class 2606 OID 18631)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 18633)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3593 (class 2606 OID 18635)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3383 (class 2606 OID 18637)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3523 (class 2606 OID 18639)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3539 (class 2606 OID 18641)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3485 (class 2606 OID 18643)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 18645)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3366 (class 2606 OID 18647)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3356 (class 2606 OID 18649)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 18651)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3363 (class 2606 OID 18653)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3641 (class 2606 OID 18655)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3408 (class 2606 OID 18657)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3472 (class 2606 OID 18659)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3510 (class 2606 OID 18661)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3541 (class 2606 OID 18663)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3412 (class 2606 OID 18665)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3624 (class 2606 OID 18667)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3564 (class 2606 OID 18669)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2606 OID 18671)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3570 (class 2606 OID 18673)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3353 (class 2606 OID 18675)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3556 (class 2606 OID 18677)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3580 (class 2606 OID 18679)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3559 (class 2606 OID 18681)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3596 (class 2606 OID 18683)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3616 (class 2606 OID 18685)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3630 (class 2606 OID 18687)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3626 (class 2606 OID 18689)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3434 (class 2606 OID 18691)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3612 (class 2606 OID 18693)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3605 (class 2606 OID 18695)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3479 (class 2606 OID 18697)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 18699)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3462 (class 2606 OID 18701)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3474 (class 2606 OID 18703)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3477 (class 2606 OID 18705)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3489 (class 2606 OID 18707)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3492 (class 2606 OID 18709)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3494 (class 2606 OID 18711)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3512 (class 2606 OID 18713)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3516 (class 2606 OID 18715)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3546 (class 2606 OID 18717)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3549 (class 2606 OID 18719)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3551 (class 2606 OID 18721)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3638 (class 2606 OID 18723)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3585 (class 2606 OID 18725)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3590 (class 2606 OID 18727)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 18729)
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- TOC entry 3599 (class 2606 OID 18731)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3635 (class 2606 OID 18733)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3646 (class 2606 OID 18735)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3415 (class 2606 OID 18737)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3391 (class 2606 OID 18739)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3386 (class 2606 OID 18741)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3562 (class 2606 OID 18743)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3399 (class 2606 OID 18745)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3419 (class 2606 OID 18747)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3537 (class 2606 OID 18749)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3554 (class 2606 OID 18751)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3481 (class 2606 OID 18753)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3470 (class 2606 OID 18755)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3373 (class 2606 OID 18757)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3388 (class 2606 OID 18759)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3620 (class 2606 OID 18761)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3608 (class 2606 OID 18763)
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3578 (class 2606 OID 18765)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3568 (class 2606 OID 18767)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3573 (class 2606 OID 18769)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3583 (class 2606 OID 18771)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3610 (class 2606 OID 18773)
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- TOC entry 3501 (class 2606 OID 18775)
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- TOC entry 3503 (class 2606 OID 18777)
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- TOC entry 3505 (class 2606 OID 18779)
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- TOC entry 3521 (class 2606 OID 18781)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3622 (class 2606 OID 18783)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3425 (class 1259 OID 18784)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3426 (class 1259 OID 18785)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3351 (class 1259 OID 18786)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3354 (class 1259 OID 18787)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3364 (class 1259 OID 18788)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3357 (class 1259 OID 18789)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3358 (class 1259 OID 18790)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3361 (class 1259 OID 18791)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3394 (class 1259 OID 18792)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3376 (class 1259 OID 18793)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 3371 (class 1259 OID 18794)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3381 (class 1259 OID 18795)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3389 (class 1259 OID 18796)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3395 (class 1259 OID 18797)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3513 (class 1259 OID 18798)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3396 (class 1259 OID 18799)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3406 (class 1259 OID 18800)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3402 (class 1259 OID 18801)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3403 (class 1259 OID 18802)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3409 (class 1259 OID 18803)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3410 (class 1259 OID 18804)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3416 (class 1259 OID 18805)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3417 (class 1259 OID 18806)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3422 (class 1259 OID 18807)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3453 (class 1259 OID 18808)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3454 (class 1259 OID 18809)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3427 (class 1259 OID 18810)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3430 (class 1259 OID 18811)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3431 (class 1259 OID 18812)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3432 (class 1259 OID 18813)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3437 (class 1259 OID 18814)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3438 (class 1259 OID 18815)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3441 (class 1259 OID 18816)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3442 (class 1259 OID 18817)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3445 (class 1259 OID 18818)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3446 (class 1259 OID 18819)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3449 (class 1259 OID 18820)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3450 (class 1259 OID 18821)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3459 (class 1259 OID 18822)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3460 (class 1259 OID 18823)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3463 (class 1259 OID 18824)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3475 (class 1259 OID 18825)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3466 (class 1259 OID 18826)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3467 (class 1259 OID 18827)
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- TOC entry 3468 (class 1259 OID 18828)
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- TOC entry 3486 (class 1259 OID 18829)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3487 (class 1259 OID 18830)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3495 (class 1259 OID 18831)
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- TOC entry 3496 (class 1259 OID 18832)
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- TOC entry 3497 (class 1259 OID 18833)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3508 (class 1259 OID 18834)
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- TOC entry 3565 (class 1259 OID 18835)
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- TOC entry 3566 (class 1259 OID 18836)
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- TOC entry 3514 (class 1259 OID 18837)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3524 (class 1259 OID 18838)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3384 (class 1259 OID 18839)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3529 (class 1259 OID 18840)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3535 (class 1259 OID 18841)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3532 (class 1259 OID 18842)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3519 (class 1259 OID 18843)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3544 (class 1259 OID 18844)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3547 (class 1259 OID 18845)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3552 (class 1259 OID 18846)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3557 (class 1259 OID 18847)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3560 (class 1259 OID 18848)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3571 (class 1259 OID 18849)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3576 (class 1259 OID 18850)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3581 (class 1259 OID 18851)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3588 (class 1259 OID 18852)
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- TOC entry 3591 (class 1259 OID 18853)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3397 (class 1259 OID 18854)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3594 (class 1259 OID 18855)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3597 (class 1259 OID 18856)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3490 (class 1259 OID 18857)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3613 (class 1259 OID 18858)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3614 (class 1259 OID 18859)
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- TOC entry 3600 (class 1259 OID 18860)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3601 (class 1259 OID 18861)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3606 (class 1259 OID 18862)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3413 (class 1259 OID 18863)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3617 (class 1259 OID 18864)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3636 (class 1259 OID 18865)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3639 (class 1259 OID 18866)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3642 (class 1259 OID 18867)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3618 (class 1259 OID 18868)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3627 (class 1259 OID 18869)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3628 (class 1259 OID 18870)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3633 (class 1259 OID 18871)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3647 (class 1259 OID 18872)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3602 (class 1259 OID 18873)
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3603 (class 1259 OID 18874)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3668 (class 2606 OID 18875)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3654 (class 2606 OID 18880)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3665 (class 2606 OID 18885)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3656 (class 2606 OID 18890)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3684 (class 2606 OID 18895)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3710 (class 2606 OID 18900)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3681 (class 2606 OID 18905)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3686 (class 2606 OID 18910)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3703 (class 2606 OID 18915)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3712 (class 2606 OID 18920)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3672 (class 2606 OID 18925)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3682 (class 2606 OID 18930)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3677 (class 2606 OID 18935)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3661 (class 2606 OID 18940)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3650 (class 2606 OID 18945)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3651 (class 2606 OID 18950)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3652 (class 2606 OID 18955)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3653 (class 2606 OID 18960)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3713 (class 2606 OID 18965)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3657 (class 2606 OID 18970)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3658 (class 2606 OID 18975)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3674 (class 2606 OID 18980)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3655 (class 2606 OID 18985)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3660 (class 2606 OID 18990)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3659 (class 2606 OID 18995)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3678 (class 2606 OID 19000)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3709 (class 2606 OID 19005)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3707 (class 2606 OID 19010)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3708 (class 2606 OID 19015)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3648 (class 2606 OID 19020)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3701 (class 2606 OID 19025)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3691 (class 2606 OID 19030)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3696 (class 2606 OID 19035)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3692 (class 2606 OID 19040)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3693 (class 2606 OID 19045)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3649 (class 2606 OID 19050)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3702 (class 2606 OID 19055)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3694 (class 2606 OID 19060)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3695 (class 2606 OID 19065)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3689 (class 2606 OID 19070)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3687 (class 2606 OID 19075)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3688 (class 2606 OID 19080)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3690 (class 2606 OID 19085)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3697 (class 2606 OID 19090)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3662 (class 2606 OID 19095)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3705 (class 2606 OID 19100)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3704 (class 2606 OID 19105)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3666 (class 2606 OID 19110)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3667 (class 2606 OID 19115)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3679 (class 2606 OID 19120)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3680 (class 2606 OID 19125)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3670 (class 2606 OID 19130)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3671 (class 2606 OID 19135)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3714 (class 2606 OID 19140)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3700 (class 2606 OID 19145)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3675 (class 2606 OID 19150)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3663 (class 2606 OID 19155)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3676 (class 2606 OID 19160)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3664 (class 2606 OID 19165)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3685 (class 2606 OID 19170)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3698 (class 2606 OID 19175)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3699 (class 2606 OID 19180)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3683 (class 2606 OID 19185)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3706 (class 2606 OID 19190)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3711 (class 2606 OID 19195)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3673 (class 2606 OID 19200)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3669 (class 2606 OID 19205)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2024-12-26 23:16:57 -03

--
-- PostgreSQL database dump complete
--