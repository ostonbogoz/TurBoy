@echo off
REM - INICIO.


REM - [ENTENDENDO OS ESCOPOS DAS VARIÁVEIS]
REM - set variável...for (...%variável%...ou...!variável!...), set variável...if (...%variável%...ou...!variável!...)
REM - for (...set variável...)...%variável%...ou...!variável!..., if (...set variável...)...%variável%...ou...!variável!...
REM - for (set variável...!variável!...), if (set variável...!variável!...)
REM - for (set variável...!variável!...)...if (...!variável!...), if (set variável...!variável!...)...for (...!variável!...)


REM - PERMITE O USO DE VARIÁVEIS DENTRO DO CORPO DE COMANDOS: 
REM - comando (...%variavel% ou !variavel!...)
REM - if (...%variavel% ou !variavel!...)
REM - for (...%variavel% ou !variavel!...)
setlocal enabledelayedexpansion


REM - APRESENTAÇÃO.
echo. 
echo. 
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.-------------------------- [TurBoy] -----------------------------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.- BAIXE VIDEOS E LEGENDAS[SRT] DE CANAIS E PLAYLISTS DO YOUTUBE -
echo.-----------------------------------------------------------------
echo.------------------------- EM SEU IDIOMA -------------------------
echo.-----------------------------------------------------------------
echo.--------------------------- DE UMA VEZ --------------------------
echo.-----------------------------------------------------------------
echo.--------------------- COM POUCOS CLIQUES ------------------------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.Versao 1.0.0 ----------------------------------------------------
echo.DeV: oSToN PraTa. -----------------------------------------------
echo.DaTa: BRaSiLia, 22 De MaRCo De 2022. ----------------------------
echo.LiNK Bio: https://linktr.ee/ostonprata --------------------------
echo.Repositorio/Help: https://github.com/ostonprata/TurBoy ----------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo. 
echo. 


REM - CHECANDO A EXISTENCIA DO ARQUIVO QUE CONTEM AS URL.
REM - SE TRATANDO PADRÃO WINDOWS, TUDO QUE FOR PARTE DE SISTEMA DE ARQUIVOS COLOCA AS DUPLAS EM VOLTA DO OBJETO, SEJA "ARQUIVOS", "PATH"...
if exist "uRL-youTuBe.TXT" (
goto :arquivoExiste
) else (
goto :arquivoNaoExiste
)


REM - MENU 01.
:arquivoExiste
echo. 
echo.[1] CoNTiNuaR CoM a aNTiGa LiSTa eXiSTeNTe DaS uRL.
echo.[2] CRiaR uMa NoVa [SoBreSCReVeNDo a aNTiGa LiSTa] DaS uRL.
echo. 
set /p "primeiroMenuOpcao=OPCAO : "
if "%primeiroMenuOpcao%"=="1" (
goto :querAdicionarMais
)
REM - DELETANDO O ARQUIVO QUE CONTEM AS URL.
REM - SE TRATANDO PADRÃO WINDOWS, TUDO QUE FOR PARTE DE SISTEMA DE ARQUIVOS COLOCA AS DUPLAS EM VOLTA DO OBJETO, SEJA "ARQUIVOS", "PATH"...
del "uRL-youTuBe.TXT"


REM - ACRESCENTANDO MAIS URL A ANTIGA OU NOVA LISTA.
:arquivoNaoExiste
:adicionarMais
echo. 
set /p "urlplaylist=uRL Do CaNaL, ou Da PLayLiST, ou De ViDeo : "
echo.
REM - AS ASPAS DUPLAS EM TORNO DA VARIÁVEL É PARA ENVIAR O VALOR EM TORNO DAS ASPAS DUPLAS PARA O ARQUIVO.
REM - SE TRATA DE PATH OU CAMINHO COMPLETO DO WINDOWS É OBRIGATÓRIO COLOCAR ASPAS DUPLAS EM TORNO DO "PATH".
echo "%urlplaylist%" >> "uRL-youTuBe.TXT"
:querAdicionarMais
echo. 
set /p "Pergunta=ACReSCeNTaR MaiS uRL? [s]im / [n]ao : "
if /i "%Pergunta%"=="s" (
goto :adicionarMais
)


REM - MENU 02.
echo. 
echo.OPCOES DE DOWNLOAD:
echo.[1] BaiXaR SoMeNTe ViDeo
echo.[2] BaiXaR SoMeNTe LeGeNDa
echo.[3] BaiXaR ViDeo e LeGeNDa
echo.[4] SaiR
echo. 
set /p "segundoMenuOpcao=OPCAO : "
if "%segundoMenuOpcao%"=="1" (
	goto :baixarVideo
)
if "%segundoMenuOpcao%"=="2" (
	goto :baixarLegenda
)
if "%segundoMenuOpcao%"=="3" (
	goto :baixarVideoLegenda
)
if "%segundoMenuOpcao%"=="4" (
	goto :saidoPrograma
)


REM - ESCOLHENDO IDIOMAS.
:baixarLegenda
:baixarVideoLegenda
echo. 
echo. 
set /p "idioma=iDioMa DaS LeGeNDaS [TaG]: [pt] [en] [uk] [fr] ... : "
echo. 
REM - O VALOR E ATRIBUIDO JUNTO COM UMA !VARIÁVEL!, POR QUE O SEU VALOR VAI SER CHAMADO DENTRO DO CORPO for...(...CORPO...)
set "comandosIdioma=--write-sub --write-auto-sub --skip-download --sub-lang %idioma%"


