CREATE TABLE clients (
    clientId VARCHAR(36) PRIMARY KEY UNIQUE,
    document VARCHAR(14) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL UNIQUE
);

COMMENT ON COLUMN clients.clientId IS 'Identificador único do cliente';
COMMENT ON COLUMN clients.name IS 'Nome ou razão social do solicitante';
COMMENT ON COLUMN clients.document IS 'Documento de identificação do solicitante (CNPJ ou CPF)';

