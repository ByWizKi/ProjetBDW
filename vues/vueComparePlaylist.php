<main>
    <div id="comparPL">
        <h1 id="t1CPL">Compare 2 Playlist</h1>

        <div id="selectPL">
            <form action="index.php?page=ComparePlaylist2" method="post">
                <label for="selectPL1">Selectionne ta playlist 1</label>
                <select name="selectPL1" id="selectPL1">
                    <option value="NULL">--Selectionne--</option>
                    <?php foreach($allPlaylist1 as $playlist) {?>
                            <option value="<?=$playlist['identifiantPlaylist']?>"><?=$playlist['nomPlaylist']?> <?= $playlist['identifiantPlaylist']?></option>
                    <?php }?>
                </select>

                <label for="selectPL2">Selectionne ta playlist 2</label>
                <select name="selectPL2" id="selectPL2">
                    <option value="NULL">--Selectionne--</option>
                    <?php foreach($allPlaylist1 as $playlist) {?>
                        <option value="<?=$playlist['identifiantPlaylist']?>"><?=$playlist['nomPlaylist']?> <?= $playlist['identifiantPlaylist']?></option>
                    <?php }?>
                </select>
                <input type="submit" value="Valider" id="sendCPL" name="sendCPL">    
            </form>
        </div>
    </div>
</main>