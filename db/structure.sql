CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "entries" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "feed_id" integer NOT NULL, "title" varchar NOT NULL, "url" text NOT NULL, "guid" varchar NOT NULL, "author" varchar, "content" text, "published_at" datetime NOT NULL, "read" boolean DEFAULT 0 NOT NULL, "starred" boolean DEFAULT 0 NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_entries_on_feed_id_and_guid" ON "entries" ("feed_id", "guid");
CREATE TABLE IF NOT EXISTS "feeds" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar NOT NULL, "url" varchar NOT NULL, "sanitize" boolean DEFAULT 1 NOT NULL, "last_checked" datetime, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "entry_count_in_fetch" integer DEFAULT 0 NOT NULL, "remove_tracking_params" boolean DEFAULT 1 NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "password_digest" varchar NOT NULL, "token" varchar NOT NULL);
CREATE VIRTUAL TABLE entry_searches USING fts5(title, content, entry_id)
/* entry_searches(title,content,entry_id) */;
CREATE TABLE IF NOT EXISTS 'entry_searches_data'(id INTEGER PRIMARY KEY, block BLOB);
CREATE TABLE IF NOT EXISTS 'entry_searches_idx'(segid, term, pgno, PRIMARY KEY(segid, term)) WITHOUT ROWID;
CREATE TABLE IF NOT EXISTS 'entry_searches_content'(id INTEGER PRIMARY KEY, c0, c1, c2);
CREATE TABLE IF NOT EXISTS 'entry_searches_docsize'(id INTEGER PRIMARY KEY, sz BLOB);
CREATE TABLE IF NOT EXISTS 'entry_searches_config'(k PRIMARY KEY, v) WITHOUT ROWID;
INSERT INTO "schema_migrations" (version) VALUES
('20240716234734'),
('20240223231759'),
('20240204175948');

