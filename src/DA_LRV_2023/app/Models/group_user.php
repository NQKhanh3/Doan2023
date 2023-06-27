<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Kyslik\ColumnSortable\Sortable;

class group_user extends Model
{
    use HasFactory, Sortable;
    protected $table = 'group_user';
    protected $fillable = [
        'id_group',
        'id_user',
        'vai_tro'
        //biet danh
    ];
}
