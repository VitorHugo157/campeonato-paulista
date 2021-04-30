USE campeonato

-- Trigger que não permite INSERT, UPDATE e DELETE na tabela Times
CREATE TRIGGER t_times ON Times
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Ação não permitida para a tabela Times', 16, 1)
END

GO

-- Trigger que não permite INSERT, UPDATE e DELETE na tabela Grupos
CREATE TRIGGER t_grupos ON Grupos
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Ação não permitida para a tabela Grupos', 16, 1)
END

GO

-- Trigger que não permite INSERT e DELETE na tabela Jogos
CREATE TRIGGER t_jogos ON Jogos
FOR INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Ação não permitida para a tabela Jogos', 16, 1)
END

GO

-- Procedure que atualiza o placar dos Jogos
CREATE PROCEDURE sp_atualizaJogos(@nomeTimeA VARCHAR(100), @nomeTimeB VARCHAR(100), @golsTimeA INT, @golsTimeB INT, @dataJogo DATE)
AS
	DECLARE @codigoTimeA INT,
			@codigoTimeB INT,
			@query VARCHAR(MAX)
	SET @codigoTimeA = (SELECT CodigoTime FROM Times WHERE NomeTime = @nomeTimeA)
	SET @codigoTimeB = (SELECT CodigoTime FROM Times WHERE NomeTime = @nomeTimeB)

	UPDATE Jogos
	SET GolsTimeA = @golsTimeA, GolsTimeB = @golsTimeB
	WHERE CodigoTimeA = @codigoTimeA AND CodigoTimeB = @codigoTimeB AND Data = @dataJogo

	EXEC sp_criarViewJogosComId

GO


-- Procedure que cria uma view com os jogos já realizados, para auxiliar a function que gera os dados dos times
CREATE PROCEDURE sp_criarViewJogosComId
AS
	DECLARE @query VARCHAR(MAX)

	IF(Object_ID('v_jogosComId') IS NOT NULL)
	BEGIN
		DROP VIEW v_jogosComId
	END
	SET @query = 'CREATE VIEW v_jogosComId 
	AS 
	SELECT ROW_NUMBER() OVER(ORDER BY Data ASC) AS idJogo, CodigoTimeA, CodigoTimeB, GolsTimeA, GolsTimeB 
	FROM Jogos 
	WHERE GolsTimeA IS NOT NULL AND GolsTimeB IS NOT NULL'

	BEGIN TRY
		EXEC (@query)
	END TRY
	BEGIN CATCH
		RAISERROR ('Deu ruim aí amigão', 16, 1)
	END CATCH
	



GO


-- Função que gera os dados dos jogos para a classificação geral ou grupo 
CREATE FUNCTION fn_jogosDisputadosTime(@codigoTime INT)
RETURNS @table TABLE(
nome_time VARCHAR(100),
pontos INT,
num_jogos_disputados INT,
vitorias INT,
empates INT,
derrotas INT,
gols_marcados INT,
gols_sofridos INT, 
saldo_gols INT
)
AS
BEGIN
    DECLARE @nome_time VARCHAR(100),
			@num_jogos_disputados INT,
			@vitorias INT,
			@empates INT,
            @derrotas INT,
            @gols_mandante INT,
            @gols_visitante INT,
			@gols_marcados INT,
			@gols_sofridos INT,
			@saldo_gols INT,
            @pontos INT,
			@cont INT,
			@num_jogos_campeonato INT

	SET @num_jogos_disputados = 0
	SET @vitorias = 0
	SET @empates = 0
    SET @derrotas = 0
	SET @pontos = 0
	SET @gols_marcados = 0
	SET @gols_sofridos = 0

	SET @cont = 1
	SET @num_jogos_campeonato = (SELECT MAX(idJogo) FROM v_jogosComId) + 1

    WHILE(@cont < @num_jogos_campeonato)
	BEGIN
	
		SET @gols_mandante = (SELECT GolsTimeA FROM v_jogosComId WHERE idJogo = @cont)
        SET @gols_visitante = (SELECT GolsTimeB FROM v_jogosComId WHERE idJogo = @cont)
            
		-- Se o time jogou como mandante
        IF(@codigoTime = (SELECT CodigoTimeA FROM v_jogosComId WHERE idJogo = @cont))
        BEGIN
			IF(@gols_mandante > @gols_visitante)
            BEGIN
				SET @vitorias = @vitorias + 1
                SET @pontos = @pontos + 3
            END
            ELSE
			BEGIN
				IF(@gols_mandante < @gols_visitante)
                BEGIN
					SET @derrotas = @derrotas + 1
                END
                ELSE
                BEGIN
					SET @empates = @empates + 1
                    SET @pontos = @pontos + 1
                END
			END
			SET @gols_marcados = @gols_marcados + @gols_mandante
			SET @gols_sofridos = @gols_sofridos + @gols_visitante
			SET @num_jogos_disputados = @num_jogos_disputados + 1
        END
		-- Senão o time jogou como visitante
        ELSE
		BEGIN
			IF(@codigoTime = (SELECT CodigoTimeB FROM v_jogosComId WHERE idJogo = @cont))
			BEGIN
				IF(@gols_visitante > @gols_mandante)
				BEGIN
					SET @vitorias = @vitorias + 1
					SET @pontos = @pontos + 3
				END
				ELSE
				BEGIN
					IF(@gols_visitante < @gols_mandante)
					BEGIN
						SET @derrotas = @derrotas + 1
					END
					ELSE
					BEGIN
						SET @empates = @empates + 1
						SET @pontos = @pontos + 1
					END
				END
				SET @gols_marcados = @gols_marcados + @gols_visitante
				SET @gols_sofridos = @gols_sofridos + @gols_mandante
				SET @num_jogos_disputados = @num_jogos_disputados + 1
			END
		END
		SET @cont = @cont + 1
    END

    SET @saldo_gols = @gols_marcados - @gols_sofridos
	SET @nome_time = (SELECT NomeTime FROM Times WHERE CodigoTime = @codigoTime)

    INSERT INTO @table
    SELECT @nome_time, @pontos, @num_jogos_disputados, @vitorias, @empates, @derrotas, @gols_marcados, @gols_sofridos, @saldo_gols
        
    RETURN
