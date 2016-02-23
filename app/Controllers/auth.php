<?php

namespace Controllers;

use Core\View,
	 \helpers\session,
	 \helpers\password,
	 \helpers\url;


class Auth extends \core\controller {
	
	public function login(){

		$date['title'] = 'login';
		View::rendertemplate('header',$data);
		View::render('auth/login',$data);
		View::rendertemplate('footer',$data);

	}

	public function logout(){
		Session::destroy();
		Url::redirect();

	}
}
