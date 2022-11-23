<main>
    <div>
        <?php if(isset($message)) { ?>
		    <p><?= $message ?></p>
	    <?php } ?>
	    <?php if(isset($InfoRecherches)) { ?>	
		<ul>
		<?php 
			foreach($InfoRecherches as $InfoRecherche) {
				if ($nomTable == "Chanson"){ ?>
					<li><?=$InfoRecherche['titreChanson']?> <?=$InfoRecherche['nomGroupe']?> <?=$InfoRecherche['dureeVersion']?> <?=$InfoRecherche['libelleVersion']?></li>
				<?php } 

				elseif($nomTable == "Genre"){ ?>
					<li><?=$InfoRecherche['nomGenre']?></li>

				<?php } 

				elseif($nomTable == "Groupe"){ ?>
					<li><?=$InfoRecherche['nomGroupe']?> <?=$InfoRecherche['nb_Chanson']?> <?=$InfoRecherche['dateCreationGroupe']?></li>
				<?php } 
 
				elseif($nomTable == "Album"){ ?>
					<li><?=$InfoRecherche['titreAlbum']?> <?=$InfoRecherche['dateSortieAlbum']?></li>
				<?php } 

				elseif($nomTable =="Musicien"){ ?>
					<li><?=$InfoRecherche['prenomMusicien']?> <?=$InfoRecherche['nomMusicien']?> <?=$InfoRecherche['nomScene']?></li>

				<?php }?>      
			<?php } ?>
		</ul>
	    <?php } ?>
    </div>
</main>

