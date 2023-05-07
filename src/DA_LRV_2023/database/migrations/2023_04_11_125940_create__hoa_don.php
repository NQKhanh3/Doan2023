<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHoaDon extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hoa_don', function (Blueprint $table) {
            $table->id();
            $table->string('ma_hd', 255);
            $table->foreignId('khach_hang_id');
            $table->double('tong_tien');
            $table->datetime('ngay_dat');
            $table->string('dia_chi_nhan', 255);
            $table->string('hinh_thuc_thanh_toan', 100);
            $table->string('ghi_chu', 255)->nullable();
            $table->string('tinh_trang', 50)->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hoa_don');
    }
}
