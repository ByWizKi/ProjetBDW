<main>
    <div id="divTopMusique">
        <h1 id="textTopMusique">Chanson Les Plus Ecoutees</h1>
        <?php
            for($i =0; $i < 5; $i++) { ?>
	            <li><?= $topChanson[$i]['titre']?></li>
        <?php }?>
        <label for="boutonVoirToutTopMusique"></label>
        <a href="index.php?page=InfoChanson" id="VoirTout">Voir Tout</a>
    </div>

    <div id="divTopAlbum">
        <h1 id="textTopAlbum">Album Les Plus Ecoutees</h1>
        <?php
        for($i =0; $i < 3; $i++) { ?>
	        <li><?= $topAlbum[$i]['titreAlbum']?></li>
        <?php }?>
        <label for="boutonVoirToutTopAlbum"></label>
        <a href="index.php?page=InfoAlbum" id="VoirTout">Voir Tout</a>
    </div>

    <div id="divTopGenre">
        <h1 id="textTopGenre">Genre Les Plus Ecoutees</h1>
        <?php
            for($i =0; $i < 1; $i++) { ?>
	            <li><?= $topGenre[$i]['nom']?></li>
        <?php }?>
        <label for="boutonVoirToutTopGenre"></label>
        <a href="index.php?page=InfoGenre" id="VoirTout">Voir Tout</a>
    </div>
</main>
<!-- 
    On peut voir dans les boucles differents chiffre mais normalement 
le chiffre est 5 on fait un top 5 des ... plus ecoutees or ici nous avons pas assez de donnees 
pour afficher les 5 mais le programme marche pour 5 il suffit de changer la valeur de la boucle
!>