END



GO


-- Função que mostra a classificação geral
CREATE FUNCTION fn_classificacaoGeral()
RETURNS @table1 TABLE(
nome_time VARCHAR(100),
pontos INT,
num_jogos_disputados INT,
vitorias INT,
empates INT,
derrotas INT,
gols_marcados INT,
gols_sofridos INT, 
saldo_gols INT
)	
AS
BEGIN
	
	DECLARE @cont INT,
			@codigoTime INT,
			@linhaGrupo INT

	SET @cont = 1
	SET @linhaGrupo = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum)


	WHILE(@cont < 17)
    BEGIN
		SET @codigoTime = (SELECT CodigoTime FROM v_gruposComLinhasEnum WHERE numLinhaTime = @linhaGrupo)
        INSERT INTO @table1 SELECT * FROM fn_jogosDisputadosTime(@codigoTime)

		SET @linhaGrupo = @linhaGrupo + 1
		SET @cont = @cont + 1
    END

	RETURN
END



GO


-- Função que mostrar a classificação de cada grupo
CREATE FUNCTION fn_classificacaoGrupo(@grupo CHAR(1))
RETURNS @table1 TABLE(
nome_time VARCHAR(100),
pontos INT,
num_jogos_disputados INT,
vitorias INT,
empates INT,
derrotas INT,
gols_marcados INT,
gols_sofridos INT, 
saldo_gols INT
)	
AS
BEGIN

	DECLARE @cont INT,
			@codigoTime INT,
			@linhaGrupo INT

	SET @cont = 1
	SET @linhaGrupo = (SELECT TOP 1 numLinhaTime FROM v_gruposComLinhasEnum WHERE Grupo = @grupo)


	WHILE(@cont < 5)
    BEGIN
		SET @codigoTime = (SELECT CodigoTime FROM v_gruposComLinhasEnum WHERE numLinhaTime = @linhaGrupo)
        INSERT INTO @table1 SELECT * FROM fn_jogosDisputadosTime(@codigoTime)

		SET @linhaGrupo = @linhaGrupo + 1
		SET @cont = @cont + 1
    END

	RETURN
END


GO


-- Function que mostra as quartas de finais
CREATE FUNCTION fn_quartasFinais()
RETURNS @table TABLE(
nomeTime VARCHAR(100)
)
AS
BEGIN
	DECLARE @cont INT,
			@grupo CHAR(1),
			@grupos VARCHAR(4)

	SET @cont = 0
	SET @grupos = 'ABCD'

	WHILE(@cont < 4)
	BEGIN
		SET @grupo = (SELECT SUBSTRING(@grupos, 1, 1))
		
		INSERT INTO @table
		SELECT TOP 2 nome_time FROM fn_classificacaoGrupo(@grupo) ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC, nome_time ASC

		SET @grupos = (SELECT REPLACE(@grupos, @grupo, ''))
		SET @cont = @cont + 1
	END

	RETURN
END





-- Testes
SELECT * FROM v_jogosComId
SELECT * FROM fn_jogosDisputadosTime(3)
SELECT * FROM fn_classificacaoGeral() ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
SELECT * FROM fn_classificacaoGrupo('A') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC, nome_time ASC
SELECT * FROM fn_quartasFinais()

SELECT * FROM Times
SELECT * FROM Grupos
SELECT * FROM Jogos
ORDER BY Data ASC

