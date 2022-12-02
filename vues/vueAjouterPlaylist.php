<main>
    <div id="divAjouterPlaylist">
        <h1>Ajouter Une Playlist</h1>
        <form method="POST" action="#" id="formAjouterPlaylist">
            <label for="inputTitrePlaylist">Titre</label>
            <input type="text" name="inputTitrePlaylist" id="inputTitrePlaylist">

            <label for="inputTimTimePlaylist">Duree*</label>
            <input type="time" name="inputTimePlaylist" id="inputTimePlaylist">


            <label for="selectGenrePlaylist">Genre</label>
            <select name="selectGenrePlaylist" id="selectGenrePlaylist">
            <?php foreach($nomGenre as $genre){ ?>
                    <option value="<?=$genre['identifiantGenre']?>"><?=$genre['nomGenre']?></option>
            <?php }?>
            </select>

            <label for="inputMostPlay">Les plus jouees</label>
            <input type="checkbox" name="inputMostPlay" id="inputMostPlay">
            <input type="range" min=10 max=100 id="pourcPref1" name="pourcPref1">

            <label for="inputLessersSkip">Les moins skip</label>
            <input type="checkbox" name="inputLessersSkip" id="inputLessersSkip">
            <input type="range" min=10 max=100 id="pourcPref1" name="pourcPref1">

            <input type="submit" value="Ajouter" id="validationAjoutPlaylist" name="validationAjoutPlaylist">
        </form>
        <p><?=$message?></p>
    </div>   
</main>
