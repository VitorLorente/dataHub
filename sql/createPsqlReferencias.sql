-- Criação do banco de dados
CREATE DATABASE referencias;

-- Conectar ao banco de dados
\c referencias;

-- Tabela Pais
CREATE TABLE Pais (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    sigla VARCHAR(3) NOT NULL UNIQUE
);

-- Tabela Collection
CREATE TABLE Collection (
    id SERIAL PRIMARY KEY,
    nomeCollection VARCHAR(255) NOT NULL UNIQUE,
    dataUpdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Metadados
CREATE TABLE Metadados (
    id SERIAL PRIMARY KEY,
    nomeFonte VARCHAR(255) NOT NULL,
    referencia TEXT,
    linkFonte TEXT,
    collection_id INT REFERENCES Collection(id) ON DELETE CASCADE
);

-- Tabela Log
CREATE TABLE Log (
    id SERIAL PRIMARY KEY,
    collection_id INT REFERENCES Collection(id) ON DELETE CASCADE,
    data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    linkFonte TEXT,
    updateType VARCHAR(10) CHECK (updateType IN ('Create', 'Update'))
);

-- Tabela ClassificacaoDado
CREATE TABLE ClassificacaoDado (
    id SERIAL PRIMARY KEY,
    nomeCategoria VARCHAR(255) NOT NULL UNIQUE,
    field TEXT
);

-- Tabela de relacionamento Many-to-Many entre Pais e Collection
CREATE TABLE PaisCollectionMtM (
    id SERIAL PRIMARY KEY,
    id_pais INT REFERENCES Pais(id) ON DELETE CASCADE,
    id_collection INT REFERENCES Collection(id) ON DELETE CASCADE,
    UNIQUE (id_pais, id_collection)
);

-- Tabela de relacionamento Many-to-Many entre ClassificacaoDado e Collection
CREATE TABLE ClassificacaoCollectionMtM (
    id SERIAL PRIMARY KEY,
    id_classificacaoDado INT REFERENCES ClassificacaoDado(id) ON DELETE CASCADE,
    id_collection INT REFERENCES Collection(id) ON DELETE CASCADE,
    UNIQUE (id_classificacaoDado, id_collection)
);