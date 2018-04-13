{
ALGORITHME batailleNavale

CONST
	minLigne <- 1 : ENTIER
	maxLigne <- 50 : ENTIER
	minCol <- 1 : ENTIER
	maxCol <- 50 : ENTIER
	nbBateaux <- 2 : ENTIER
	maxCase <- 5 : ENTIER

TYPE cases = ENREGISTREMENT
	ligne,colonne : ENTIER
	FIN ENREGISTREMENT
TYPE bateau = ENREGISTREMENT
	nCase : TABLEAU [1..maxCase] DE cases
	FIN ENREGISTREMENT
TYPE flotte = ENREGISTREMENT
	nBateau : TABLEAU [1..nbBateaux] DE bateau
	FIN ENREGISTREMENT
TYPE bool = (VRAI,FAUX)
TYPE posBateau = (Horizontal,Vertical,Diagonal)
TYPE etatBateau = (touché,coulé)
TYPE etatFlotte = (aFlots,aSombré)
TYPE etatJoueur = (Gagné,Perdu)

PROCEDURE creaCase (l,c : ENTIER;VAR nCases : cases)
	DEBUT
		nCase.ligne <- l
		nCase.colonne <- c
FIN PROCEDURE

FONCTION cmpCase (nCase,tCase : Cases) : bool
	DEBUT
		SI ((nCase.ligne = tCase.ligne) ET (nCase.colonne = tCase.colonne)) ALORS
			cmpCase <- VRAI
FIN FONCTION

FONCTION creaBateau (nCase : cases;taille:ENTIER) : bateau
	VAR
		res : bateau
		pos : ENTIER
		i : ENTIER
		positionB : posBateau

	DEBUT
		pos <- RANDOM(1..3)
		positionB <- posBateau(pos)

		POUR i DE 1 A maxCase FAIRE
			DEBUT
				SI (i <= taille) ALORS
					DEBUT
						res.nCase[i].ligne <- nCase.ligne
						res.nCase[i].colonne <- nCase.colonne
					FIN
				SINON
					DEBUT
						res.nCase[i].ligne <- 0
						res.nCase[i].colonne <- 0
				FIN SI

				SI (positionB = Horizontal) ALORS
					nCase.colonne <- nCase.colonne + 1
				SINON SI (positionB = Vertical) ALORS
					nCase.ligne <- nCase.ligne + 1
				SINON SI (positionB = Diagonal) ALORS
					nCase.ligne <- nCase.ligne + 1
					nCase.colonne <- nCase.colonne + 1
				FIN SI
		FIN POUR

		creaBateau <- res
FIN PROCEDURE

FONCTION ctrlCase (nBateau : bateau;nCase : cases) : bool

	VAR
		i : ENTIER
		valTest : bool
	DEBUT
		valTest <- FAUX

		POUR i DE 1 A maxCase FAIRE
			DEBUT
				SI (cmpCase(nBateau.nCase[i],nCase) = VRAI) ALORS
					valTest <- VRAI
				FIN SI
		FIN POUR

	ctrlCase <- valTest
FIN FONCTION

FONCTION ctrlFlotte (nFlotte : flotte,nCase : cases) : bool
	VAR
		i : ENTIER
		res : bool

	DEBUT
		res <- FAUX

		POUR i DE 1 A nbBateaux FAIRE
			DEBUT
				SI (ctrlCase(nFlotte.nBateau[i],nCase) = VRAI) ALORS
					res <- VRAI
				FIN SI
			ctrl.flotte <- res
		FIN POUR
FIN FONCTION

PROCEDURE flotteJoueur (nCase : cases;VAR nflotte : flotte)
	VAR
		i : ENTIER
		valPosLigne,valPosColonne,valTailleBateau : ENTIER

	DEBUT
		POUR i DE 1 A nbBateaux FAIRE
			DEBUT
				valPosLigne <- RANDOM(1..maxLigne)
				valPosColonne <- RANDOM(1..maxCol)
				valTailleBateau <- RANDOM(1.maxCase)
				creaCase(valPosLigne,valPosColonne,cmpCase)
				nFlotte.nBateau[i] <- creaBateau (nCase,valTailleBateau)
		FIN POUR
FIN PROCEDURE
}





PROGRAM batailleNavale;

CONST									//Les différentes constantes
	minLigne = 1;
	maxLigne = 50;
	minCol = 1;
	maxCol = 50;
	nbBateaux = 2;
	maxCase = 5;

TYPE cases = RECORD					//Type Case composé de ligne et de colonne
	ligne,colonne : INTEGER;
	END;

TYPE bateau = RECORD				//Type bateau composé d'un ensemble de N Cases
	nCase : ARRAY [1..maxCase] OF cases;
	END;
