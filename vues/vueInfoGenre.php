<main>
    <div id="divInfoGenre">
        <p>Il y a <?=$nombreGenre?> genres</p>
        <?php foreach($InfoGenres as $InfoGenre){ ?>
            <ul>
                <li><?=$InfoGenre['nomGenre']?></li>
            </ul>
        <?php } ?>
    </div>
</main>

