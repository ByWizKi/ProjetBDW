<main>
    <div id="divAjouterPlaylist">
        <h1>Ajouter Une Playlist</h1>
        <form method="POST" action="#" id="formAjouterPlaylist">
            <label for="inputTitrePlaylist">Titre</label>
            <input type="text" name="inputTitrePlaylist" id="inputTitrePlaylist">

            <label for="inputTimTimePlaylist">Duree*</label>
            <input type="text" name="inputTimePlaylist" id="inputTimePlaylist" placeholder="Heure:Minute:Seconde">


            <label for="selectGenrePlaylist">Genre</label>
            <select name="selectGenrePlaylist" id="selectGenrePlaylist">
                <option value="NULL">Aucune</option>
            <?php foreach($nomGenre as $genre){ ?>
                    <option value="<?=$genre['nomGenre']?>"><?=$genre['nomGenre']?></option>
            <?php }?>
            </select>

            <label for="selectPref">Préférence</label>
            <select name="selectPref" id="selectPref">
                <option value="NULL">Aucune</option>
                <option value="MorePlayCount">Les plus jouees</option>
                <option value="LessSkipCount">Les moins jouees</option>
            </select>
            <input type="range" min="0" max="100" step="10" name="percPref" id="percPref">

            <input type="submit" value="Ajouter" id="validationAjoutPlaylist" name="validationAjoutPlaylist">
        </form>
        <p><?=$message?></p>
    </div>   
</main>
