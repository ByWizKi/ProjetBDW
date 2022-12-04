<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";

//recup toutes les playlists
$allPlaylist = getAllPlaylist($connexion);


if(isset($_POST['selectSongAdd']) && $_POST['selectSongAdd']!="NULL")
{
    $addSong = addPlaylist($connexion, $_POST['checkBoxId'], $_POST['selectSongAdd']);
    if($addSong==true){$message="Ajout reussi !";}
    else{$message="Ajout impossible !";}
}
if(isset($_POST['selectSongDel']) && $_POST['selectSongDel'] !="NULL")
    
{
    $delSong = delPlaylist($connexion, $_POST['checkBoxId'], $_POST['selectSongDel']);
    if($delSong == true){$message="Suppression reussi !";}
    else{$message="Suppression impossible !";}
}

?>