-- -----------------------------------------------------
-- Table "Patient"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Patient (
    id INT NOT NULL ENABLE,
    name VARCHAR2(100 byte) NOT NULL ENABLE,
    birthdate DATE NOT NULL ENABLE,
    age INT NOT NULL ENABLE,
    PRIMARY KEY (id))';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END; 

--!

-- -----------------------------------------------------
-- Table "Medic"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Medic (
  id INT NOT NULL ENABLE,
  name VARCHAR2(100 byte) NOT NULL ENABLE,
  PRIMARY KEY (id))';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END; 

--!

-- -----------------------------------------------------
-- Table "Careteam"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Careteam (
  id INT NOT NULL ENABLE,
  PRIMARY KEY (id))';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END; 

--!

-- -----------------------------------------------------
-- Table "Service"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Service (
  cod VARCHAR2(20 byte) NOT NULL ENABLE,
  descr VARCHAR2(100 byte) NOT NULL ENABLE,
  PRIMARY KEY (cod))';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END; 

--!

-- -----------------------------------------------------
-- Table "Sensor"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Sensor (
  id INT NOT NULL,
  num INT NOT NULL,
  type VARCHAR2(50 byte) NOT NULL,
  PRIMARY KEY (id))';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END; 

--!

-- -----------------------------------------------------
-- Table "Monitor"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Monitor (
  sensor_id INT NOT NULL ENABLE,
  patient_id INT NOT NULL ENABLE,
  serv_cod VARCHAR2(20 byte) NOT NULL ENABLE,
  careteam_id INT NOT NULL ENABLE,
  num_sensors INT NOT NULL ENABLE,
  admdate DATE NOT NULL ENABLE,
  bed VARCHAR2(3 byte) NOT NULL ENABLE,
  bodytemp NUMBER(2,0) NOT NULL ENABLE,
  bp_syst NUMBER(3,0) NOT NULL ENABLE,
  bp_dias NUMBER(3,0) NOT NULL ENABLE,
  bpm NUMBER(3,0) NOT NULL ENABLE,
  sato2 NUMBER(3,0) NOT NULL ENABLE,
  timestamp DATE NOT NULL ENABLE,
  CONSTRAINT fk_Monitor_Sensor
    FOREIGN KEY (sensor_id)
    REFERENCES Sensor(id) ENABLE,
  CONSTRAINT fk_Monitor_Patient1
    FOREIGN KEY (patient_id)
    REFERENCES Patient(id) ENABLE,
  CONSTRAINT fk_Monitor_Service1
    FOREIGN KEY (serv_cod)
    REFERENCES Service(cod) ENABLE,
  CONSTRAINT fk_Monitor_Careteam1
    FOREIGN KEY (careteam_id)
    REFERENCES Careteam(id) ENABLE )';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END; 

--!

-- -----------------------------------------------------
-- Table "Careteam_Medics"
-- -----------------------------------------------------
declare
v_sql LONG;
begin

v_sql:='CREATE TABLE Careteam_Medics (
  careteam_id INT NOT NULL,
  medic_id INT NOT NULL,
  CONSTRAINT fk_Careteam_has_Medic_Careteam1
    FOREIGN KEY (careteam_id)
    REFERENCES Careteam(id),
  CONSTRAINT fk_Careteam_has_Medic_Medic1
    FOREIGN KEY (medic_id)
    REFERENCES Medic(id))';
execute immediate v_sql;

EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
        NULL; 
      ELSE
         RAISE;
      END IF;
END;