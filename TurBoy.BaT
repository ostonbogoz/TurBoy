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
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.-------------------------- [TurBoy] -----------------------------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.----- BAIXAR VIDEO, AUDIO[MP3] E LEGENDA[SRT] EM SEU IDIOMA -----
echo.-----------------------------------------------------------------
echo.--------- DE PLAYLISTS E DE CANAIS INTEIROS DO YOUTUBE ----------
echo.-----------------------------------------------------------------
echo.---------- SISTEMA DE PASTAS ORGANIZADAS E NUMERADAS ------------
echo.-----------------------------------------------------------------
echo.-------- [MENU] COMPLETO, FACIL, SIMPLES E INTERATIVO -----------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.Versao 1.0.0 ----------------------------------------------------
echo.DeV: oSToN PraTa. -----------------------------------------------
echo.DaTa: BRaSiLia, 22 De MaRCo De 2022. ----------------------------
echo.RePoSiToRio/DoCuMeNTaCao: https://github.com/ostonprata/TurBoy --
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.[LEIA] a DoCuMeNTaCao PaRa TeR MeLHoR aPRoVeiTaMeNTo No TurBoy. -
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo. 


REM - CHECANDO A EXISTENCIA DO ARQUIVO QUE CONTEM AS URL.
REM - SE TRATANDO PADRÃO WINDOWS, TUDO QUE FOR PARTE DE SISTEMA DE ARQUIVOS COLOCA AS DUPLAS EM VOLTA DO OBJETO, SEJA "ARQUIVOS", "PATH"...
if exist "binarios-datas\uRL-youTuBe.TXT" (
	goto :arquivoExiste
) else (
	goto :arquivoNaoExiste
)


:menu01
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
if "%primeiroMenuOpcao%"=="2" (
	goto :deletarLista
)
cls
echo.
echo.DiGiTe uMa oPCao VaLiDa
echo.
goto :menu01


:deletarLista
REM - DELETANDO O ARQUIVO QUE CONTEM AS URL.
REM - SE TRATANDO PADRÃO WINDOWS, TUDO QUE FOR PARTE DE SISTEMA DE ARQUIVOS COLOCA AS DUPLAS EM VOLTA DO OBJETO, SEJA "ARQUIVOS", "PATH"...
del "binarios-datas\uRL-youTuBe.TXT"


REM - ACRESCENTANDO MAIS URL A ANTIGA OU NOVA LISTA.
:arquivoNaoExiste
:adicionarMais
echo. 
set /p "url=uRL Do CaNaL, ou Da PLayLiST, ou De ViDeo : "
echo.
REM - CHECANDO VALIDADE DO LINK
if "%url%"=="%url:https://www.youtube.com/= %" (
	goto :urlInvalido
) 
set "totalString=%url%"
set /a contador=0
:testeString
if "%totalString%"=="" (
	goto :checarTamanho
)
set totalString=%totalString:~,-1%
set /a contador=%contador%+1
goto :testeString
:checarTamanho
if not "%url%"=="%url:channel= %" (
	if !contador! equ 56 (
		goto :urlValido
	) 
	if !contador! equ 65 (
		goto :urlValido
	) 
	if !contador! equ 63 (
		goto :urlValido
	) 
	if !contador! equ 66 (
		goto :urlValido
	) 
)
if not "%url%"=="%url:watch?v= %" (
	if !contador! equ 43 (
		goto :urlValido
	) 
)
if not "%url%"=="%url:playlist?list= %" (
	if !contador! equ 72 (
		goto :urlValido
	) 
)
if not "%url%"=="%url:user= %" (
	if !contador! lss 30 (
		goto :urlInvalido
	) 
)
if not "%url%"=="%url:videos= %" (
	if !contador! lss 34 (
		goto :urlInvalido
	) 
)
if not "%url%"=="%url:featured= %" (
	if !contador! lss 36 (
		goto :urlInvalido
	) 
)
if not "%url%"=="%url:playlists= %" (
	if !contador! lss 37 (
		goto :urlInvalido
	) 
)
:urlInvalido
cls
echo.
echo.DiGiTe uMa uRL YouTuBe VaLiDa
echo.
goto :adicionarMais


