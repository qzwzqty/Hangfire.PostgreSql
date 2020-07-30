DO $$
BEGIN
    IF NOT EXISTS(
        SELECT schema_name
          FROM information_schema.schemata
          WHERE schema_name = 'hangfire'
      )
    THEN
      EXECUTE 'CREATE SCHEMA "hangfire";';
    END IF;

END
$$;

SET search_path = 'hangfire';
--
-- Table structure for table `Schema`
--

CREATE TABLE IF NOT EXISTS "schema" (  "version" INT NOT NULL ,
  PRIMARY KEY ("version")
); 


DO
$$
BEGIN
    IF EXISTS (SELECT 1 FROM "schema" WHERE "version"::integer >= 3) THEN
        RAISE EXCEPTION 'version-already-applied';
    END IF;
END
$$;

INSERT INTO "schema"("version") values('1');

--
-- Table structure for table `Counter`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]counter" (  "id" SERIAL NOT NULL ,
  "key" VARCHAR(100) NOT NULL ,
  "value" SMALLINT NOT NULL ,
  "expireat" TIMESTAMP NULL ,
  PRIMARY KEY ("id")
); 

DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_[tablesPrefix]counter_key" ON "counter" ("key");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX ix_hangfire_counter_key already exists.';
    END;
END;
$$;

--
-- Table structure for table `Hash`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]hash" (  "id" SERIAL NOT NULL ,
  "key" VARCHAR(100) NOT NULL ,
  "field" VARCHAR(100) NOT NULL ,
  "value" TEXT NULL ,
  "expireat" TIMESTAMP NULL ,
  PRIMARY KEY ("id"),
  UNIQUE ("key","field")
); 


--
-- Table structure for table `Job`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]job" (  "id" SERIAL NOT NULL ,
  "stateid" INT NULL ,
  "statename" VARCHAR(20) NULL ,
  "invocationdata" TEXT NOT NULL ,
  "arguments" TEXT NOT NULL ,
  "createdat" TIMESTAMP NOT NULL ,
  "expireat" TIMESTAMP NULL ,
  PRIMARY KEY ("id")
); 

DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_[tablesPrefix]job_statename" ON "[tablesPrefix]job" ("statename");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX "ix_hangfire_[tablesPrefix]job_statename" already exists.';
    END;
END;
$$;

--
-- Table structure for table `State`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]state" (  "id" SERIAL NOT NULL ,
  "jobid" INT NOT NULL ,
  "name" VARCHAR(20) NOT NULL ,
  "reason" VARCHAR(100) NULL ,
  "createdat" TIMESTAMP NOT NULL ,
  "data" TEXT NULL ,
  PRIMARY KEY ("id"),FOREIGN KEY ("jobid") REFERENCES "[tablesPrefix]job" ( "id" ) ON UPDATE CASCADE ON DELETE CASCADE
); 

DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_[tablesPrefix]state_jobid" ON "state" ("jobid");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX "ix_hangfire_[tablesPrefix]state_jobid" already exists.';
    END;
END;
$$;




--
-- Table structure for table `JobQueue`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]jobqueue" (  "id" SERIAL NOT NULL ,
  "jobid" INT NOT NULL ,
  "queue" VARCHAR(20) NOT NULL ,
  "fetchedat" TIMESTAMP NULL ,
  PRIMARY KEY ("id")
); 

DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_jobqueue_queueandfetchedat" ON "[tablesPrefix]jobqueue" ("queue","fetchedat");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX "ix_hangfire_[tablesPrefix]jobqueue_queueandfetchedat" already exists.';
    END;
END;
$$;


--
-- Table structure for table `List`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]list" (  "id" SERIAL NOT NULL ,
  "key" VARCHAR(100) NOT NULL ,
  "value" TEXT NULL ,
  "expireat" TIMESTAMP NULL ,
  PRIMARY KEY ("id")
); 


--
-- Table structure for table `Server`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]server" (  "id" VARCHAR(50) NOT NULL ,
  "data" TEXT NULL ,
  "lastheartbeat" TIMESTAMP NOT NULL ,
  PRIMARY KEY ("id")
); 


--
-- Table structure for table `Set`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]set" (  "id" SERIAL NOT NULL ,
  "key" VARCHAR(100) NOT NULL ,
  "score" FLOAT8 NOT NULL ,
  "value" TEXT NOT NULL ,
  "expireat" TIMESTAMP NULL ,
  PRIMARY KEY ("id"),
  UNIQUE ("key","value")
); 


--
-- Table structure for table `JobParameter`
--

CREATE TABLE IF NOT EXISTS "[tablesPrefix]jobparameter" (  "id" SERIAL NOT NULL ,
  "jobid" INT NOT NULL ,
  "name" VARCHAR(40) NOT NULL ,
  "value" TEXT NULL ,
  PRIMARY KEY ("id"),FOREIGN KEY ("jobid") REFERENCES "[tablesPrefix]job" ( "id" ) ON UPDATE CASCADE ON DELETE CASCADE
); 

DO $$
BEGIN
    BEGIN
        CREATE INDEX "ix_hangfire_[tablesPrefix]jobparameter_jobidandname" ON "[tablesPrefix]jobparameter" ("jobid","name");
    EXCEPTION
        WHEN duplicate_table THEN RAISE NOTICE 'INDEX "ix_hangfire_[tablesPrefix]jobparameter_jobidandname" already exists.';
    END;
END;
$$;

CREATE TABLE IF NOT EXISTS "[tablesPrefix]lock" ( "resource" VARCHAR(100) NOT NULL ,
  UNIQUE ("resource")
); 
