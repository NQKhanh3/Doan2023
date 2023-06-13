<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNotice extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('notice', function (Blueprint $table) {
            $table->id();
            $table->integer('id_group')->nullable;
            $table->string('tieu_de', 30);
            $table->string('noi_dung');
            $table->string('mau_sac', 100)->nullable();
            $table->datetime('ngay_bat_dau');
            $table->longText('lap_lai');
            $table->datetime('ngay_ket_thuc');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('notice');
    }
}
