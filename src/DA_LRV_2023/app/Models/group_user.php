<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class group_user extends Model
{
    use HasFactory;
    protected $table = 'group_user';
    protected $fillable = [
        'id_group',
        'id_user',
        'ten'
    ];
}
