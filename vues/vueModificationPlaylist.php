<main>
    <div id="editPlaylist">
        <h1>Modifie Une Playlist</h1>
        <form action="#" method="post">
            <label for="selectPlaylist" id="labelSelectPL">Selectionne ta playlist</label>
            <select name="selectPlaylist" id="selectPlaylist">
                <option value="NULL"></option>
                    <?php foreach($allPlaylist as $playlist){ ?>
                        <option value="<?=$playlist['identifiantPlaylist']?>"><?=$playlist['titrePlaylist']?> <?=$playlist['identifiantPlaylist']?></option>
                <?php }?>
            </select>
        </form>

        <div>
            <h2 id="htitrePL">Titre</h2>
            <br/>
            <p id="ptitrePL"></p>

            <h2 id="htimePL">Durée Playlist</h2>
            <br/>
            <p id="ptimePL"></p>

            <h2 id="hnbSongPL">Nombre de Chanson</h2>
            <br/>
            <p id="pnbSongPL"></p>
        </div>
        
        <form action="#" method="post">
            <label for="selectSongAdd">Ajoute Une musique</label>
            <select name="selectSongAdd" id="selectSongAdd">
            <option value="NULL"></option>
            <?php foreach($allSong as $song){ ?>
                    <option value="<?=$song['numeroVersion']?>"><?=$song['titreChanson']?> <?=$song['libelleVersion']?></option>
                <?php }?>
            </select>

            <label for="selectSongDel"></label>
            <select name="selectSongDel" id="selectSongDel">
                <option value="NULL"></option>
                <?php foreach($songInPL as $song){ ?>
                    <option value="<?=$song['numeroVersion']?>"><?=$song['titreChanson']?> <?=$song['libelleVersion']?></option>
                <?php }?>
            </select>
        </form>

        <a href="">Comparer 2 Playlist</a>
    </div>
</main>