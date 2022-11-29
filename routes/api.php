<?php

use App\Http\Controllers\UserController;
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', 'Auth\LoginController@getUser');

Route::post('search_users', [UserController::class, 'searchApi'])->name('searchUsersApi');

Route::post('current_user', [UserController::class, 'getCurrentUserApi'])->name('getCurrentUserApi');

//proteger isto para o dono, não eet´s a funcionar nem para só users logados
Route::get('users/{id_user}/votes_on_question/{id_question}', [UserController::class, 'userVotesToQuestionAndAnswers'])->name('userVotesToQuestionAndAnswers');

Route::post('users/vote', [UserController::class, 'voteOnPost'])->name('voteOnPost');
