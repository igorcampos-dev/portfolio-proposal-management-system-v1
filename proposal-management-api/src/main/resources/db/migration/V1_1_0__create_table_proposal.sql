CREATE TABLE proposal (
    id VARCHAR(36) PRIMARY KEY DEFAULT gen_random_uuid(),
    description TEXT NOT NULL,
    value DECIMAL(15, 2) NOT NULL,
    supplier_id VARCHAR(50) NOT NULL,
    supplier_name VARCHAR(255) NOT NULL,
    client_id VARCHAR(50) NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    analysis_description TEXT NOT NULL
);

COMMENT ON COLUMN proposal.id IS 'Identificador único da proposta.';
COMMENT ON COLUMN proposal.description IS 'Descrição detalhada da proposta.';
COMMENT ON COLUMN proposal.value IS 'Valor monetário da proposta.';
COMMENT ON COLUMN proposal.supplier_id IS 'Identificador único do fornecedor.';
COMMENT ON COLUMN proposal.supplier_name IS 'Nome do fornecedor responsável pela proposta.';
COMMENT ON COLUMN proposal.client_id IS 'Identificador único do cliente.';
COMMENT ON COLUMN proposal.client_name IS 'Nome do cliente que está recebendo a proposta.';
COMMENT ON COLUMN proposal.status IS 'Status atual da proposta (ex.: EM_VALIDACAO, APROVADA, REJEITADA).';
COMMENT ON COLUMN proposal.created_at IS 'Data e hora em que a proposta foi criada.';
COMMENT ON COLUMN proposal.updated_at IS 'Data e hora da última atualização da proposta.';
COMMENT ON COLUMN proposal.analysis_description IS 'Descrição da análise da proposta.';