<?php 

use \helpers\form; ?>

<h1>Login</h1>
<?php echo Form::open(array('method' => 'post')); ?>

<p>Username: <?php echo Form::input(array('name' => 'username')); ?></p>
<p>Password: <?php echo Form::input(array('type' => 'password', 'name' => 'password')); ?></p>
<p>Username: <?php echo Form::input(array('type' => 'submit', 'name' => 'submit', 'value' => 'Submit')); ?></p>
<?php echo Form::close();?>
