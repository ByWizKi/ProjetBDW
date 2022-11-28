<?php


$connexion = ;

// Test si un groupe existe 
function groupeExsit($connexion, $nomGroupe){
    $nomGroupe = mysqli_real_escape_string($connexion, $nomGroupe);
    $requete = "SELECT nomGroupe From Groupe WHERE nomGroupe = '$nomGroupe'";
    $res = mysqli_query($connexion, $requete);
    if($res != false){
        $groupeExist = mysqli_fetch_all($res, MYSQLI_NUM);
        if(count($groupeExist)==0){
            return false;
        }
        else
        {
            return true;
        }
    }
    return -1;
}

//Ajout des Groupes/Artiste dans la base de donnees
function AjoutGroupe($connexion, $nomGroupe){

    $nomGroupe = mysqli_real_escape_string($connexion, $nomGroupe);
    // test si le groupe existe
    if(groupeExsit($connexion, $nomGroupe) == true){
        return "Le groupe exist deja";
    }

    // Ajout du groupe a la base de donnees
    $requete = "INSERT INTO Groupe (identifiantGroupe, nomGroupe, dateCreationGroupe, dateSeparationGroupe) VALUES (NULL, '$nomGroupe', NULL, NULL)";
    $res = mysqli_query($connexion, $requete);
    if ($res != false)
    {
        return "Ajout reussi !";
    }
    else
    {
        return "Ajout impossible réessayer";
    }
}

function main($connexion, $data){
    


}


?>