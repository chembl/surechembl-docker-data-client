
CREATE TABLE schembl_document (
  id INTEGER NOT NULL,
  scpn VARCHAR(50) NOT NULL,
  published DATE NULL,
  life_sci_relevant SMALLINT NULL,
  assign_applic VARCHAR(1000),
  family_id INTEGER NULL,
  PRIMARY KEY (id));

CREATE UNIQUE INDEX scpn_UNIQUE ON schembl_document (scpn ASC);

CREATE SEQUENCE schembl_document_id;

-- -----------------------------------------------------
-- Table schembl_document_class
-- -----------------------------------------------------

CREATE TABLE schembl_document_class (
  schembl_doc_id INTEGER NOT NULL,
  class VARCHAR(100) NOT NULL,
  system SMALLINT NOT NULL,
  PRIMARY KEY (schembl_doc_id, class, system),
  CONSTRAINT fk_docclass_to_doc
    FOREIGN KEY (schembl_doc_id)
    REFERENCES schembl_document (id));


-- -----------------------------------------------------
-- Table schembl_document_title
-- -----------------------------------------------------

-- Oracle: Change 'text' column type to CLOB

CREATE TABLE schembl_document_title (
  schembl_doc_id INTEGER NOT NULL,
  lang VARCHAR(10) NOT NULL,
  text CLOB NULL,
  PRIMARY KEY (schembl_doc_id, lang),
  CONSTRAINT fk_doctitle_to_doc
    FOREIGN KEY (schembl_doc_id)
    REFERENCES schembl_document (id));

-- -----------------------------------------------------
-- Table schembl_chemical
-- -----------------------------------------------------

CREATE TABLE schembl_chemical (
  id INTEGER NOT NULL,
  mol_weight FLOAT NULL,
  logp FLOAT NULL,
  med_chem_alert SMALLINT NULL,
  is_relevant SMALLINT NULL,
  donor_count SMALLINT NULL,
  acceptor_count SMALLINT NULL,
  ring_count SMALLINT NULL,
  rot_bond_count SMALLINT NULL,
  corpus_count INTEGER NULL,
  PRIMARY KEY (id));



-- -----------------------------------------------------
-- Table schembl_chemical_structure
-- -----------------------------------------------------

-- Oracle: Change 'smiles' and 'std_inchi' column type to CLOB

CREATE TABLE schembl_chemical_structure (
  schembl_chem_id INTEGER NOT NULL,
  smiles CLOB NULL,
  std_inchi CLOB NULL,
  std_inchikey VARCHAR(27) NULL,
  PRIMARY KEY (schembl_chem_id),
  CONSTRAINT fk_chemstruct_to_chem
    FOREIGN KEY (schembl_chem_id)
    REFERENCES schembl_chemical (id));


-- -----------------------------------------------------
-- Table schembl_document_chemistry
-- -----------------------------------------------------

CREATE TABLE schembl_document_chemistry (
  schembl_doc_id INTEGER NOT NULL,
  schembl_chem_id INTEGER NOT NULL,
  field SMALLINT NOT NULL,
  frequency INTEGER NULL,
  PRIMARY KEY (schembl_doc_id, schembl_chem_id, field),
  CONSTRAINT fk_docchem_to_doc
    FOREIGN KEY (schembl_doc_id)
    REFERENCES schembl_document (id),
  CONSTRAINT fk_docchem_to_chem
    FOREIGN KEY (schembl_chem_id)
    REFERENCES schembl_chemical (id));

CREATE INDEX fk_docchem_docid_idx ON schembl_document_chemistry (schembl_doc_id ASC);

CREATE INDEX fk_docchem_chemid_idx ON schembl_document_chemistry (schembl_chem_id ASC);

exit;