<main>
        <div id="divInfoAlbum">
            <h1>TOUS LES ALBUMS</h1>
            <p>Il y a <?=$nombreAlbum?> albums</p>
            <?php foreach($InfoAlbums as $InfoAlbum){ ?>
                <ul>
                    <li><?=$InfoAlbum['titreAlbum']?> <?=$InfoAlbum['dateSortieAlbum']?></li>
                </ul>
            <?php }?>
        </div>
</main>