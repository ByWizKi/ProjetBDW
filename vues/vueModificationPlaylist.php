<main>
    <div id="divMain">
        <div id="formPL1">
            <form action="index.php?page=ModificationPlaylist2" method="post">
                <h1 id="titreEditPL" >Modifie Une Playlist</h1>
                <select name="selectPlaylist" id="selectPlaylist">
                    <option value="">--Selectionne Ta Playlist--</option>
                    <?php foreach($allPlaylist as $playlist) {?>
                        <option value="<?=$playlist['identifiantPlaylist']?>"><?=$playlist['nomPlaylist']?> <?= $playlist['identifiantPlaylist']?></option>
                    <?php }?>
                </select>
                <input type="submit" value="Valider">
            </form>
        </div>
        <div id="text5"><p><?=$message?></p></div>
    </div>
</main>