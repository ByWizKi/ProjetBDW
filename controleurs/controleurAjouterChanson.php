<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";

$test = chansonExiste($connexion, "Désolé", "original", "Sexion d Assaut");

//recuperation des Groupes
$nomGroupe = getNomGroupe($connexion);

//recuperation des Genres
$nomGenre = getNomGenre($connexion);

if(isset($_POST['validationAjoutChanson'])){
    $inputTitre = mysqli_real_escape_string($connexion, trim($_POST['inputTitre']));
    $inputGroupe = mysqli_real_escape_string($connexion, $_POST['selectGroupe']);
    $inputGenre = mysqli_real_escape_string($connexion, $_POST['selectGenre']);
    $inputVersion = mysqli_real_escape_string($connexion, $_POST['inputVersion']);
    if(isset($_POST['inputCheckBox'])){
    }
    else{
    }

}
?>