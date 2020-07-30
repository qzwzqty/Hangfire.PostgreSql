SET search_path = 'hangfire';



DO
$$
BEGIN
  IF EXISTS (SELECT 1 FROM "schema" WHERE "version"::integer >= 11) THEN
    RAISE EXCEPTION 'version-already-applied';
  END IF;
END
$$;

ALTER TABLE "[tablesPrefix]counter" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]hash" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]job" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]job" ALTER COLUMN stateid TYPE BIGINT;
ALTER TABLE "[tablesPrefix]state" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]state" ALTER COLUMN jobid TYPE BIGINT;
ALTER TABLE "[tablesPrefix]jobparameter" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]jobparameter" ALTER COLUMN jobid TYPE BIGINT;
ALTER TABLE "[tablesPrefix]jobqueue" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]jobqueue" ALTER COLUMN jobid TYPE BIGINT;
ALTER TABLE "[tablesPrefix]list" ALTER COLUMN id TYPE BIGINT;
ALTER TABLE "[tablesPrefix]set" ALTER COLUMN id TYPE BIGINT;
