@echo off
REM - INICIO.

REM - APRESENTAÇÃO.
echo. 
echo.-----------------------------------------------------------------
echo.-------------------------- [TurBoy] -----------------------------
echo.-----------------------------------------------------------------
echo.- BAIXE VIDEOS E LEGENDAS[SRT] DE CANAIS E PLAYLISTS DO YOUTUBE -
echo.------------------------- EM SEU IDIOMA -------------------------
echo.--------------------------- DE UMA VEZ --------------------------
echo.----------------------- ! COM UM CLIQUE ! -----------------------
echo.-----------------------------------------------------------------
echo.Versao 1.0.0 ----------------------------------------------------
echo.DeV: oSToN PraTa. -----------------------------------------------
echo.DaTa: BRaSiLia, 22 De MaRCo De 2022. ----------------------------
echo.LiNK Bio: https://linktr.ee/ostonprata --------------------------
echo.-----------------------------------------------------------------
echo. 

REM - CHECANDO A EXISTENCIA DO ARQUIVO QUE CONTEM AS URL.
if exist "uRL-youTuBe.TXT" (
goto :arquivoExiste
) else (
goto :arquivoNaoExiste
)

REM - MENU 01.
:arquivoExiste
echo. 
echo.ESCOLHA UMA DAS OPCOES:
echo.[1] CoNTiNuaR CoM aNTiGa LiSTa De uRL De CaNaiS, ou De PLayLiST, ou De ViDeoS.
echo.[2] CRiaR uMa NoVa LiSTa De uRL De CaNaiS, ou De PLayLiST, ou De ViDeoS.
echo. 

set /p "primeiroMenuOpcao=OPCAO: "
if /i "%primeiroMenuOpcao%"=="1" (
goto :querAdicionarMais
)

REM - DELETANDO O ARQUIVO QUE CONTEM AS URL.
del uRL-youTuBe.TXT

REM - ACRESCENTANDO MAIS URL A ANTIGA OU NOVA LISTA.
:arquivoNaoExiste
:adicionarMais
echo. 
set /p "urlplaylist=CoLe a uRL Do CaNaL, ou Da PLayLiST, ou De ViDeo AQui : "
echo. 
yT-DLP.eXe --get-id %urlplaylist% >> uRL-youTuBe.TXT
:querAdicionarMais
echo. 
set /p "Pergunta=ACReSCeNTaR MaiS uRL? [s]im / [n]ao : "
if /i "%Pergunta%"=="s" (
goto :adicionarMais
)

REM - MENU 02.
echo. 
echo.ESCOLHA UMA DAS OPCOES:
echo.[1] BaiXaR SoMeNTe ViDeo.
echo.[2] BaiXaR SoMeNTe LeGeNDa.
echo.[3] BaiXaR ViDeo e LeGeNDa.
echo.[4] SaiR
echo. 

set /p "segundoMenuOpcao=OPCAO: "

if /i "%segundoMenuOpcao%"=="1" (
	set verdadeiroFalso1=verdadeiro
	set verdadeiroFalso2=falso
	goto :baixarVideo
)

if /i "%segundoMenuOpcao%"=="2" (
	set verdadeiroFalso1=falso
	set verdadeiroFalso2=verdadeiro
	goto :baixarLegenda
)

if /i "%segundoMenuOpcao%"=="3" (
	set verdadeiroFalso1=verdadeiro
	set verdadeiroFalso2=verdadeiro
	goto :baixarVideoLegenda
)

if /i "%segundoMenuOpcao%"=="4" (
	set verdadeiroFalso1=falso
	set verdadeiroFalso2=falso
	goto :saidoPrograma
)

REM - ESCOLHENDO IDIOMAS.
:baixarLegenda
:baixarVideoLegenda
echo. 
echo.iDioMa DaS LeGeNDaS
echo. 
set /p "idioma=DiGiTe a [TaG] Do Seu iDioMa eM [minusculo]: [pt] ou [en] ou [uk] ou [fr] ou ... : "
echo. 

REM - CRIANDO PASTA DO DOWNLOAD.
:baixarVideo
echo. 
echo.CRiaNDo PaSTa
echo. 
set /p "pasta=DiGiTe o NoMe Da PaSTa : "
echo. 
mkdir %pasta%
cd %pasta%

REM - INICIANDO OS PROCESSOS...
echo. 
echo.[INICIANDO...]
echo. 

REM - PERMITE O USO DE VARIÁVEIS DENTRO DO COMANDO FOR.
setlocal enabledelayedexpansion

REM - JOGO DE CONDIÇÕES [SIMULANDO O OPERADOR LÓGICO AND / OR].
if /i "%verdadeiroFalso1%"=="verdadeiro" (
	if /i "%verdadeiroFalso2%"=="verdadeiro" (
		REM - INÍCIO DO LAÇO FOR.
		REM - LENDO TODAS AS LINHAS DO ARQUIVO DE TEXTO QUE CONTÉM AS URL.
		REM - FAZENDO OS DOWNLOADS.
		for /f "tokens=* delims= " %%a in (..\uRL-youTuBe.TXT) do (
		..\yT-DLP.eXe --sub-lang %idioma% --write-sub --write-auto-sub --skip-download %%a
		..\yT-DLP.eXe %%a
		)
		REM - FIM DO LAÇO FOR.

		REM - INÍCIO DO LAÇO FOR.
		REM - CONVERTENDO .VTT PARA .SRT.
		for %%b in (*.vtt) do (
		..\FFMPeG.eXe -i "%%b" "%%b.srt"
		del "%%b"
		)
		REM - FIM DO LAÇO FOR.

	) else (
		REM - INÍCIO DO LAÇO FOR.
		REM - LENDO TODAS AS LINHAS DO ARQUIVO DE TEXTO QUE CONTÉM AS URL.
		REM - FAZENDO OS DOWNLOADS.
		for /f "tokens=* delims= " %%a in (..\uRL-youTuBe.TXT) do (
		..\yT-DLP.eXe %%a
		)
		REM - FIM DO LAÇO FOR.
	)
) else (
	if /i "%verdadeiroFalso2%"=="verdadeiro" (
		REM - INÍCIO DO LAÇO FOR.
		REM - LENDO TODAS AS LINHAS DO ARQUIVO DE TEXTO QUE CONTÉM AS URL.
		REM - FAZENDO OS DOWNLOADS.
		for /f "tokens=* delims= " %%a in (..\uRL-youTuBe.TXT) do (
		..\yT-DLP.eXe --sub-lang %idioma% --write-sub --write-auto-sub --skip-download %%a
		)
		REM - FIM DO LAÇO FOR.

		REM - INÍCIO DO LAÇO FOR.
		REM - CONVERTENDO .VTT PARA .SRT.
		for %%b in (*.vtt) do (
		..\FFMPeG.eXe -i "%%b" "%%b.srt"
		del "%%b"
		)
		REM - FIM DO LAÇO FOR.

	) else (
		goto :saidoPrograma
	)
)


REM - SAIR DO PROGRAMA.
:saidoPrograma

REM - MENSAGEM NA TELA FIM.
echo.
echo.[...FIM]
echo.
echo.TeCLe PaRa SaiR

pause>nul
REM - FIM.