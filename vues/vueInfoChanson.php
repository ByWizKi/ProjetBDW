<main>
  <div>
    <h1>TOUTES LES CHANSON</h1>
    <p>Il y a <?$nombreChanson['nb']?></p>
    <?php
        foreach($InfoChansons as $InfoChanson){ ?>
            <li><?$InfoChanson['titreChanson']?> <?$InfoChanson['nomGroupe']?> <?$InfoChanson['dureeVersion']?> <?$InfoChanson['libelleVersion']?></li>  
    <?php } ?>
  </div>
</main>
