CREATE TABLE tipos_apli(
  id_tipo NUMBER(2) CONSTRAINT tipos_apli_pk PRIMARY KEY CASCADE CONSTRAINT,
  tipo VARCHAR(25) CONSTRAINT tipos_apli_uk1 UNIQUE
                    CONSTRAINT tipos_apli_nn1 NOT NULL
);

CREATE TABLE aplicaciones(
  n_aplicacion NUMBER(4) CONSTRAINT aplicaciones_pk PRIMARY KEY,
  nombre VARCHAR(25) CONSTRAINT aplicaciones_uk1 UNIQUE
                      CONSTRAINT aplicaciones_nn1 NOT NULL,
  extension NUMBER(11,2),
  id_tipo NUMBER(11,2) CONSTRAINT aplicaciones_fk1 REFERENCES tipos_apli
);

CREATE TABLE procesos(
  n_aplicacion NUMBER(4) CONSTRAINT n_aplicacion_fk1 REFERENCES aplicaciones,
  id_proceso NUMBER(3),
  nombre VARCHAR(25) CONSTRAINT procesos_uk1 UNIQUE
                      CONSTRAINT procesos_nn1 NOT NULL,
  mem_minima NUMBER(5,1),
  id_proceso_lanz NUMBER(3),
  n_aplicacion_lanza NUMBER(4),
  CONSTRAINT procesos_pk PRIMARY KEY (n_aplicacion,id_proceso) ON DELETE SET NULL,
  CONSTRAINT procesos_fk2 FOREIGN KEY (id_proceso_lanz,n_aplicacion_lanza) REFERENCES procesos,
  CONSTRAINT procesos_ck1 CHECK (mem_minima>=0)
);

CREATE TABLE procesos_lanzados(
  n_aplicacion NUMBER(4),
  id_proceso NUMBER(3),
  fecha_lanz TIMESTAMP,
  fecha_termino TIMESTAMP,
  bloqueado NUMBER(1),
  n_maquina NUMBER (3) CONSTRAINT procesos_lanzados_fk2 REFERENCES maquinas
                        CONSTRAINT procesos_lanzados_nn1 NOT NULL,
  CONSTRAINT procesos_lanzados_pk PRIMARY KEY (n_aplicacion,id_proceso,fecha_lanz),
  CONSTRAINT procesos_lanzados_fk1 FOREIGN KEY (n_aplicacion,id_proceso) REFERENCES procesos,
  CONSTRAINT procesos_lanzados_ck2 CHECK (bloqueado=1||0)
);

CREATE TABLE maquinas(
  n_maquina NUMBER(3) CONSTRAINT maquinas_pk PRIMARY KEY,
  ip1 NUMBER(3)
                CONSTRAINT maquinas_nn1 NOT NULL,
  ip2 NUMBER(3)
                CONSTRAINT maquinas_nn2 NOT NULL,
  ip3 NUMBER(3)
                CONSTRAINT maquinas_nn3 NOT NULL,
  ip4 NUMBER(3)
                CONSTRAINT maquinas_nn4 NOT NULL,
  nombre VARCHAR(45) CONSTRAINT maquinas_uk2 UNIQUE
                      CONSTRAINT maquinas_nn5 NOT NULL,
  memoria NUMBER(5,1),
  CONSTRAINT maquinas_uk1 UNIQUE (ip1,ip2,ip3,ip4),
  CONSTRAINT maquinas_ck1 CHECK (ip1,ip2,ip3,ip4=0<255)
);

DROP TABLE aplicaciones CASCADE CONSTRAINT;
DROP TABLE maquinas CASCADE CONSTRAINT;
DROP TABLE PROCESOS CASCADE CONSTRAINT;
DROP TABLE PROCESOS_LANZADOS CASCADE CONSTRAINT;
DROP TABLE TIPOS_APLI CASCADE CONSTRAINT;