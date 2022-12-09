<main>
    <div id="divInfoGenre">
        <h1>TOUS LES GENRES</h1>
        <p>Il y a <?=$nombreGenre?> genres</p>
        <?php foreach($InfoGenres as $InfoGenre){ ?>
            <ul>
                <li><?=$InfoGenre['nomGenre']?></li>
            </ul>
        <?php } ?>
    </div>
</main>

