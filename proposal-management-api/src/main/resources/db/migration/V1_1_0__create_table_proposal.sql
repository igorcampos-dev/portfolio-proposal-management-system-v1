CREATE TABLE service_contract (
    id VARCHAR(36) PRIMARY KEY,
    contract_id VARCHAR(50) NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    client_type VARCHAR(10) NOT NULL,
    service_type VARCHAR(255) NOT NULL,
    contract_value DECIMAL(15, 2) NOT NULL,
    duration_months INT NOT NULL,
    payment_model VARCHAR(20) NOT NULL,
    risk_category VARCHAR(20) NOT NULL,
    requires_on_site BOOLEAN NOT NULL,
    sla_hours INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    analysis_description TEXT NOT NULL
);

COMMENT ON COLUMN service_contract.id IS 'Identificador único da proposta (UUID).';
COMMENT ON COLUMN service_contract.contract_id IS 'Identificador único do contrato externo.';
COMMENT ON COLUMN service_contract.client_name IS 'Nome do cliente da proposta.';
COMMENT ON COLUMN service_contract.client_type IS 'Tipo do cliente (PF, PJ).';
COMMENT ON COLUMN service_contract.service_type IS 'Tipo de serviço contratado.';
COMMENT ON COLUMN service_contract.contract_value IS 'Valor monetário total do contrato.';
COMMENT ON COLUMN service_contract.duration_months IS 'Duração do contrato em meses.';
COMMENT ON COLUMN service_contract.payment_model IS 'Modelo de pagamento (MONTHLY, ONE_TIME, etc).';
COMMENT ON COLUMN service_contract.risk_category IS 'Categoria de risco (LOW, MEDIUM, HIGH, CRITICAL).';
COMMENT ON COLUMN service_contract.requires_on_site IS 'Indica se o serviço exige presença física.';
COMMENT ON COLUMN service_contract.sla_hours IS 'Número de horas do SLA definido para o serviço.';
COMMENT ON COLUMN service_contract.status IS 'Status atual da proposta (ex.: EM_VALIDACAO, APROVADA, REJEITADA).';
COMMENT ON COLUMN service_contract.created_at IS 'Data/hora da criação da proposta.';
COMMENT ON COLUMN service_contract.updated_at IS 'Data/hora da última atualização da proposta.';
COMMENT ON COLUMN service_contract.analysis_description IS 'Descrição da análise da proposta.';