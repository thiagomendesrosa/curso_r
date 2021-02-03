--Estrutura de um SELECT
SELECT 
 coluna1,
 coluna2,
 .
 .
 .
 colunan
FROM esquema.tabela;

--Selecionar todas as colunas da tabela dom2018_33ras no esquema pdad
SELECT 
 * 
FROM pdad.dom2018_33ras;

--Selecionar as 5 primeiras linhas de todas as colunas da tabela dom2018_33ras no esquema pdad
SELECT 
 top 5
 * 
FROM pdad.dom2018_33ras;

--Selecionar as colunas A01ra - Região Administrativa e B03 -Qual a situação do seu domicílio? da tabela dom2018_33ras
--no esquema pdad
SELECT 
 A01ra ,
 B03 
FROM pdad.dom2018_33ras;

--Selecionar as 10 primeiras linhas das colunas A01ra - Região Administrativa e B03 -Qual a situação do seu domicílio? da tabela dom2018_33ras
--no esquema pdad
SELECT 
 top 10
 A01ra ,
 B03 
FROM pdad.dom2018_33ras;

--Somar os valores das colunas B12 - Quantos cômodos estão servindo permanentemente de dormitórios neste domicílio? e 
--B13 -Quantos banheiros e/ou sanitários têm este domicílio?
SELECT 
 B12 ,
 B13 ,
 B11 + B12 
FROM pdad.dom2018_33ras;

--Somar os valores das colunas B12 - Quantos cômodos estão servindo permanentemente de dormitórios neste domicílio? e 
--B13 -Quantos banheiros e/ou sanitários têm este domicílio? e atribuindo nome a nova coluna criada
SELECT 
 B12 ,
 B13 ,
 B12 + B13 AS qtd_dormi_banh,
 B12 + B13 AS "Qtd. de Dormitórios e banheiros"
FROM pdad.dom2018_33ras;

--Calcular o percentual de B12 - Quantos cômodos estão servindo permanentemente de dormitórios neste domicílio? em relação ao
--B11 - Quantos cômodos tem este domicílio?
SELECT 
 B12 ,
 B11 ,
 B12 / B11 * 100 AS perc_dom,
 B12 / B11 * 100 AS "Perc. de cômodos que servem como dormitórios"
FROM pdad.dom2018_33ras;

--Por que não aparece as casas decimais?
SELECT 
 B12 ,
 B11 ,
 CONVERT (float, B12) / CONVERT (float, B11) * 100 AS perc_dom,
 round(CONVERT (float, B12) / CONVERT (float, B11) * 100,2) AS "Perc. de cômodos que servem como dormitórios",
 CAST((3.1415926535897) AS NUMERIC(7,3)) "Valor de PI com duas decimais"
FROM pdad.dom2018_33ras;

--Ordenar de forma crescente informações por uma ou mais colunas
SELECT 
 A01ra ,
 B12 ,
 B11 ,
 CONVERT (float, B12) / CONVERT (float, B11) * 100 AS perc_dom,
 round(CONVERT (float, B12) / CONVERT (float, B11) * 100,2) AS "Perc. de cômodos que servem como dormitórios",
 CAST((3.1415926535897) AS NUMERIC(7,3)) "Valor de PI com duas decimais"
FROM pdad.dom2018_33ras
ORDER BY A01ra;

--Ordenar de forma decrescente informações por uma ou mais colunas
SELECT 
 A01ra ,
 B12 ,
 B11 ,
 CONVERT (float, B12) / CONVERT (float, B11) * 100 AS perc_dom,
 round(CONVERT (float, B12) / CONVERT (float, B11) * 100,2) AS "Perc. de cômodos que servem como dormitórios",
 CAST((3.1415926535897) AS NUMERIC(7,3)) "Valor de PI com duas decimais"
FROM pdad.dom2018_33ras
ORDER BY CONVERT (float, B12) / CONVERT (float, B11) * 100 DESC;

--Verificar o conteúdo de uma coluna
SELECT 
 distinct B11 
FROM pdad.dom2018_33ras
ORDER BY B11 ;

--Verificar o conteúdo de uma coluna
SELECT 
 distinct B11 , B12 
FROM pdad.dom2018_33ras
ORDER BY B11 ;

--Recodificando colunas para criar a proposta de agrupamento da PED e faixas de A01nPessoas - Nº de Pessoas no Domicílio
SELECT 
 CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
      WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
      WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
      WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
      ELSE 'Não identificado'
 END AS "Grupos PED - Proposta",
 CASE WHEN A01nPessoas IN (1) THEN 1
      WHEN A01nPessoas = 2 THEN 2
      WHEN A01nPessoas between 3 and 5 THEN 3
      ELSE 4
 END AS fx_qtd_pess
FROM pdad.dom2018_33ras;

--Selecionando informações das RA do grupo 1 da PED
SELECT 
 CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
      WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
      WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
      WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
      ELSE 'Não identificado'
 END AS "Grupos PED - Proposta",
 CASE WHEN A01nPessoas IN (1) THEN 1
      WHEN A01nPessoas = 2 THEN 2
      WHEN A01nPessoas between 3 and 5 THEN 3
      ELSE 4
 END AS fx_qtd_pess
FROM pdad.dom2018_33ras
WHERE A01ra IN (1,16,18,22,24,27) ;

