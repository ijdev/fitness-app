<?php

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
//
//Route::middleware('auth:api')->get('/user', function (Request $request) {
//    return $request->user();
//});

//Route::get('/self', 'MealController@selftest');

// get all meals
Route::get('/meals', 'MealController@index');
//// create new meal
Route::post('/meal', 'MealController@store');
// update a meal
Route::put('/meal', 'MealController@update');
//// get a meal
Route::get('/meal/{id}', 'MealController@show');
//delete a meal
Route::delete('/meal/{id}', 'MealController@destroy');

// get all workouts
Route::get('/workouts', 'WorkoutController@index');
//// create new workout
Route::post('/workout', 'WorkoutController@store');
// update a workout
Route::put('/workout', 'WorkoutController@update');
//// get a workout
Route::get('/workout/{id}', 'WorkoutController@show');
//delete a workout
Route::delete('/workout/{id}', 'WorkoutController@destroy');

Route::group([
    'middleware' => 'api',
], function () {

    Route::post('/register', 'UserController@register');
    Route::post('/login', 'UserController@login');

//    Route::post('login', 'AuthController@login');
//    Route::post('logout', 'AuthController@logout');
//    Route::post('refresh', 'AuthController@refresh');
//    Route::post('me', 'AuthController@me');

});
