<?php
session_start();
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require('inc/config-bd.php');
require('modele/modele.php');
require('inc/includes.php');
require('inc/routes.php');

$connexion = getConnexionBD();
?>

<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="img/logo.ico">
    <meta charset="utf-8" />
    <title><?= $nomSite?></title>
    <link href="css/style4.css" rel="stylesheet" media="all" type="text/css">
</head>
<body id="mainBody">
    <?php include('static/header.php'); ?>
    <div id="divCentral">
		<?php include('static/menu.php'); ?>
		<?php include('static/recherche.php')?>
		<main>
		<?php
		$controleur = 'controleurAccueil'; 
		$vue = 'vueAccueil'; 
		if(isset($_GET['page'])) {
			$nomPage = $_GET['page'];
			if(isset($routes[$nomPage])) {
				$controleur = $routes[$nomPage]['controleur'];
				$vue = $routes[$nomPage]['vue'];
			}
		}
		include('controleurs/' . $controleur . '.php');
		include('vues/' . $vue . '.php');
		?>
		</main>
	</div>
    <?php include('static/footer.php'); ?>
</body>
</html>
