CREATE DATABASE HotelM;


USE HotelM;

-- Criar a tabela Cliente com criptografia para a coluna Senha
INSERT INTO Cliente (Id_Cliente, Nome, Cpf, Endereco, Senha, Telefone)
VALUES (
    0, 
    'N/A',
    '00000000000', 
    NULL,
    AES_ENCRYPT(NULL, @chave_secreta), 
    NULL
);

-- Criar a tabela Reserva
CREATE TABLE Reserva (
    Id_Reserva INT PRIMARY KEY NOT NULL auto_increment,
    Id_Cliente INT,
    Data_Checkin DATE,
    Data_Checkout DATE,
    Status_Reserva VARCHAR(20),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
    on update cascade
);


-- Criar a tabela Tipos_Quartos
CREATE TABLE Tipos_Quartos (
    Id_TipoQuarto INT PRIMARY KEY NOT NULL auto_increment,
    Suite VARCHAR(40)
);

-- Criar a tabela Quarto
CREATE TABLE Quarto (
    Id_Quarto INT PRIMARY KEY NOT NULL auto_increment,
    Id_TipoQuarto INT,
    Status_Quartos VARCHAR(20),
    Id_Cliente INT,
    Id_Reserva INT,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    FOREIGN KEY (Id_Reserva) REFERENCES Reserva(Id_Reserva),
    FOREIGN KEY (Id_TipoQuarto) REFERENCES Tipos_Quartos(Id_TipoQuarto)
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
	on update cascade
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
    Nome VARCHAR(20) NOT NULL,
    Senha VARBINARY(255) NOT NULL,
    Nacimento DATE NOT NULL,
    Telefone char (11) UNIQUE NOT NULL,
    Cpf char (11) UNIQUE NOT NULL,
    Cargo VARCHAR(20) NOT NULL,
    Efetivado DATE,
    Salario DECIMAL(10,2),
    FOREIGN KEY (Id_Cargo) REFERENCES Cargo(Id_Cargo)
	on update cascade
);

-- Criar a tabela Servico
CREATE TABLE Servico (
    Id_Servico INT PRIMARY KEY NOT NULL auto_increment,
    Id_Funcionario INT,
    Nome VARCHAR(20),
    Descricao VARCHAR(20),
    Preco DECIMAL(10,2),
    FOREIGN KEY (Id_Funcionario) REFERENCES Funcionario(Id_funcionario)
	on update cascade
);

	CREATE TABLE Login (
	Id_usuario INT PRIMARY KEY NOT NULL auto_increment, 
	Nome_usuario VARCHAR (20) NOT NULL,
	Email_usuario varchar (20) UNIQUE NOT NULL,
    Senha_usuario VARCHAR (20) UNIQUE NOT NULL
);


-- Exemplo de inserção de dados criptografados
-- a chave de criptografia segura e secreta

SET @chave_secreta = UNHEX('526F79616C506C616365000000000000');


INSERT INTO Cargo ( NomeCargo) values (
'testador'
'gerente' 
);

INSERT INTO Funcionario (Id_Cargo, Nome, Senha, Nacimento, Telefone, Cpf, Cargo, Efetivado, Salario)
VALUES (
    1,
    'Bombom',
    AES_ENCRYPT('amojuju', @chave_secreta), -- Criptografar senha
    '1990-01-01',
    987654321,
    123456789,
    'testador',
    '2020-01-01',
    5000.00
);


INSERT INTO Cliente (Nome, Cpf, Endereco, Senha, Telefone)
VALUES (
    'João Silva',
    '12345678901',
    'Rua Exemplo, 123',
    AES_ENCRYPT('senha123', @chave_secreta), -- Criptografar a senha
    '11999999999'
);


INSERT INTO Cliente (Id_Cliente, Nome, Cpf, Endereco, Senha, Telefone)
VALUES (
    0, 
    'N/A',
    NULL,
    NULL,
    AES_ENCRYPT(NULL, @chave_secreta), -- Criptografar a senha
    NULL
);


INSERT INTO Reserva (Id_Cliente, Data_Checkin, Data_Checkout, Status_Reserva)
VALUES (1, '2024-10-12', '2024-10-15', 'Reservado');

INSERT INTO Reserva (Id_Cliente, Data_Checkin, Data_Checkout, Status_Reserva)
VALUES (0, '2024-10-12', '9999-12-31', 'Reservado');


SELECT * FROM Reserva;

INSERT INTO Tipos_Quartos (Suite) VALUES ('Suíte Master');

INSERT INTO Quarto (Id_TipoQuarto, Status_Quartos, Id_Cliente, Id_Reserva)
VALUES (1, 'Disponível', 1, 1);
INSERT INTO Quarto (Id_TipoQuarto, Status_Quartos, Id_Cliente, Id_Reserva)
VALUES (null, 'ocupado', 1, 1);

select*from quarto;

UPDATE quarto
SET Id_Reserva= 5
WHERE Id_Cliente = 0; 


-- Exemplo de seleção de dados descriptografados
-- Descriptografando a senha para visualização (somente para demonstração)
SELECT
    Nome,
    AES_DECRYPT(Senha, @chave_secreta) AS Senha
FROM Cliente
WHERE Id_Cliente = 1;