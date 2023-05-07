<?php

use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\HoadonController;
use App\Http\Controllers\Admin\KhachHangController;
use App\Http\Controllers\Admin\LoaiSPController;
use App\Http\Controllers\Admin\Login_Logout\LoginController;
use App\Http\Controllers\Admin\Login_Logout\LogoutController;
use App\Http\Controllers\Admin\NhaSanXuatController;
use App\Http\Controllers\Admin\QuanTriVienController;
use App\Http\Controllers\Admin\SanPhamController;
use App\Http\Controllers\Admin\VaiTroController;
use Illuminate\Support\Facades\Route;

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

//Gr admin

Route::group(['middleware' => 'guest', 'prefix' => 'admin/login', 'namespace' => 'admin\Login_Logout'], function() {
    Route::get('',[LoginController::class, 'login'])->name('login');
    Route::post('',[LoginController::class, 'doLogin'])->name('do-login');
});

Route::group(['middleware' => 'auth:admin'], function() {
    Route::group(['namespace' => 'admin\Login_Logout'], function() {
        Route::get('logout',[LogoutController::class, 'logout'])->name('logout');
    });

    Route::group(['namespace' => 'admin'], function() {
        Route::get('dashboard', [DashboardController::class,'index'])->name('dashboard');

        Route::prefix('chi-tiet-nhan-vien/{id}')->group(function() {
            Route::name('detail.')->group(function() {
                Route::get('', [QuanTriVienController::class,'show'])->name('show');
                Route::post('', [QuanTriVienController::class,'Detail'])->name('update');
                Route::get('doi-mat-khau', [QuanTriVienController::class,'DetailviewChangePassDetail'])->name('view-change');
                Route::post('doi-mat-khau', [QuanTriVienController::class,'changePassDetail'])->name('do-change');
            });
        });

        Route::prefix('admin/nhan-vien')->group(function() {
            Route::name('nhan-vien.')->group(function() {
                Route::get('', [QuanTriVienController::class,'index'])->name('list');
                Route::get('them-moi', [QuanTriVienController::class,'create'])->name('create');
                Route::post('them-moi',  [QuanTriVienController::class,'store'] )->name('store');
                Route::delete('xoa',  [QuanTriVienController::class,'destroy'] )->name('delete');
                Route::get('cap-nhat/{id}',  [QuanTriVienController::class,'edit'])->name('edit');
                Route::post('cap-nhat/{id}', [QuanTriVienController::class,'update'])->name('update');
                Route::post('doi-mat-khau',  [QuanTriVienController::class,'changePass'])->name('change-pass');
                Route::post('khoa-hoac-mo-khoa', [QuanTriVienController::class,'lockOrUnlockUser'] )->name('lock');
            });
        });

        Route::prefix('admin/khach-hang')->group(function() {
            Route::name('khach-hang.')->group(function() {
                Route::get('',  [KhachHangController::class,'index'])->name('list');
                Route::delete('xoa',  [KhachHangController::class,'destroy'])->name('delete');
                Route::post('doi-mat-khau',  [KhachHangController::class,'changePass'])->name('change-pass');
                Route::post('khoa-hoac-mo-khoa',  [KhachHangController::class,'lockOrUnlockUser'])->name('lock');
            });
        });

        Route::prefix('admin/vai-tro')->group(function() {
            Route::name('vai-tro.')->group(function() {
                Route::get('',  [VaiTroController::class,'index'])->name('list');
            });
        });

        Route::prefix('admin/nha-san-xuat')->group(function() {
            Route::name('nha-san-xuat.')->group(function() {
                Route::get('',  [NhaSanXuatController::class,'index'])->name('list');
                Route::get('them-moi',[NhaSanXuatController::class,'create'])->name('create');
                Route::post('them-moi',[NhaSanXuatController::class,'store'])->name('store');
                Route::delete('xoa', [NhaSanXuatController::class,'destroy'])->name('delete');
                Route::get('cap-nhat/{id}', [NhaSanXuatController::class,'edit'])->name('edit');
                Route::post('cap-nhat/{id}',[NhaSanXuatController::class,'update'])->name('update');
            });
        });

        Route::prefix('admin/loai-san-pham')->group(function() {
            Route::name('loai-san-pham.')->group(function() {
                Route::get('', [LoaiSPController::class,'index'] )->name('list');
                Route::get('them-moi', [LoaiSPController::class,'create'] )->name('create');
                Route::post('them-moi', [LoaiSPController::class,'store'] )->name('store');
                Route::delete('xoa', [LoaiSPController::class,'destroy'] )->name('delete');
                Route::get('cap-nhat/{id}', [LoaiSPController::class,'edit'] )->name('edit');
                Route::post('cap-nhat/{id}', [LoaiSPController::class,'update'] )->name('update');
            });
        });

        Route::prefix('admin/san-pham')->group(function() {
            Route::name('san-pham.')->group(function() {
                Route::get('', [SanPhamController::class,'index'] )->name('list');
                Route::get('them-moi', [SanPhamController::class,'create'] )->name('create');
                Route::post('them-moi',[SanPhamController::class,'store']  )->name('store');
                Route::delete('xoa', [SanPhamController::class,'destroy'] )->name('delete');
                Route::get('cap-nhat/{id}',[SanPhamController::class,'edit']  )->name('edit');
                Route::post('cap-nhat/{id}', [SanPhamController::class,'update'] )->name('update');
                Route::get('chi-tiet-san-pham/{id}',[SanPhamController::class,'show'] )->name('detail');
                Route::get('thong-ke', [SanPhamController::class,'statistic'] )->name('statistic');
                Route::get('xuat-excel', [SanPhamController::class,'excel'] )->name('excel');
            });
        });


        Route::prefix('admin/Hoa-don')->group(function() {
            Route::name('Hoa-don.')->group(function() {
                Route::get('', [HoadonController::class,'index'] )->name('list');
                Route::get('cap-nhat/{id}', [HoadonController::class,'edit' ])->name('edit');
                Route::post('cap-nhat/{id}', [HoadonController::class,'update'] )->name('update');
                Route::get('inhoadon/{id}', [HoadonController::class,'inhoadon'] )->name('inhoadon'); 
                Route::delete('xoa', [HoadonController::class,'destroy'] )->name('delete');           
                Route::get('thong-ke', [HoadonController::class,'statistic'] )->name('statistic');
                Route::get('xuat-excel',[HoadonController::class,'excel'] )->name('excel');
            });
        });

        //oder code
        
       
    });
});

Route::get('',[LoginController::class, 'login']);