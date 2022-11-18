<main>
        <h1>TOUT LES ALBUMS</h1>
        <?php
            $nomTable = "Album";
            $InfoAlbums = informationTable($connexion, $nomTable);
            foreach($InfoAlbums as $InfoAlbum) { ?>
            <p>Il y a <?$InfoAlbum['nb_Album']?></p>
            <ul>
                <li><?$InfoAlbum['titreAlbum']?> <?$InfoAlbum['dateSortieAlbum']?></li>
            </ul>
            
    <?php }?>


</main>