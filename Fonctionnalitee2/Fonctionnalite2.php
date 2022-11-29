<?php

//connexion aux bases de donnees
$connexionBD = mysqli_connect('localhost', 'p2207446', 'Seduce65Maybe', 'dataset');
$connexion = mysqli_connect('localhost', 'p2207446', 'Seduce65Maybe', 'p2207446');

//recuperation des donnees de la table songs
$requeteForSong = "SELECT * FROM songs100";
$resForSong = mysqli_query($connexionBD, $requeteForSong);
$tableSong = mysqli_fetch_all($resForSong, MYSQLI_ASSOC);

// Test si un groupe existe 
function groupeExsit($connexion, $nomGroupe){
    $nomGroupe = mysqli_real_escape_string($connexion, $nomGroupe);
    $requete = "SELECT nomGroupe From Groupe WHERE nomGroupe = '$nomGroupe'";
    $res = mysqli_query($connexion, $requete);
    if($res != false){
        $groupeExist = mysqli_fetch_all($res, MYSQLI_NUM);
        if(count($groupeExist)==0){
            return false;
        }
        else
        {
            return true;
        }
    }
    return -1;
}

//Ajout des Groupes/Artiste dans la base de donnees
function AjoutGroupe($connexion, $nomGroupe){

    $nomGroupe = mysqli_real_escape_string($connexion, $nomGroupe);
    // test si le groupe existe
    if(groupeExsit($connexion, $nomGroupe) == true){
        return "Le groupe exist deja";
    }

    // Ajout du groupe a la base de donnees
    $requete = "INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, '$nomGroupe', NULL, NULL)";
    $res = mysqli_query($connexion, $requete);
    if ($res != false)
    {
        return "Ajout reussi !";
    }
    else
    {
        return "Ajout impossible réessayer";
    }
}

function albumExist($connexion, $nomGroupe, $titreAlbum, $compilation){
    $nomGroupe = mysqli_real_escape_string($connexion, $nomGroupe);
    $titreAlbum = mysqli_real_escape_string($connexion, $titreAlbum);
    if($compilation != 0){
        $requete = "SELECT nomAlbum FROM Album NATURAL JOIN Enregistre NATURAL JOIN Groupe WHERE '$nomGroupe' = nomGroupe AND '$titreAlbum' = titreAlbum AND (libelleAlbum = 'AlbumStudio' OR libelleAlbum = 'Albumlives')";
    }
    else{
        $requete = "SELECT nomAlbum FROM Album NATURAL JOIN Enregistre NATURAL JOIN Groupe WHERE '$nomGroupe' = nomGroupe AND '$titreAlbum' = titreAlbum AND libelleAlbum = 'AlbumCompilation'";

    }
    $res = mysqli_query($connexion, $requete);
    if($res != false)
    {
        $resultat = mysqli_fetch_all($res, MYSQLI_ASSOC);
        if (count($resultat) == 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    return -1;
}

function main($connexion, $datas){
    foreach($datas as $data){
        AjoutGroupe($connexion, $data['artist']);
    }   
}


?>