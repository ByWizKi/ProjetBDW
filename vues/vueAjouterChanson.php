<main>
    <div id="divAjouterChanson">
        <h1>Ajouter Une Chanson</h1>
        <form method="POST" action="#" id="formAjouterChanson">
            <label for="inputTitre"> Titre</label>
            <input type="text" name="inputTitre" id="inputTitre">

            <label for="selectGroupe">Groupe</label>
            <select name="selectGroupe" id="selectGroupe"></select>

            <label for="selectGenre">Genre</label>
            <select name="selectGenre" id="selectGenre"></select>

            <label for="inputTime">Duree</label>
            <input type="time" name="inputTime" id="inputTime">

            <label for="inputDate">Date De Sortie</label>
            <input type="date" name="inputDate" id="inputDate">

            <label for="inputCheckBox">Date Aujourd'hui</label>
            <input type="checkbox" id="inputCheckBox" name="inputCheckBox">
            
            <input type="submit" value="Ajouter" id="validationAjoutChanson" name="validationAjoutChanson">
        </form>
    </div>   
</main>
