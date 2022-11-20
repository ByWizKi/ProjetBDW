<?php
// message d'erreur 
$message="";
$nomTable = "Chanson";

//recuperartion du nombres de chanson
$nombreChanson = nombreElementTable($connexion, $nomTable);

//recuperation de toutes les chansons
$InfoChansons = informationTable($connexion, $nomTable);
if($InfoChansons == NULL && count($InfoChansons)==0){
    $message = "Aucune chanson n'est presente sur notre site.";
}
?>