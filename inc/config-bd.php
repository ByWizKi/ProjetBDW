<?php
if(file_exists('../private-config-bd.php'))
	require('../private-config-bd.php');
else {
	define('SERVEUR', 'localhost');
	define('UTILISATRICE', 'p2207446'); 
	define('MOTDEPASSE', 'Seduce65Maybe'); 
	define('BDD', 'p2207446'); 
}
?>