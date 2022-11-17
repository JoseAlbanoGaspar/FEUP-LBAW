<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// Home
Route::get('/', 'HomeController@home');

// Cards
Route::get('cards', 'CardController@list');
Route::get('cards/{id}', 'CardController@show');

// API
Route::put('api/cards', 'CardController@create');
Route::delete('api/cards/{card_id}', 'CardController@delete');
Route::put('api/cards/{card_id}/', 'ItemController@create');
Route::post('api/item/{id}', 'ItemController@update');
Route::delete('api/item/{id}', 'ItemController@delete');

// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');

// Posts Search
Route::get('search', 'PostController@search')->name('search');

//User Search
Route::get('search_users', 'UserController@search')->name('search_users');

Route::get('questions/{id}', 'PostController@search')->name('questions'); //mudar controller ou substituir por completo

// User Profile
Route::get('users/{id_user}','UserController@show')->name('users');
Route::get('users/{id_user}/myQuestions','PostController@showQuestions')->name('myQuestions');
Route::get('users/{id_user}/myAnswers','PostController@showAnswers')->name('myAnswers');
Route::get('users/{id_user}/edit','UserController@getEditProfile')->name('editProfile');
Route::patch('users/edit','UserController@update')->name('updateProfile');

//Tags
Route::get('tags/{name}','PostController@search')->name('tags'); //to be implemented in A9

