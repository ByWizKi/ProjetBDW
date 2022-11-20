<?php

// message d'erreur
$message="";

// nom de la table
$nomTable = "Genre";

// recuperation du nombre de genre
$nombreGenre = nombreElementTable($connexion, $nomTable);

//recuperation info des genres
$InfoGenres = informationTable($connexion, $nomTable);
if($InfoGenres == NULL && count($InfoGenres) == 0){
    $message = "Aucun genres n'est present dans notre site";
}



?> 
