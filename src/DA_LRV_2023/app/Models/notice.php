<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class notice extends Model
{
    use HasFactory;
    protected $table = 'notice';
    protected $fillable = [
        'id_group',
        'tieu_de',
        'noi_dung',
        'mau_sac',
        'ngay_bat_dau',
        //ngay
        'lap_lai',
        'ngay_ket_thuc'
    ];

}
