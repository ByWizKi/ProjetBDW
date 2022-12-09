<main>
    <div id="divAjouterChanson">
        <h1 id="h1Ajouter">Ajouter Une Chanson</h1>
        <form method="POST" action="#" id="formAjouterChanson">
            <div id="divAjouterChanson1"><label for="inputTitre">Titre*</label>
            <input type="text" name="inputTitre" id="inputTitre" required>
            
            <label for="selectGroupe">Groupe*</label>
            <select name="selectGroupe" id="selectGroupe" required>
                <?php foreach($nomGroupe as $groupe){ ?>
                    <option value="<?=$groupe['identifiantGroupe']?>"><?=$groupe['identifiantGroupe']?> <?=$groupe['nomGroupe']?></option>
                <?php }?>
            </select>

            <label for="selectGenre">Genre*</label>
            <select name="selectGenre" id="selectGenre" required>
            <?php foreach($nomGenre as $genre){ ?>
                    <option value="<?=$genre['identifiantGenre']?>"><?=$genre['nomGenre']?></option>
            <?php }?>
            </select>
            </div>

            <div id="AjouterChanson2">

            <label for="inputVersion">Version</label>
            <input type="text" name="inputVersion" id="inputVersion" required>

            <label for="inputTime" required>Duree*</label>
            <input type="text" name="inputTime" id="inputTime" placeholder="hh:mm:ss">

            <label for="inputDate">Date De Sortie</label>
            <input type="date" name="inputDate" id="inputDate" required>
            
            <input type="submit" value="Ajouter" id="validationAjoutChanson" name="validationAjoutChanson">
            </div>
        </form>
        <p><?=$message?></p>
    </div>   
</main>
