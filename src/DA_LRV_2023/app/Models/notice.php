<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Kyslik\ColumnSortable\Sortable;

class notice extends Model
{
    use HasFactory, Sortable;
    protected $table = 'notice';
    protected $fillable = [
        'id_group',
        'tieu_de',
        'noi_dung',
        'mau_sac',
        'ngay',
        'time',
        'lap_lai'
    ];

}