:urlValido
set "contemURL=nao"
if exist "binarios-datas\uRL-youTuBe.TXT" (
	for /f "tokens=* delims= " %%x in (binarios-datas\uRL-youTuBe.TXT) do (

		set "tratandoX1=%%x"
		set "tratandoX2=!tratandoX1: =!"

		set "tratandoURL="!url!""

		if /i "!tratandoURL!"=="!tratandoX2!" (
			set "contemURL=sim"
		)
	)

	if /i "!contemURL!"=="sim" (
			cls

			echo.
			echo.URL eXiSTeNTe Na LiSTa
			echo.

			goto :adicionarMais
		) else (
			goto :urlInexistente
		)
) else (
	goto :urlInexistente
)
REM - AS ASPAS DUPLAS EM TORNO DA VARIÁVEL É PARA ENVIAR O VALOR EM TORNO DAS ASPAS DUPLAS PARA O ARQUIVO.
REM - SE TRATA DE PATH OU CAMINHO COMPLETO DO WINDOWS É OBRIGATÓRIO COLOCAR ASPAS DUPLAS EM TORNO DO "PATH".
:urlInexistente
echo "%url%" >> "binarios-datas\uRL-youTuBe.TXT"
:querAdicionarMais
echo. 
set /p "Pergunta=ACReSCeNTaR MaiS uRL? [s]im / [n]ao : "
if /i "%Pergunta%"=="s" (
goto :adicionarMais
)
if /i "%Pergunta%"=="n" (
goto :menu02
)
cls
echo.
echo.DiGiTe uMa oPCao VaLiDa
echo.
goto :querAdicionarMais


:menu02
REM - MENU 02.
echo. 
echo.OPCOES DE DOWNLOAD:
echo.[1] BaiXaR auDio
echo.[2] BaiXaR ViDeo
echo.[3] BaiXaR LeGeNDa
echo.[4] BaiXaR ViDeo e LeGeNDa
echo.[5] SaiR
echo. 
set /p "segundoMenuOpcao=OPCAO : "
if "%segundoMenuOpcao%"=="1" (
	goto :baixarAudio
)
if "%segundoMenuOpcao%"=="2" (
	goto :baixarVideo
)
if "%segundoMenuOpcao%"=="3" (
	goto :baixarLegenda
)
if "%segundoMenuOpcao%"=="4" (
	goto :baixarVideoLegenda
)
if "%segundoMenuOpcao%"=="5" (
	goto :saidoPrograma
)
cls
echo.
echo.DiGiTe uMa oPCao VaLiDa
echo.
goto :menu02


REM - ESCOLHENDO IDIOMAS.
:idiomaInexistente
:baixarLegenda
:baixarVideoLegenda
if exist "binarios-datas\TaGS-iDioMaS.TXT" (
	set "contemIdioma=nao"

	echo. 
	set /p "idioma=iDioMa DaS LeGeNDaS [TaG]: [pt] [en] [uk] [fr] ... : "
	echo.

	for /f "tokens=* delims= " %%z in (binarios-datas\TaGS-iDioMaS.TXT) do (

		set "tratandoZ1=%%z"
		set "tratandoZ2=!tratandoZ1: =!"

		set "tratandoIdioma=!idioma!"

		if /i "!tratandoIdioma!"=="!tratandoZ2!" (
			set "contemIdioma=sim"
		)
	)

	if /i "!contemIdioma!"=="sim" (
			goto :idiomaExistente
		) else (
			cls

			echo.
			echo.[TaG] Idioma iNeXiSTeNTe
			echo.

			goto :idiomaInexistente
		)
) else (
	cls

	echo.
	echo.aRQuiVo De LiSTa De [TaG] Idioma DaNiFiCaDo ou iNeXiSTeNTe
	echo.

	goto :saidoPrograma
)
:idiomaExistente
REM - O VALOR E ATRIBUIDO JUNTO COM UMA !VARIÁVEL!, POR QUE O SEU VALOR VAI SER CHAMADO DENTRO DO CORPO for...(...CORPO...)
set "comandosIdioma=--write-sub --write-auto-sub --skip-download --sub-lang %idioma%"


