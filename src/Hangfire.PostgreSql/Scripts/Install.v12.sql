SET search_path = 'hangfire';



DO
$$
BEGIN
  IF EXISTS (SELECT 1 FROM "schema" WHERE "version"::integer >= 12) THEN
    RAISE EXCEPTION 'version-already-applied';
  END IF;
END
$$;

ALTER TABLE "[tablesPrefix]counter" ALTER COLUMN "key" TYPE TEXT;
ALTER TABLE "[tablesPrefix]hash" ALTER COLUMN "key" TYPE TEXT;
ALTER TABLE "[tablesPrefix]hash" ALTER COLUMN field TYPE TEXT;
ALTER TABLE "[tablesPrefix]job" ALTER COLUMN statename TYPE TEXT;
ALTER TABLE "[tablesPrefix]list" ALTER COLUMN "key" TYPE TEXT;
ALTER TABLE "[tablesPrefix]server" ALTER COLUMN id TYPE TEXT;
ALTER TABLE "[tablesPrefix]set" ALTER COLUMN "key" TYPE TEXT;
ALTER TABLE "[tablesPrefix]jobparameter" ALTER COLUMN "name" TYPE TEXT;
ALTER TABLE "[tablesPrefix]state" ALTER COLUMN "name" TYPE TEXT;
ALTER TABLE "[tablesPrefix]state" ALTER COLUMN reason TYPE TEXT;
