<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";

//recuperation des Genres
$nomGenre = getNomGenre($connexion);

// si le formulaire est fourni
if(isset($_POST['validationAjoutPlaylist']))
    {   
        // on regarde si le titre est vide
        if(!empty($_POST['inputTitrePlaylist'])){
            $titrePlaylist  = mysqli_real_escape_string($connexion, trim($_POST['inputTitrePlaylist']));
        }
        else{
            $titrePlaylist = NULL;
        }
        // on regarde si la duree est vide
        if(!empty($_POST['inputTimePlaylist'])){
            $dureePlaylist = $_POST['inputTimePlaylist'];
        }
        else{
            $dureePlaylist = "00:20:00";
        }
        // on regarde si le genre est vide
        if(!empty($_POST['selectGenrePlaylist'])){
            $genrePlaylist  = $_POST['selectGenrePlaylist'];
            if($genrePlaylist == "NULL"){$genrePlaylist = NULL;}
        }
        else{
            $genrePlaylist = NULL;
        }

        // on regarde si on veut les chanson les plus joue ou les moins skip
        if(!empty($_POST['selectPref'])){
            $selectPref = mysqli_real_escape_string($connexion, trim($_POST['selectPref']));
            if ($selectPref == 'MorePlayCount' || $selectPref == 'LessSkipCount'){
                // on recup le pourcentage
                $percPref = $_POST['percPref'];
            }
            
            else{
                $selectPref = NULL;
                $percPref = NULL;
            }
        }
        // on creer la playlist
        $creationPlaylist = createPlaylist($connexion, $titrePlaylist, $genrePlaylist, $dureePlaylist, $selectPref, $percPref);
        if($creationPlaylist == false){
            $message = "Creation de la playlist impossible !";
        }
        else $message = "Creation de la playlist reussi !";
    }
?>