<main>
    <div id="divAjouterChanson">
        
        <h1>Ajouter Une Chanson</h1>
        <form method="POST" action="#" id="formAjouterChanson">
            <label for="inputTitre">Titre*</label>
            <input type="text" name="inputTitre" id="inputTitre" required>

            <label for="selectGroupe">Groupe*</label>
            <select name="selectGroupe" id="selectGroupe" required>
                <?php foreach($nomGroupe as $groupe){ ?>
                    <option value="<?=$groupe['nomGroupe']?>"><?=$groupe['identifiantGroupe']?> <?=$groupe['nomGroupe']?></option>
                <?php }?>
            </select>

            <label for="selectGenre">Genre*</label>
            <select name="selectGenre" id="selectGenre" required>
            <?php foreach($nomGenre as $genre){ ?>
                    <option value="<?=$genre['nomGenre']?>"><?=$genre['nomGenre']?></option>
            <?php }?>
            </select>

            <label for="inputVersion">Version</label>
            <input type="text" name="inputVersion" id="inputVersion">

            <label for="inputTime" required>Duree*</label>
            <input type="time" name="inputTime" id="inputTime">

            <label for="inputDate">Date De Sortie</label>
            <input type="date" name="inputDate" id="inputDate">

            <label for="inputCheckBox">Date Aujourd'hui</label>
            <input type="checkbox" id="inputCheckBox" name="inputCheckBox">
            
            <input type="submit" value="Ajouter" id="validationAjoutChanson" name="validationAjoutChanson">
        </form>
    </div>   
</main>
