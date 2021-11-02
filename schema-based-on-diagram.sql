CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(15),
  CONSTRAINT fk_patients
  FOREIGN KEY (patient_id)
  REFERENCES patients(id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_histories
  FOREIGN KEY (medical_history_id)
  REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoices
  FOREIGN KEY (invoice_id)
  REFERENCES invoices(id),

  CONSTRAINT fk_treatments
  FOREIGN KEY (treatment_id)
  REFERENCES treatments(id)
);

-- Join Table To handle M:M relationships between medical_histories and treatments tables.

CREATE TABLE diagnosis (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  medical_id INT,
  treatment_id INT,

  CONSTRAINT fk_medical_histories
  FOREIGN KEY (medical_id)
  REFERENCES medical_histories(id),

  CONSTRAINT fk_treatments
  FOREIGN KEY (treatment_id)
  REFERENCES treatments(id)
);

CREATE INDEX medical_histories_desc ON medical_histories(patient_id);

CREATE INDEX invoices_desc ON invoices(medical_history_id);

CREATE INDEX invoice_items_desc_1 ON invoice_items(invoice_id);

CREATE INDEX invoice_items_desc_2 ON invoice_items(treatment_id);

CREATE INDEX diagnosis_desc_1 ON diagnosis(medical_id);

CREATE INDEX diagnosis_desc_2 ON diagnosis(treatment_id);
