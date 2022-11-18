<?php
if(file_exists('../private-config-bd.php'))
	require('../private-config-bd.php');
else {
	define('SERVEUR', 'localhost');
	define('UTILISATRICE', 'root'); 
	define('MOTDEPASSE', ''); 
	define('BDD', 'test'); 
}
?>
