<?php

// message d'erreur
$message="";


// recuperation des information liee a la recherche
if(isset($_POST['buttonSelectSearch'])) {
	
	$texteRecherche = mysqli_real_escape_string($connexion, trim($_POST['inputSearch']));
	$nomTable = mysqli_real_escape_string($connexion, $_POST['selectSearch']);
	$InfoRecherches = recherche($connexion, $nomTable, $texteRecherche);
	if(count($InfoRecherches) == 0) {
		$message = "Aucune infomartion est disponible pour recherche !";
	}
}
?>