TYPE flotte = RECORD				//Type flotte cette fois-ci composé d'un ensemble de N Bateau
	nBateau : ARRAY [1..nbBateaux] OF bateau;
	END;
TYPE bool = (VRAI,FAUX);							//D'autres Types permettant d'assurer les entrée de variables
TYPE posBateau = (Horizontal,Vertical,Diagonal);
TYPE etatBateau = (touche,coule);
TYPE etatFlotte = (aFlots,aSombre);
TYPE etatJoueur = (Gagne,Perdu);

PROCEDURE creaCase (nCase : cases;l,c : INTEGER;VAR nCases : cases);	//Procedure de création de case qui prend en paramètre la ligne et la colonne associé à la case.
	BEGIN
		nCase.ligne := l;
		nCase.colonne := c;
	END;

FUNCTION cmpCase (nCase,tCase : cases) : bool;					//Fonction de comparaison de deux cases qui renverras Vrai ou Faux selon le cas.
	BEGIN
		IF ((nCase.ligne = tCase.ligne) AND (nCase.colonne = tCase.colonne)) THEN
			cmpCase := VRAI;
	END;

FUNCTION creaBateau (nCase : cases;taille:INTEGER) : bateau;	//Fonction de création de bateau qui renverras une structure de bateau correctement remplie.
	VAR
		res : bateau;
		pos : INTEGER;
		i : INTEGER;
		positionB : posBateau;

	BEGIN
		RANDOMIZE;
		pos := (RANDOM(2)+1);
		positionB := posBateau(pos);

		FOR i := 1 TO maxCase DO
			BEGIN
				IF (i <= taille) THEN
					BEGIN
						res.nCase[i].ligne := nCase.ligne;
						res.nCase[i].colonne := nCase.colonne;
					END
				ELSE
					BEGIN
						res.nCase[i].ligne := 0;
						res.nCase[i].colonne := 0;
					END;

				IF (positionB = Horizontal) THEN
					BEGIN
						nCase.colonne := nCase.colonne + 1;
					END
				ELSE IF (positionB = Vertical) THEN
					BEGIN
						nCase.ligne := nCase.ligne + 1;
					END
				ELSE IF (positionB = Diagonal) THEN
					BEGIN
						nCase.ligne := nCase.ligne + 1;
						nCase.colonne := nCase.colonne + 1;
					END;
		END;

		creaBateau := res;
END;

FUNCTION ctrlCase (nBateau : bateau;nCase : cases) : bool;		//Fonction de vérification de case appartenant à un bateau, cette fonction renverras Vrai ou Faux selon le cas.

	VAR
		i : INTEGER;
		valTest : bool;
	BEGIN
		valTest := FAUX;

		FOR i := 1 TO maxCase DO
			BEGIN
				IF (cmpCase(nBateau.nCase[i],nCase) = VRAI) THEN
					BEGIN
						valTest := VRAI;
					END;
		END;

	ctrlCase := valTest;
END;

FUNCTION ctrlFlotte (nFlotte : flotte;nCase : cases) : bool;		//Fonction de vérification d'une case si elle appartient à une flotte de bateau, renverras Vrai ou Faux selon le cas.
	VAR
		i : INTEGER;
		res : bool;

	BEGIN
		res := FAUX;

		FOR i := 1 TO nbBateaux DO
			BEGIN
				IF (ctrlCase(nFlotte.nBateau[i],nCase) = VRAI) THEN;
					BEGIN
						res := VRAI;
					END;

			ctrlCase.flotte := res;						//J'ai une erreur que je n'arrive pas à règler à ce niveau la par cette erreur je n'arrive pas à avancer dans le passage d'algo à pascal fonctionnel.
END;

PROCEDURE flotteJoueur (nCase : cases;VAR nflotte : flotte);      //De même une erreur dans le pascal à ce niveau la, je ne la comprend pas non plus.
	VAR
		i : ENTIER
		valPosLigne,valPosColonne,valTailleBateau : INTEGER

	BEGIN
		FOR i := 1 TO nbBateaux DO
			BEGIN
				valPosLigne := RANDOM(1..maxLigne);
				valPosColonne := RANDOM(1..maxCol);
				valTailleBateau := RANDOM(1.maxCase);
				creaCase(valPosLigne,valPosColonne,cmpCase);
				nFlotte.nBateau[i] := creaBateau (nCase,valTailleBateau);
			END;
END;

//PROGRAMME PRINCIPAL

BEGIN
	//Je n'arrive pas bien à comprendre comment utiliser la création de case et y mettre un bateau qui seras lui même mis dans une flotte, n'arrivant pas à me visualiser l'objectif final je n'arrive donc pas à faire ce programme. J'ai au moins essayer de le passer en pascal avec le moins d'erreurs possible.
END.