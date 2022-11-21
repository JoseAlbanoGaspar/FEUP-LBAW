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
Route::post('register', 'Auth\RegisterController@register')->name('registerAction');

// Posts Search
Route::get('search', 'PostController@search')->name('search');

//User Search
Route::get('search_users', 'UserController@search')->name('searchUsers');

Route::get('users/{id_user}','UserController@show')->name('users');
Route::get('users/{id_user}/myQuestions','PostController@showQuestions')->name('myQuestions');
Route::get('users/{id_user}/myAnswers','PostController@showAnswers')->name('myAnswers');
Route::get('users/{id_user}/edit','UserController@getEditProfile')->name('editProfile');
Route::patch('users/edit','UserController@update')->name('updateProfile');

//admin page
Route::get('admin', 'AdminController@show')->name('admin');
Route::post('admin/tags','TagController@createTag')->name('createTag');
Route::delete('admin/tags','TagController@deleteTag')->name('deleteTag');
Route::post('admin/createUser', 'AdminController@createUser')->name('createUser');
Route::post('admin/makeAdmin','AdminController@makeAdmin')->name('makeAdmin');


Route::get('personal_feed','PostController@personalFeed')->name('personalFeed');
Route::get('home','PostController@showTopQuestions')->name('home');


// Questions
Route::get('questions', 'PostController@showAllQuestions')->name('allQuestions');
Route::get('questions/ask', 'QuestionController@getAskForm')->name('FormToAskQuestion');
Route::post('questions/ask', 'QuestionController@postQuestion')->name('postQuestion');
Route::get('questions/{id_question}', 'QuestionController@show')->name('question');
Route::post('questions/{id_question}/answer', 'QuestionController@postAnswer')->name('postAnswer');

Route::get('post/{id_post}/edit','PostController@updatePostForm')->name('updatePostForm');
Route::patch('posts/edit','PostController@update')->name('updatePost');
Route::delete('post/edit','PostController@delete')->name('deletePost');



//Tags
Route::get('tags/{name}','PostController@search')->name('tags'); //to be implemented in A9
