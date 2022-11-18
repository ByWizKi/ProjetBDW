<main>
    <div id="divTopMusique">
        <h1 id="textTopMusique">Chanson Les Plus Ecoutees</h1>
        <?php
            $topChanson = topElementChanson($connexion); 
            for($i =0; $i < 5; $i++) { ?>
	            <li><?= $topChanson[$i]['titre']?></li>
        <?php }?>
        <label for="boutonVoirToutTopMusique"></label>
        <a href="index.php?page=InfoChanson">Voir Tout</a>
    </div>

    <div id="divTopAlbum">
        <h1 id="textTopAlbum">Album Les Plus Ecoutees</h1>
        <?php
        $topAlbum = topElementAlbum($connexion); 
        for($i =0; $i < 3; $i++) { ?>
	        <li><?= $topAlbum[$i]['titreAlbum']?></li>
        <?php }?>
        <label for="boutonVoirToutTopAlbum"></label>
        <a href="index.php?page=InfoAlbum">Voir Tout</a>
    </div>

    <div id="divTopGenre">
        <h1 id="textTopGenre">Genre Les Plus Ecoutees</h1>
        <?php
            $topGenre = topElementGenre($connexion); 
            for($i =0; $i < 1; $i++) { ?>
	            <li><?= $topGenre[$i]['nom']?></li>
        <?php }?>
        <label for="boutonVoirToutTopGenre"></label>
        <a href="index.php?page=InfoGenre">Voir Tout</a>
    </div>
</main>
