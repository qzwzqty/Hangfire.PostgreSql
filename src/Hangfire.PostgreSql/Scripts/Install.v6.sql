SET search_path = 'hangfire';
--
-- Adds indices, greatly speeds-up deleting old jobs.
--

DO
$$
BEGIN
    IF EXISTS (SELECT 1 FROM "schema" WHERE "version"::integer >= 6) THEN
        RAISE EXCEPTION 'version-already-applied';
    END IF;
END
$$;


DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_[tablesPrefix]counter_expireat" ON "[tablesPrefix]counter" ("expireat");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX ix_hangfire_[tablesPrefix]counter_expireat already exists.';
    END;
END;
$$;

DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_[tablesPrefix]jobqueue_jobidandqueue" ON "[tablesPrefix]jobqueue" ("jobid","queue");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX "ix_hangfire_[tablesPrefix]jobqueue_jobidandqueue" already exists.';
    END;
END;
$$;

