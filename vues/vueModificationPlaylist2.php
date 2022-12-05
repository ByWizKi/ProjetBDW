<main>
    <div id="divMain">
        <?php if($_POST['selectPlaylist']!="NULL"){?>
            <h1 id="text1">Vous Avez Choisi </h1>
            <p><?=$infoPL[0]['nomPlaylist'] ?> <?=$infoPL[0]['identifiantPlaylist']?></p>
            <br>

            <h2 id="text2">Duree </h2>
            <p><?=$infoPL[0]['dureePlaylist']?></p>

            <h2 id="text3"> Il y a <?=$infoPL[0]['numSong']?> Chanson</h2>

            <div id="formPL2">
                <form action="index.php?page=ModificationPlaylist" method="post">
                    <label for="selectSongAdd">Selectionne ta musique a ajouter</label>
                    <select name="selectSongAdd" id="selectSongAdd">
                        <option value="NULL">--Selectionne--</option>
                        <?php foreach($allSong as $song){?>
                            <option value="<?=$song['numeroVersion']?>"> <?=$song['titreChanson']?> <?=$song['libelleVersion']?></option>
                        <?php }?>
                    </select>

                    <label for="selectSongDel">Selectionne ta musique a supprimer</label>
                    <select name="selectSongDel" id="selectSongDel">
                        <option value="NULL">--Selectionne--</option>
                        <?php foreach($allSongPL as $song){?>
                            <option value="<?=$song['numeroVersion']?>"> <?=$song['titreChanson']?> <?=$song['libelleVersion']?></option>
                        <?php }?>
                    </select>
            
                    <label for="checkBoxId">Je valide l'action</label>
                    <input type="checkbox" name="checkBoxId" id="checkBoxId" value="<?=$song['identifiantPlaylist']?>">

                    <input type="submit" value="Valider" id="editOK" name="editOK">
                </form> 
            <?php }?>  
        </div>
        <div><p><?=$message?></p></div>
    </div>
</main>