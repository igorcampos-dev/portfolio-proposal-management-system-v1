CREATE TABLE proposals (
    proposal_id VARCHAR(36) PRIMARY KEY UNIQUE,
    client_name VARCHAR(255) NOT NULL,
    client_document VARCHAR(14) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    purpose VARCHAR(255) NOT NULL,
    creation_date TIMESTAMP DEFAULT NOW()
    );

COMMENT ON COLUMN proposals.proposal_id IS 'Identificador único da proposta';
COMMENT ON COLUMN proposals.client_name IS 'Nome ou razão social do solicitante';
COMMENT ON COLUMN proposals.client_document IS 'Documento de identificação do solicitante (CNPJ ou CPF)';
COMMENT ON COLUMN proposals.amount IS 'Valor solicitado para financiamento';
COMMENT ON COLUMN proposals.purpose IS 'Propósito do financiamento (ex: compra de equipamentos)';
COMMENT ON COLUMN proposals.creation_date IS 'Data e hora da criação da proposta';