#Include 'Protheus.ch'

	
/*/{Protheus.doc} GetRE
	Obt�m a regexp solicitada aproveitando um cach� est�tico
@author thiago.santos
@since 12/09/2013
@version 1.0
		
@param cRE, character, (Descri��o do par�metro)

@return object, Inst�ncia da RegExp solicitada

/*/
User Function GetRE(cRE)
Static aRe := {}
Local nPos
Local oRet

If (nPos := aScan(aRe, {|aLine| aLine[1] == cRE })) > 0
	oRet := aRe[nPos,2]
Else
	aAdd(aRe, { cRE, oRet := U_REComp(cRE) })
EndIf

Return oRet

	
/*/{Protheus.doc} ClearRE
	Limpa todas as regexps acumuladas no cach�
@author thiago.santos
@since 12/09/2013
@version 1.0		

/*/
User Function ClearRE()

aSize(aRe, 0)

Return

	
/*/{Protheus.doc} REMatch
	Valida se o texto base exatamente com a regexp
@author thiago.santos
@since 12/09/2013
@version 1.0
		
@param cRE, character, RegEx de valida��o
@param cTexto, character, Texto a validar

@return boolean, Se o texto bateu com a regexp em toda a sua extens�o
/*/
User Function REMatch(cRE, cTexto)
Local oRE := U_GetRE(cRE)

Return oRE:Match(cTexto)


	
/*/{Protheus.doc} REFind
	Procura pelas ocorr�ncias da regexp em um texto
@author thiago.santos
@since 12/09/2013
@version 1.0
		
@param cRE, character, Regexp a utilizar
@param cTexto, character, Texto base para a procura
@param nOcur, integer, N�mero m�ximo de ocorr�ncias aceitas (padr�o 0/ilimitado)

@return array, set de resutlados da busca
/*/
User Function REFind(cRE, cTexto, nOcur)
Local oRE        := U_GetRE(cRE)
Local aRet       := {}

If oRE:Find(cTexto, nOcur)
	aRet := oRE:Result
EndIf

Return aRet

	
/*/{Protheus.doc} REReplace
	Aplica a substitui��o de regexp no texto espec�fico
@author thiago.santos
@since 12/09/2013
@version 1.0
		
@param cRE, character, Regexp a avaliar
@param cTexto, character, Texto base
@param cOutput, character, Padr�o de substitui��o
@param nOcur, num�rico, Quantidade m�xima de ocorr�ncias (padr�o 0/Infinito)

@return character, Texto com as substitui��es aplicadas

/*/
User Function REReplace(cRE, cTexto, cOutput, nOcur)
Local oRE        := U_GetRE(cRE)
Local cRet       := cTexto

If oRE:Find(cTexto, nOcur)
	cRet := oRE:Replace(cOutput)
EndIf

Return cRet

	
/*/{Protheus.doc} RETransform
	Aplica a transforma��o indicada em um resultado capturado
@author thiago.santos
@since 12/09/2013
@version 1.0
		
@param cRE, character, Regexp a avaliar
@param cTexto, character, Texto base
@param cOutput, character, Padr�o de substitui��o
@param nOcur, num�rico, N�mero m�ximo de ocorr�ncias (padr�o 0/ilimitado)
@param nIndex, num�rico, �ndice da ocorr�ncia.

@return character, Captura com a substitui��o aplicada
/*/
User Function RETransform(cRE, cTexto, cOutput, nOcur, nIndex)
Local oRE        := U_GetRE(cRE)
Local cRet       := ""
Default nIndex := 1

If oRE:Find(cTexto, nOcur) .And. Len(oRe:Result) >= nIndex
	cRet := oRE:Transform(cOutput, nIndex)
EndIf

Return cRet