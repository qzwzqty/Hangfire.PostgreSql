SET search_path = 'hangfire';
--
-- Table structure for table `Schema`
--

DO
$$
BEGIN
    IF EXISTS (SELECT 1 FROM "schema" WHERE "version"::integer >= 4) THEN
        RAISE EXCEPTION 'version-already-applied';
    END IF;
END
$$;

ALTER TABLE "[tablesPrefix]counter" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]lock" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]hash" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]job" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]jobparameter" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]jobqueue" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]list" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]server" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]set" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
ALTER TABLE "[tablesPrefix]state" ADD COLUMN "updatecount" integer NOT NULL DEFAULT 0;
