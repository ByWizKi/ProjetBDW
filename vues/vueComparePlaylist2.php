<main>
    <div id="infoPL1">
        <h2>Nom Playlist 1 : <?=$nomPL1?></h2>
        <h2>Duree de la playlist : <?=$dureePL1?></h2>
        <h2>Nombre de chanson : <?=$numSongPL1?></h2>
    </div>

    <div id="infoPL2">
        <h2>Nom Playlist 2 : <?=$nomPL2?></h2>
        <h2>Duree de la playlist : <?=$dureePL2?></h2>
        <h2>Nombre de chanson : <?=$numSongPL2?></h2>
    </div>

    <div id="infoPL">
        <h2>Nombre de chanson qui ont le meme genre :</h2>
        <br>
        <p><?=$nbsameSongGenre?></p>

        <h2>Nombre de chanson similaire :</h2>
        <br>
        <p><?=$nbSameSong?></p>

        <h2>Nombre de minut d'ecart entre les duree des playlist :</h2>
        <br>
        <p><?=$dureeDiff['dureeDiff']?></p>
    </div>

    <div id="divSimili">
        <p id="textSimili">Le score de similitude entre les deux playlist est de <?=$score?>/10</p>
    </div>

    <p><?=$message?></p>
</main>