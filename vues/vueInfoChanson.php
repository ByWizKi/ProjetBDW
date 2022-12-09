<main>
  <div id="divInfoChanson">
    <h1>TOUTES LES CHANSON</h1>
    <p>Il y a <?=$nombreChanson?> chansons</p>
    <?php
        foreach($InfoChansons as $InfoChanson){?>   
          <li><?=$InfoChanson['titreChanson']?> <?=$InfoChanson['nomGroupe']?> <?=$InfoChanson['dureeVersion']?> <?= $InfoChanson['libelleVersion']?></li>  
    <?php } ?>
  </div>
</main>
