<main>
    <div>
        <?php if(isset($message)) { ?>
		    <p><?= $message ?></p>
	    <?php } ?>
	    <?php if(isset($InfoRecherches)) { ?>	
		<ul>
		<?php 
			foreach($InfoRecherches as $InfoRecherche) {?>  
                <li><?echo $InfoRecherche?></li>
			<?php } ?>
		</ul>
	    <?php } ?>
    </div>
</main>

