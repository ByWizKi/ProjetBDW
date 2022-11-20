<main>
        <div id="divInfoAlbum">
            <h1>TOUT LES ALBUMS</h1>
            <p>Il y a <?$nombreAlbum['nb']?></p>
            <?php foreach($InfoAlbums as $InfoAlbum) { ?>
                <ul>
                    <li><?$InfoAlbum['titreAlbum']?> <?$InfoAlbum['dateSortieAlbum']?></li>
                </ul>
            <?php }?>
        </div>
</main>