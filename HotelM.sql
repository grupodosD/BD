CREATE DATABASE HotelM;

USE HotelM;

CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY NOT NULL auto_increment,
    Nome VARCHAR(20),
    Cpf BIGINT,
    Endereco VARCHAR(20),
    Senha VARBINARY(255),
    Telefone BIGINT
);

CREATE TABLE Reserva (
    Id_Reserva INT PRIMARY KEY NOT NULL auto_increment,
    Id_Cliente INT,
    Data_Checkin DATE,
    Data_Checkout DATE,
    Status_Reserva VARCHAR(20),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);


CREATE TABLE Quarto (
    Id_Quarto INT PRIMARY KEY NOT NULL auto_increment,
    Tipos_Quartos VARCHAR(20),
    Status_Quartos VARCHAR(20),
    Id_Cliente INT,
    Id_Reserva INT,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    FOREIGN KEY (Id_Reserva) REFERENCES Reserva(Id_Reserva)
);


CREATE TABLE Tipos_Quartos (
    Id_TipoQuarto INT PRIMARY KEY NOT NULL auto_increment,
    Suite VARCHAR(40)
);

-- Criar a tabela Pagamentos
CREATE TABLE Pagamentos (
    Id_Pagamentos INT PRIMARY KEY NOT NULL auto_increment,
    Id_Cliente INT,
    Id_Reserva INT,
    Valor DECIMAL(10,2),
    Data_Pagamento DATE,
    Metodo_Pagamento VARCHAR(20),
    Status_Pagamento VARCHAR(20),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    FOREIGN KEY (Id_Reserva) REFERENCES Reserva(Id_Reserva)
);

-- Criar a tabela Cargo
CREATE TABLE Cargo (
    Id_Cargo INT PRIMARY KEY NOT NULL auto_increment,
    NomeCargo VARCHAR(30)
);

-- Criar a tabela Funcionario
CREATE TABLE Funcionario (
    Id_funcionario INT PRIMARY KEY NOT NULL auto_increment,
    Id_Cargo INT,
    Nome VARCHAR(20),
    Cargo VARCHAR(20),
    Salario DECIMAL(10,2),
    FOREIGN KEY (Id_Cargo) REFERENCES Cargo(Id_Cargo)
);

-- Criar a tabela Servico
CREATE TABLE Servico (
    Id_Servico INT PRIMARY KEY NOT NULL auto_increment,
    Id_Funcionario INT,
    Nome VARCHAR(20),
    Descricao VARCHAR(20),
    Preco DECIMAL(10,2),
    FOREIGN KEY (Id_Funcionario) REFERENCES Funcionario(Id_funcionario)
);


-- Exemplo de inserção de dados criptografados
-- a chave de criptografia segura e secreta
SET @chave_secreta = UNHEX('526F79616C506C616365000000000000');

-- Inserindo dados na tabela Cliente com a senha criptografada
INSERT INTO Cliente (Id_Cliente, Nome, Cpf, Endereco, Senha, Telefone)
VALUES (
    'João da Silva',
    123456789,
    'Rua Exemplo, 123',
    AES_ENCRYPT('senha123', @chave_secreta), -- Criptografar senha
    987654321
);

INSERT INTO Cliente (Nome, Cpf, Endereco, Senha, Telefone)
VALUES (
    'bombom@gmail.com',
    924456779,
    'Rua Exemplo, 890',
    AES_ENCRYPT('mysqlamo', @chave_secreta), -- Criptografar senha
    987654321
);



-- Exemplo de seleção de dados descriptografados
-- Descriptografando a senha para visualização (somente para demonstração)
SELECT
    Nome,
    AES_DECRYPT(Senha, @chave_secreta) AS Senha
FROM Cliente
WHERE Id_Cliente = 1;