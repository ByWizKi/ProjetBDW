<?php
$message="";


// test si les 2 selections sont pas null
if(isset($_POST['selectPL1']) && isset($_POST['selectPL2']) && $_POST['selectPL1']!= "NULL" && $_POST['selectPL2']!= "NULL"){
    // test si les 2 selections ne sont pas egaux
    if($_POST['selectPL1'] != $_POST['selectPL2']){
        $infoPL1 = getInfoAboutPlaylist($connexion, $_POST['selectPL1']);
        $nomPL1 = $infoPL1[0]['nomPlaylist'];
        $dureePL1 = $infoPL1[0]['dureePlaylist'];
        $numSongPL1 = $infoPL1[0]['numSong'];

        $infoPL2 = getInfoAboutPlaylist($connexion, $_POST['selectPL2']);
        $nomPL2 = $infoPL2[0]['nomPlaylist'];
        $dureePL2 = $infoPL2[0]['dureePlaylist'];
        $numSongPL2 = $infoPL2[0]['numSong'];

        $nbsameSongGenre = getNbSameSongGenre($connexion, $_POST['selectPL1'], $_POST['selectPL2']);
        $nbSameSong = getNbSameSong($connexion, $_POST['selectPL1'], $_POST['selectPL2']);
        $dureeDiff = getDureeDiff($connexion, $_POST['selectPL1'], $_POST['selectPL2']);

        $rapNbSameSongGenre = $nbsameSongGenre/($numSongPL1+$numSongPL2);
        $rapNbSameSong = $nbSameSong/($numSongPL1+$numSongPL2);
        $score = 0;

        if($rapNbSameSongGenre >= 0.7){$score += 2.5;}
        elseif($rapNbSameSongGenre >= 0.5 && $rapNbSameSongGenre < 0.7){$score += 1.5;}
        elseif($rapNbSameSongGenre >= 0.25 && $rapNbSameSongGenre < 0.5){$score += 1;}
        
        if($rapNbSameSong >= 0.7){$score += 2.5;}
        elseif($rapNbSameSong >= 0.5 && $rapNbSameSong < 0.7){$score += 1.5;}
        elseif($rapNbSameSong >= 0.25 && $rapNbSameSong < 0.5){$score += 1;}

        if($dureeDiff['dureeDiffSec'] <= 300){$score +=2.5;}
        elseif($dureeDiff['dureeDiffSec'] > 300 && $dureeDiff['dureeDiffSec'] <= 600){$score +=1.5;}
        elseif($dureeDiff['dureeDiffSec'] > 600 && $dureeDiff['dureeDiffSec'] <= 1200 ){$score +=1;}
    }

    else{$message="Impossible de compare 2 meme playlist !";}


}

else{$message="Comparaison Impossible !";}






?>