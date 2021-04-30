CREATE DATABASE campeonato
GO
USE campeonato

GO

CREATE TABLE Times(
CodigoTime INT NOT NULL,
NomeTime VARCHAR(100) NOT NULL,
Cidade VARCHAR(100) NOT NULL,
Estadio VARCHAR(100) NOT NULL
PRIMARY KEY(CodigoTime)
)

GO

CREATE TABLE Grupos(
Grupo CHAR(1) NOT NULL CHECK(Grupo = 'A' OR Grupo = 'B' OR Grupo = 'C' OR Grupo = 'D'),
CodigoTime INT NOT NULL
PRIMARY KEY(Grupo, CodigoTime)
FOREIGN KEY(CodigoTime) REFERENCES Times(CodigoTime)
)

GO

CREATE TABLE Jogos(
CodigoTimeA INT NOT NULL,
CodigoTimeB INT NOT NULL,
GolsTimeA INT,
GolsTimeB INT,
Data DATE NOT NULL
PRIMARY KEY(CodigoTimeA, CodigoTimeB)
FOREIGN KEY(CodigoTimeA) REFERENCES Times(CodigoTime),
FOREIGN KEY(CodigoTimeB) REFERENCES Times(CodigoTime)
)

GO

INSERT INTO Times VALUES
(1,	'Botafogo-SP', 'Ribeirão Preto', 'Santa Cruz'),
(2,	'Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid'),
(3,	'Corinthians', 'São Paulo', 'Arena Corinthians'),
(4,	'Ferroviária', 'Araraquara', 'Fonte Luminosa'),
(5,	'Guarani', 'Campinas', 'Brinco de Ouro da Princesa'),
(6,	'Ituano', 'Itu', 'Novelli Júnior'),
(7,	'Mirassol', 'Mirassol', 'José Maria de Campos Maia'),
(8,	'Novorizontino', 'Novo Horizonte',	'Jorge Ismael de Biasi'),
(9,	'Oeste', 'Barueri', 'Arena Barueri'),
(10, 'Palmeiras', 'São Paulo', 'Allianz Parque'),
(11, 'Ponte Preta', 'Campinas', 'Moisés Lucarelli'),
(12, 'Red Bull Brasil', 'Campinas', 'Moisés Lucarelli'),
(13, 'Santos',	'Santos', 'Vila Belmiro'),
(14, 'São Bento', 'Sorocaba', 'Walter Ribeiro'),
(15, 'São Caetano', 'São Caetano do Sul', 'Anacletto Campanella'),
(16, 'São Paulo', 'São Paulo', 'Morumbi')

GO

SELECT * FROM Times

CREATE PROCEDURE sp_insereTimesGrandes(@grupos VARCHAR(4))
AS
	DECLARE @time INT,
		@cont INT,
		@query VARCHAR(MAX)

	SET @cont = 1

	WHILE(@cont < 5)
	BEGIN
		SET @time = (SELECT TOP 1 t.CodigoTime
		FROM Times t LEFT JOIN Grupos g
		ON t.CodigoTime = g.CodigoTime
		WHERE g.CodigoTime IS NULL
		AND (t.CodigoTime = 3 OR t.CodigoTime = 10 OR t.CodigoTime = 13 OR t.CodigoTime = 16)
		ORDER BY NEWID())

		INSERT INTO Grupos VALUES
		(SUBSTRING(@grupos, @cont, 1), @time)

		SET @cont = @cont + 1
	END


