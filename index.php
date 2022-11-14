$connexion = getConnexionBD();
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title><?= $nomSite ?></title>
    <link href="css/style.css" rel="stylesheet" media="all" type="text/css">
</head>
<body>
    <?php include('static/header.php'); ?>
    <div id="divCentral">
		<?php include('static/menu.php'); ?>
		
		<main>
		<?php
		$controleur = 'controleurAccueil'; // par défaut, on charge accueil.php
		$vue = 'vueAccueil'; // par défaut, on charge accueil.php
		if(isset($_GET['page'])) {
			$nomPage = $_GET['page'];
			if(isset($routes[$nomPage])) { // si la page existe dans le tableau des routes, on la charge
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
