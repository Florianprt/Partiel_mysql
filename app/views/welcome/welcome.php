<?php
/**
 * Sample layout
 */

use Core\Language;

?>

<div class="page-header">
	<h1>PARTIEL MYSQL</h1>
</div>

<p>Exercice de partiel 3A dev a L'EEMI</p>

<a class="btn btn-md btn-success" href="<?php echo DIR;?>subpage">
	<?php echo Language::show('Se connecter', 'Welcome'); ?>
</a>
