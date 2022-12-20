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
Route::get('users/{id_user}/questions','PostController@showQuestions')->name('userQuestions');
Route::get('users/{id_user}/answers','PostController@showAnswers')->name('userAnswers');
Route::get('users/{id_user}/edit','UserController@getEditProfile')->middleware('auth')->name('editProfile');
Route::patch('users/edit','UserController@update')->middleware('auth')->name('updateProfile');

//admin page
Route::get('admin', 'AdminController@show')->middleware('auth')->name('admin');
Route::post('admin/tags','TagController@createTag')->middleware('auth')->name('createTag');
Route::delete('admin/tags','TagController@deleteTag')->middleware('auth')->name('deleteTag');
Route::post('admin/createUser', 'AdminController@createUser')->middleware('auth')->name('createUser');
Route::post('admin/makeAdmin','AdminController@makeAdmin')->middleware('auth')->name('makeAdmin');


Route::get('personal_feed','PostController@personalFeed')->middleware('auth')->name('personalFeed');
Route::get('home','PostController@showTopQuestions')->name('home');


// Questions
Route::get('questions', 'PostController@showAllQuestions')->name('allQuestions');
Route::get('questions/ask', 'QuestionController@getAskForm')->name('formToAskQuestion');
Route::post('questions/ask', 'QuestionController@postQuestion')->name('postQuestion');
Route::get('questions/{id_question}', 'QuestionController@show')->name('question');
Route::post('questions/{id_question}/answer', 'QuestionController@postAnswer')->name('postAnswer');

Route::get('post/{id_post}/edit','PostController@updatePostForm')->name('updatePostForm');
Route::post('posts/edit','PostController@update')->middleware('auth')->name('updatePost');
Route::delete('post/edit','PostController@delete')->middleware('auth')->name('deletePost');



//Tags
Route::get('tags','TagController@showAllTags')->name('tags'); 
Route::get('tags/{id_tag}','TagController@showTag')->name('tag'); 
