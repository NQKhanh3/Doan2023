<?php

use App\Http\Controllers\API\group_usercontroller;
use App\Http\Controllers\API\groupcontroller;
use App\Http\Controllers\API\noticecontroller;
use App\Http\Controllers\API\noticeforusercontroller;
use App\Http\Controllers\API\usercontroller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;

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
// API Route USER
Route::get('user',[usercontroller::class,'index']);

// Route::post('user',[usercontroller::class,'store']);

Route::get('user/{id}',[usercontroller::class,'show']);

Route::put('user/{id}',[usercontroller::class,'update']);

Route::delete('user/{id}',[usercontroller::class,'destroy']);

// API Route Group

Route::get('group',[groupcontroller::class,'index']);

Route::get('group/{id}',[groupcontroller::class,'show']);

Route::post('group',[groupcontroller::class,'store']);

Route::put('group/{id}',[groupcontroller::class,'update']);

Route::delete('group/{id}',[groupcontroller::class,'destroy']);


// API ROUTE GROUP USER

Route::get('groupuser',[group_usercontroller::class,'index']);

Route::get('groupuser/{id}',[group_usercontroller::class,'show']);

Route::post('groupuser',[group_usercontroller::class,'store']);

Route::put('groupuser/{id}',[group_usercontroller::class,'update']);

Route::delete('groupuser/{id}',[group_usercontroller::class,'destroy']);

// API NOTICE USER

Route::get('noticeuser',[noticeforusercontroller::class,'index']);

// API NOTICE

Route::get('notice',[noticecontroller::class,'index']);

Route::get('notice/{id}',[noticecontroller::class,'show']);

Route::post('notice',[noticecontroller::class,'store']);

Route::put('notice/{id}',[noticecontroller::class,'update']);

Route::delete('notice/{id}',[noticecontroller::class,'destroy']);

//API route để đăng ký
Route::post('/register', [AuthController::class, 'register']);
//API route để đăng nhập
Route::post('/login', [AuthController::class, 'login']);
Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::get('/profile', function(Request $request) { 
        return auth()->user();
    });
    // API route thoát
    Route::post('/logout', [AuthController::class, 'logout']);
});