REM - MENU 03.
:baixarVideo
if "%segundoMenuOpcao%"=="1" (
	set "escolherResolucao=sim"
) else (
	if "%segundoMenuOpcao%"=="3" (
		set "escolherResolucao=sim"
	)	
)
if /i "%escolherResolucao%"=="sim" (
	echo. 
	echo.OPCOES DE VIDEO:
	echo.[1] MeLHoR QuaLiDaDe
	echo.[2] Video Aulas
	echo.[3] WhatsApp [MaX 3MiN]
	echo. 

	set /p "resolucao=OPCAO: "
	
	if "!resolucao!"=="1" (
		set "comandosResolucao=--format "bestvideo^*^+bestaudio/best""
	)
	if "!resolucao!"=="2" (
		set "comandosResolucao=--format "best[height^<=720][fps^<=30][abr^<=128]""
	)
	if "!resolucao!"=="3" (
		set "comandosResolucao=--format "[filesize^<=16M]""
	)
)


REM - NUMERAR CANAIS E PLAYLISTS?
echo. 
set /p "numerar=NuMeRaR ArQuiVoS? [s]im / [n]ao : "
if /i "%numerar%"=="s" (
	set "comandosNumerar=[%%(playlist_autonumber)s][%%(title)s]"
) else (
	set "comandosNumerar=[%%(title)s]"
)


REM - ESCOLHENDO A PASTA AONDE BAI SER BAIXADO.
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'[AONDE BAIXAR...]',0,0x11).self.path""
for /f "usebackq delims=" %%a in (`powershell %psCommand%`) do (
	set "comandoPasta=%%a"
)


REM - CRIANDO OS COMANDOS
REM - O VALOR E ATRIBUIDO JUNTO COM UMA !VARIÁVEL!, POR QUE O SEU VALOR VAI SER CHAMADO DENTRO DO CORPO for...(...CORPO...)
set "comandosPadrao=--continue --no-overwrites --windows-filenames --restrict-filenames --output-na-placeholder SemPlayLisT --output "!comandoPasta!/%%(channel)s/%%(playlist)s/!comandosNumerar!.%%(ext)s""


REM - INICIANDO OS PROCESSOS...
echo. 
echo. 
echo.[INICIANDO...]
echo. 
echo. 


REM - INÍCIO DO LAÇO FOR.
REM - LENDO TODAS AS LINHAS DO ARQUIVO DE TEXTO QUE CONTÉM AS URL.
REM - FAZENDO OS DOWNLOADS.
REM - NO CORPO DO IN(...) DO COMANDO FOR SE TRATANDO DE ARQUIVO OU PATH NÃO ACEITA ENTRE ASPAS DUPLAS 
REM - EXEMPLO ERRADO:  for /f "..." %%a in ("arquivo.ext")
REM - EXEMPLO CORRETO: for /f "..." %%a in (arquivo.ext)
for /f "tokens=* delims= " %%b in (uRL-youTuBe.TXT) do (
	set "tempPlayList=%%b"

	if not "!tempPlayList!"=="!tempPlayList:playlist=!" (
		set "OnOffPlayList=--no-playlist-reverse"
	) else (
		set "OnOffPlayList=--playlist-reverse"
	)

	if "%segundoMenuOpcao%"=="1" (
	
		yT-DLP.eXe %%b !OnOffPlayList! !comandosResolucao! %comandosPadrao%
	)

	if "%segundoMenuOpcao%"=="2" (

		yT-DLP.eXe %%b !OnOffPlayList! %comandosIdioma% %comandosPadrao%
	)

	if "%segundoMenuOpcao%"=="3" (

		yT-DLP.eXe %%b !OnOffPlayList! !comandosResolucao! %comandosPadrao%
		yT-DLP.eXe %%b !OnOffPlayList! %comandosIdioma% %comandosPadrao%
	)
)
REM - FIM DO LAÇO FOR.
REM - INÍCIO DO LAÇO FOR.
REM - CONVERTENDO .VTT PARA .SRT.


REM - SE O VALOR FOR UM LOCAL OU PATH TEM QUE SER JUNTO COM ASPAS DUPLAS "VARIÁVEL"
set "comandoPastaAspasDuplas="%comandoPasta%""

if not "%idioma%"=="" (

	REM - COMANDO FOR NÃO ACEITA !VARIÁVEL!, SOMENTE %VARIÁVEL%
	REM - ESTOU FALANDO DO COMANDO E NÃO DO SEU CORPO "for ...COMANDO... ( ...CORPO...)".
	REM - ACREDITO QUE TODOS OS COMANDO DE ESTRUTURA NÃO ACEITA COMO: if(...), for(...)...
	for /r %comandoPastaAspasDuplas% %%c in (*.vtt) do (
		FFMPeG.eXe -y -i "%%c" "%%c.srt"
		del "%%c"
	)
	REM - FIM DO LAÇO FOR.
)


REM - SAIR DO PROGRAMA.
:saidoPrograma
REM - MENSAGEM NA TELA FIM.
echo.
echo.
echo.[...FIM]
echo.
echo.


endlocal


pause


exit
REM - FIM.