-------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE PROCEDURE sp_insereTimesGrupo
AS
	DECLARE @grupos VARCHAR(4),
		@grupo CHAR(1),
		@cont INT,
		@query VARCHAR(MAX),
		@qtdTimesGrupos INT,
		@qtdTimes INT

	SET @grupos = 'ABCD'
	SET @qtdTimes = 16
	SET @qtdTimesGrupos = (SELECT COUNT(*) FROM Grupos)

	EXEC sp_insereTimesGrandes @grupos

	DECLARE @qtdTimesGrupoA INT,
		@qtdTimesGrupoB INT,
		@qtdTimesGrupoC INT,
		@qtdTimesGrupoD INT,
		@codigoTime INT

	SET @qtdTimesGrupoA = 1
	SET @qtdTimesGrupoB = 1
	SET @qtdTimesGrupoC = 1
	SET @qtdTimesGrupoD = 1

	WHILE(@qtdTimesGrupos < @qtdTimes)
	BEGIN
		
		SET @qtdTimesGrupos = (SELECT COUNT(*) FROM Grupos)
		
		--Pegar um codigoTime aleatório na tabela Times que não esteja na tabela Grupos
		SET @codigoTime = (
			SELECT TOP 1 t.CodigoTime
			FROM Times t LEFT JOIN Grupos g
			ON t.CodigoTime = g.CodigoTime
			WHERE g.CodigoTime IS NULL
			ORDER BY NEWID()
		)

		SET @cont = (SELECT CAST(RAND() * ((LEN(@grupos))) + 1 AS INT))
		SET @grupo = (SELECT SUBSTRING(@grupos, @cont, 1))

		IF(@grupo = 'A')
		BEGIN
			SET @qtdTimesGrupoA = @qtdTimesGrupoA + 1
		END
		ELSE
		BEGIN
			IF(@grupo = 'B')
			BEGIN
				SET @qtdTimesGrupoB = @qtdTimesGrupoB + 1
			END
			ELSE
			BEGIN
				IF(@grupo = 'C')
				BEGIN
					SET @qtdTimesGrupoC = @qtdTimesGrupoC + 1
				END
				ELSE
				BEGIN
					SET @qtdTimesGrupoD = @qtdTimesGrupoD + 1
				END
			END
		END

		SET @query = 'INSERT INTO Grupos VALUES (''' + @grupo + ''', ' + CAST(@codigoTime AS VARCHAR(2)) +')'

		BEGIN TRY
				EXEC(@query)
		END TRY
		BEGIN CATCH
			RAISERROR ('Deu ruim aí amigão', 16, 1)
		END CATCH

		--Verificar se algum grupo tem 4 times
		IF(@qtdTimesGrupoA = 4)
		BEGIN
			SET @grupos = (SELECT REPLACE(@grupos, 'A', ''))
			SET @qtdTimesGrupoA = @qtdTimesGrupoA + 1
		END
		IF(@qtdTimesGrupoB = 4)
		BEGIN
			SET @grupos = (SELECT REPLACE(@grupos, 'B', ''))
			SET @qtdTimesGrupoB = @qtdTimesGrupoB + 1
		END
		IF(@qtdTimesGrupoC = 4)
		BEGIN
			SET @grupos = (SELECT REPLACE(@grupos, 'C', ''))
			SET @qtdTimesGrupoC = @qtdTimesGrupoC + 1
		END
		IF(@qtdTimesGrupoD = 4)
		BEGIN
			SET @grupos = (SELECT REPLACE(@grupos, 'D', ''))
			SET @qtdTimesGrupoD = @qtdTimesGrupoD + 1
		END
	END

	-- Query que vai criar uma view para auxiliar na criacao dos jogos
	SET @query = 'CREATE VIEW v_gruposComLinhasEnum
				  AS
				  SELECT ROW_NUMBER() OVER(ORDER BY Grupo) AS numLinhaTime, Grupo, CodigoTime FROM Grupos'

	BEGIN TRY
		EXEC (@query)
	END TRY
	BEGIN CATCH
		RAISERROR ('Deu ruim aí amigão', 16, 1)
	END CATCH

	-- Query que vai criar uma view para posterior consulta no codigo Java
	SET @query = 'CREATE  VIEW v_grupos
				  AS
			      SELECT g.Grupo AS grupo, t.NomeTime AS nomeTime, t.Cidade AS nomeCidade, t.Estadio AS nomeEstadio 
				  FROM Grupos g INNER JOIN Times t
				  ON g.CodigoTime = t.CodigoTime'

	BEGIN TRY
		EXEC (@query)
	END TRY
	BEGIN CATCH
		RAISERROR ('Deu ruim aí amigão', 16, 1)
	END CATCH



-------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE FUNCTION fn_gerarJogos (@loteRodada INT, @numRodada INT, @cont INT, @data DATE)
RETURNS @jogo TABLE(
	CodigoTimeA INT,
	CodigoTimeB INT,
	GolsTimeA INT,
	GolsTimeB INT,
	DataJogo DATE
)
AS
BEGIN
	DECLARE 
			-- Variáveis que definem os grupos que se enfrentam
			@grupo1 CHAR(1),
			@grupo2 CHAR(1),

			-- Variáveis que definem o codigo do time adversário
			@timeAdversario1 INT,
			@timeAdversario2 INT,
			@timeAdversario3 INT,
			@timeAdversario4 INT,

			@timeA INT,
			@timeB INT,
			@codigoTime INT, -- Código do primeiro time do grupo especificado
			@codigoTimeAdversario INT, -- Código do primeiro time adversário do grupo especificado
			@cont2 INT -- Contador que define os times que se enfrentam

			IF(@loteRodada = 1)
			BEGIN
				IF(@cont = 1)
				BEGIN
					SET @grupo1 = 'A'
					SET @grupo2 = 'B'
				END
				ELSE
				BEGIN
					SET @grupo1 = 'C'
					SET @grupo2 = 'D'
				END
			END
			ELSE IF(@loteRodada = 2)
			BEGIN
				IF(@cont = 1)
				BEGIN
					SET @grupo1 = 'A'
					SET @grupo2 = 'C'
				END
				ELSE
				BEGIN
					SET @grupo1 = 'B'
					SET @grupo2 = 'D'
				END
			END
			ELSE
			BEGIN
				IF(@cont = 1)
				BEGIN
					SET @grupo1 = 'A'
					SET @grupo2 = 'D'
				END
				ELSE
				BEGIN
					SET @grupo1 = 'B'
					SET @grupo2 = 'C'
				END
			END

			IF(@numRodada = 1)
			BEGIN
				SET @timeAdversario1 = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum WHERE Grupo = @grupo2)
				SET @timeAdversario2 = @timeAdversario1 + 1
				SET @timeAdversario3 = @timeAdversario2 + 1
				SET @timeAdversario4 = @timeAdversario3 + 1
			END
			ELSE
			BEGIN
				IF(@numRodada = 2)
				BEGIN
					SET @timeAdversario2 = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum WHERE Grupo = @grupo2)
					SET @timeAdversario3 = @timeAdversario2 + 1
					SET @timeAdversario4 = @timeAdversario3 + 1
					SET @timeAdversario1 = @timeAdversario4 + 1
				END
				ELSE
				BEGIN
					IF(@numRodada = 3)
					BEGIN
						SET @timeAdversario3 = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum WHERE Grupo = @grupo2)
						SET @timeAdversario4 = @timeAdversario3 + 1
						SET @timeAdversario1 = @timeAdversario4 + 1
						SET @timeAdversario2 = @timeAdversario1 + 1
					END
					ELSE
					BEGIN
						SET @timeAdversario4 = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum WHERE Grupo = @grupo2)
						SET @timeAdversario1 = @timeAdversario4 + 1
						SET @timeAdversario2 = @timeAdversario1 + 1
						SET @timeAdversario3 = @timeAdversario2 + 1
					END
				END
			END
			
			SET @cont2 = 1
			SET @codigoTime = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum WHERE Grupo = @grupo1)

			WHILE(@cont2 < 5)
			BEGIN
				
				IF(@cont2 = 1)
				BEGIN
					SET @codigoTimeAdversario = @timeAdversario1
				END
				ELSE
				BEGIN
					IF(@cont2 = 2)
					BEGIN
						SET @codigoTimeAdversario = @timeAdversario2
					END
					ELSE
					BEGIN
						IF(@cont2 = 3)
						BEGIN
							SET @codigoTimeAdversario = @timeAdversario3
						END
						ELSE
						BEGIN
							SET @codigoTimeAdversario = @timeAdversario4
						END
					END
				END

				SET @timeA = (SELECT CodigoTime FROM v_gruposComLinhasEnum WHERE numLinhaTime = @codigoTime)
				SET @timeB = (SELECT CodigoTime FROM v_gruposComLinhasEnum WHERE numLinhaTime = @codigoTimeAdversario)

				INSERT INTO @jogo VALUES (@timeA, @timeB, NULL, NULL, @data)

				SET @codigoTime = @codigoTime + 1
				SET @cont2 = @cont2 + 1

			END
	RETURN
END


-------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE PROCEDURE sp_gerarRodadas
AS
	DECLARE @dataJogo DATE,
			@contRodada INT,
			@loteRodadas INT, --Cada lote de rodadas tem 4 rodadas
			@cont INT,
			@query VARCHAR(MAX) -- Query que vai criar uma view pra posterior pesquisa de jogos por data

	SET @dataJogo = '20/01/2019' --Data da primeira rodada
	SET @loteRodadas = 1

	WHILE(@loteRodadas < 4)
	BEGIN
		SET @contRodada = 1
		WHILE(@contRodada < 5)
		BEGIN
			SET @cont = 1  --Contador que define os grupos que se enfrentam, de acordo com o loteRodadas
			WHILE(@cont < 3)
			BEGIN
				INSERT INTO Jogos SELECT * FROM fn_gerarJogos(@loteRodadas, @contRodada, @cont, @dataJogo)
				SET @cont = @cont + 1
			END

			IF(DATEPART(WEEKDAY, @dataJogo) = 1) --Se for domingo, adiciona mais 3 dias a data do jogo
			BEGIN
				SET @dataJogo = DATEADD(DAY, 3, @dataJogo)
			END
			ELSE --Se não for domingo, adiciona mais 4 dias a data do jogo
			BEGIN
				SET @dataJogo = DATEADD(DAY, 4, @dataJogo)
			END

			SET @contRodada = @contRodada + 1
		END

		SET @loteRodadas = @loteRodadas + 1
	END
	SET @query = 'CREATE VIEW v_jogos 
				  AS 
				  SELECT (SELECT NomeTime FROM Times WHERE CodigoTime = CodigoTimeA) AS nomeTimeA, GolsTimeA AS golsTimeA,
				  GolsTimeB AS golsTimeB, (SELECT NomeTime FROM Times WHERE CodigoTime = CodigoTimeB) AS nomeTimeB, Data AS dataJogo
				  FROM Jogos'
	BEGIN TRY
		EXEC (@query)
	END TRY
	BEGIN CATCH
		RAISERROR ('Deu ruim aí amigão', 16, 1)
	END CATCH


-------------------------------------------------------------------------------------------------------------------------------------------------------------------




EXEC sp_insereTimesGrupo
EXEC sp_gerarRodadas




SELECT * FROM Grupos
SELECT * FROM Jogos
SELECT * FROM v_grupos
SELECT * FROM v_gruposComLinhasEnum
SELECT * FROM v_jogos WHERE dataJogo = '20/01/2019'


DELETE Grupos
GO
DELETE Jogos
GO
DROP VIEW v_grupos
GO
DROP VIEW v_gruposComLinhasEnum
GO
DROP VIEW v_jogos