--Selecionando informações de domicílios com a quantidade de pessoas variando entre 3 e 5
SELECT 
 CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
      WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
      WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
      WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
      ELSE 'Não identificado'
 END AS "Grupos PED - Proposta",
 CASE WHEN A01nPessoas IN (1) THEN 1
      WHEN A01nPessoas = 2 THEN 2
      WHEN A01nPessoas between 3 and 5 THEN 3
      ELSE 4
 END AS fx_qtd_pess
FROM pdad.dom2018_33ras
WHERE A01nPessoas between 3 and 5 ;

--Somar a quantidade de pessoas pesquisadas
SELECT 
 SUM(A01nPessoas) AS qtd_pess
FROM pdad.dom2018_33ras ;

--Somar a quantidade de pessoas estimadas
SELECT 
 SUM(FATOR_PROJ) AS qtd_pess_est,
 ROUND(SUM(FATOR_PROJ),0) AS "Nº de pessoas estimadas sem decimal"
FROM pdad.mor2018_33ras ;

--Somar a quantidade de pessoas pesquisadas por RA
SELECT 
 A01ra ,
 SUM(A01nPessoas) AS qtd_pess
FROM pdad.dom2018_33ras 
GROUP BY A01ra ;

--Somar a quantidade de pessoas estimadas por RA
SELECT 
 A01ra ,
 SUM(FATOR_PROJ) AS qtd_pess_est,
 ROUND(SUM(FATOR_PROJ),0) AS "Nº de pessoas estimadas sem decimal"
FROM pdad.mor2018_33ras 
GROUP BY A01ra ;

--Valores descritivos de G16 – Quanto o Sr(a). recebeu no mês passado do Trabalho Principal por RA
SELECT 
 A01ra ,
 MAX(G16) AS max_g16,
 MIN(G16) AS min_g16,
 AVG(G16) AS avg_g16,
 SUM(G16) AS sum_g16
FROM pdad.mor2018_33ras 
GROUP BY A01ra ;

--Os valores descritivos de G16 – Quanto o Sr(a). recebeu no mês passado do Trabalho Principal por RA estão esquisitos,vamos corrigir?
SELECT 
 A01ra ,
 MAX(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS max_g16,
 MIN(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS min_g16,
 AVG(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS avg_g16,
 SUM(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS sum_g16
FROM pdad.mor2018_33ras 
GROUP BY A01ra ;

--Valores descritivos de G16 – Quanto o Sr(a). recebeu no mês passado do Trabalho Principal por RA estão esquisitos 
--por grupos sugeridos da PED
SELECT 
 CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
      WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
      WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
      WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
      ELSE 'Não identificado'
 END AS "Grupos PED - Proposta",
 MAX(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS max_g16,
 MIN(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS min_g16,
 AVG(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS avg_g16,
 SUM(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS sum_g16
FROM pdad.mor2018_33ras 
GROUP BY CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
              WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
              WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
              WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
              ELSE 'Não identificado'
         END ;

--Vamos ver se o SQL Server considera ou exlui valores nulos do cálculo de médias?
SELECT 
 CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
      WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
      WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
      WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
      ELSE 'Não identificado'
 END AS "Grupos PED - Proposta",
 AVG(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS avg_g16,
 SUM(CASE WHEN G16 IN (77777,88888,99999) THEN 0 ELSE G16 END) AS sum_g16_sem_nulo,
 SUM(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE G16 END) AS sum_g16_com_nulo,
 SUM(CASE WHEN G16 IN (77777,88888,99999) THEN NULL ELSE 1 END) AS contagem_g16_sem_nulo,
 COUNT(1) AS contagem_g16_com_nulo
FROM pdad.mor2018_33ras 
GROUP BY CASE WHEN A01ra IN (1,16,18,22,24,27) THEN 'Grupo 1'
              WHEN A01ra IN (2,3,5,8,10,11,19,20,26,30,33) THEN 'Grupo 2'
              WHEN A01ra IN (4,6,9,12,13,14,17,21,29,32) THEN 'Grupo 3'
              WHEN A01ra IN (7,15,23,25,28,31) THEN 'Grupo 4'
              ELSE 'Não identificado'
         END ;

--Cruzamento de tabelas: Adicionar quantidade de pessoas por sexo aos domicílio
SELECT 
 d.A01nFicha ,
 SUM(CASE WHEN m.E03 = 1 THEN 1 ELSE 0 END) AS qtd_pess_m,
 SUM(CASE WHEN m.E03 = 2 THEN 1 ELSE 0 END) AS qtd_pess_f
FROM pdad.dom2018_33ras AS d
JOIN pdad.mor2018_33ras AS m
ON d.A01nFicha = m.A01nficha 
GROUP BY d.A01nFicha ;

--Cruzamento de tabelas: Adicionar quantidade de pessoas por sexo aos domicílio
SELECT 
 d.* ,
 m.qtd_pess_m,
 m.qtd_pess_f
FROM pdad.dom2018_33ras AS d
JOIN (SELECT 
       A01nFicha ,
       SUM(CASE WHEN E03 = 1 THEN 1 ELSE 0 END) AS qtd_pess_m,
       SUM(CASE WHEN E03 = 2 THEN 1 ELSE 0 END) AS qtd_pess_f
      FROM pdad.mor2018_33ras
      GROUP BY A01nFicha) AS m
ON d.A01nFicha = m.A01nficha ;

