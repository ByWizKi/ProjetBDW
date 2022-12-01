<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";


//recuperation des Genres
$nomGenre = getNomGenre($connexion);

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
            $dureePlaylist  = '00:'.$_POST['inputTimePlaylist'];
        }
        else{
            $dureePlaylist = "00:20:00";
        }
        // on regarde si le genre est vide
        if(!empty($_POST['selectGenrePlaylist'])){
            $genrePlaylist  = mysqli_real_escape_string($connexion, trim($_POST['selectGenrePlaylist']));
        }
        else{
            $genrePlaylist = NULL;
        }

        // on regarde si on veut les chanson les plus joue 
        if(!empty($_POST['inputMostPlay'])){
            $genrePlaylist  = true;
        }
        else{
            $genrePlaylist = false;
        }

        // on regarde si on veut les chanson les plus skip
        if(!empty($_POST['inputLessersSkip'])){
            $genrePlaylist  = true;
        }
        else{
            $genrePlaylist = false;
        }

        // 



}
?>