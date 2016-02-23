<?php

/** Create alias for Router. */
use Core\Router;
use Helpers\Hooks;

/** Define routes. */
Router::any('', 'Controllers\Welcome@index');
Router::any('login', '\Controllers\auth@login');


/** Module routes. */
$hooks = Hooks::get();
$hooks->run('routes');

/** If no route found. */
Router::error('Core\Error@index');

/** Turn on old style routing. */
Router::$fallback = false;

/** Execute matched routes. */
Router::dispatch();
