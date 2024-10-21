CREATE TABLE proposals (
    proposalId VARCHAR(36) PRIMARY KEY UNIQUE,
    clientName VARCHAR(255) NOT NULL,
    clientDocument VARCHAR(14) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    purpose VARCHAR(255) NOT NULL,
    creationDate TIMESTAMP DEFAULT NOW(),
    status VARCHAR(20)
);

COMMENT ON COLUMN proposals.proposalId IS 'Identificador único da proposta';
COMMENT ON COLUMN proposals.clientName IS 'Nome ou razão social do solicitante';
COMMENT ON COLUMN proposals.clientDocument IS 'Documento de identificação do solicitante (CNPJ ou CPF)';
COMMENT ON COLUMN proposals.amount IS 'Valor solicitado para financiamento';
COMMENT ON COLUMN proposals.purpose IS 'Propósito do financiamento (ex: compra de equipamentos)';
COMMENT ON COLUMN proposals.creationDate IS 'Data e hora da criação da proposta';
COMMENT ON COLUMN proposals.status IS 'Estado atual da proposta (ex: Pendente, Aprovada, Rejeitada)';
