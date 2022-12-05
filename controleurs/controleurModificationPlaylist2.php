<?php
//message d'erreur si il n'y a aucune info de table disponible
$message="";
//recup toutes les playlists
if(isset($_POST['selectPlaylist']) && $_POST['selectPlaylist'] !="NULL")
{
    $idPlaylist = $_POST['selectPlaylist'];
    $infoPL = getInfoAboutPlaylist($connexion, $idPlaylist);
    $allSong = getAllSong($connexion);
    $allSongPL = getAllSongFromPlaylist($connexion, $idPlaylist);
}

else{$message="Impossible de modifier la playlist !";}
?>