:baixarVideo
REM - MENU 03.
set "escolherResolucao=nao"
if "%segundoMenuOpcao%"=="2" (
	set "escolherResolucao=sim"
) else (
	if "%segundoMenuOpcao%"=="4" (
		set "escolherResolucao=sim"
	)	
)
if /i "%escolherResolucao%"=="sim" (
	:menu03
	echo. 
	echo.OPCOES DE VIDEO:
	echo.[1] MeLHoR QuaLiDaDe
	echo.[2] ViDeo AuLa
	echo.[3] WHaTSaPP [MaX 3MiN]
	echo.[4] SaiR
	echo. 

	set /p "resolucao=OPCAO: "
	
	if "!resolucao!"=="1" (
		set "comandosResolucao=--format "bestvideo^*^+bestaudio/best""
		goto :menuNumerar
	)
	if "!resolucao!"=="2" (
		set "comandosResolucao=--format "best[height^<=720][fps^<=30][abr^<=128]""
		goto :menuNumerar
	)
	if "!resolucao!"=="3" (
		set "comandosResolucao=--format "[filesize^<=16M]""
		goto :menuNumerar
	)
	if "!resolucao!"=="4" (
		goto :saidoPrograma
	)

	cls
	echo.
	echo.DiGiTe uMa oPCao VaLiDa
	echo.
	goto :menu03
)


:baixarAudio
set "comandosAudio=--format "bestaudio""


:menuNumerar
REM - NUMERAR CANAIS E PLAYLISTS?
echo. 
set /p "numerar=NuMeRaR ArQuiVoS? [s]im / [n]ao : "
if /i "%numerar%"=="s" (
	set "comandosNumerar=[%%(playlist_autonumber)s][%%(title)s]"
	goto :escolherAondeBaixar
) 
if /i "%numerar%"=="n" (
	set "comandosNumerar=[%%(title)s]"
	goto :escolherAondeBaixar
)
cls
echo.
echo.DiGiTe uMa oPCao VaLiDa
echo.
goto :menuNumerar


:escolherAondeBaixar
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


cls


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
for /f "tokens=* delims= " %%b in (binarios-datas\uRL-youTuBe.TXT) do (
	set "tempPlayList=%%b"

	if not "!tempPlayList!"=="!tempPlayList:playlist=!" (
		set "OnOffPlayList=--no-playlist-reverse"
	) else (
		set "OnOffPlayList=--playlist-reverse"
	)

	if "%segundoMenuOpcao%"=="1" (
	
		binarios-datas\yT-DLP.eXe %%b !OnOffPlayList! %comandosAudio% %comandosPadrao%
	)

	if "%segundoMenuOpcao%"=="2" (
	
		binarios-datas\yT-DLP.eXe %%b !OnOffPlayList! !comandosResolucao! %comandosPadrao%
	)

	if "%segundoMenuOpcao%"=="3" (

		binarios-datas\yT-DLP.eXe %%b !OnOffPlayList! %comandosIdioma% %comandosPadrao%
	)

	if "%segundoMenuOpcao%"=="4" (

		binarios-datas\yT-DLP.eXe %%b !OnOffPlayList! !comandosResolucao! %comandosPadrao%
		binarios-datas\yT-DLP.eXe %%b !OnOffPlayList! %comandosIdioma% %comandosPadrao%
	)
)
REM - FIM DO LAÇO FOR.
REM - INÍCIO DO LAÇO FOR.
REM - CONVERTENDO .VTT PARA .SRT.


REM - SE O VALOR FOR UM LOCAL OU PATH TEM QUE SER JUNTO COM ASPAS DUPLAS "VARIÁVEL"
set "comandoPastaAspasDuplas="%comandoPasta%""
if "%segundoMenuOpcao%"=="1" (
	REM - COMANDO FOR NÃO ACEITA !VARIÁVEL!, SOMENTE %VARIÁVEL%
	REM - ESTOU FALANDO DO COMANDO E NÃO DO SEU CORPO "for ...COMANDO... ( ...CORPO...)".
	REM - ACREDITO QUE TODOS OS COMANDO DE ESTRUTURA NÃO ACEITA COMO: if(...), for(...)...
	for /r %comandoPastaAspasDuplas% %%c in (*.webm) do (
		binarios-datas\FFMPeG.eXe -y -i "%%c" "%%c.mp3"
		del "%%c"
	)
	REM - FIM DO LAÇO FOR.
) else (
	if not "!idioma!"=="" (

		REM - COMANDO FOR NÃO ACEITA !VARIÁVEL!, SOMENTE %VARIÁVEL%
		REM - ESTOU FALANDO DO COMANDO E NÃO DO SEU CORPO "for ...COMANDO... ( ...CORPO...)".
		REM - ACREDITO QUE TODOS OS COMANDO DE ESTRUTURA NÃO ACEITA COMO: if(...), for(...)...
		for /r %comandoPastaAspasDuplas% %%c in (*.vtt) do (
			binarios-datas\FFMPeG.eXe -y -i "%%c" "%%c.srt"
			del "%%c"
		)
		REM - FIM DO LAÇO FOR.
	)
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