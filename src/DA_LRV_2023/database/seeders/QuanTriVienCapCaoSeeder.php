<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\QuanTriVien;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;

class QuanTriVienCapCaoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Schema::disableForeignKeyConstraints();
        QuanTriVien::truncate();
        Schema::enableForeignKeyConstraints();

        QuanTriVien::firstOrCreate(
            ['ten_tai_khoan' => 'admin'],
            [
                'mat_khau'      => Hash::make('admin@123'),
<<<<<<< HEAD
              
=======
                // 'vai_tro_id'    => 1,
>>>>>>> 917a2dfe3211290adb398a3205f7ec2b6d2375ac
                'ten'           => 'Quản trị viên'
            ]
        );
    }
}
