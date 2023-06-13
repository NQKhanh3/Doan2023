<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class noticeforuser extends Model
{
    use HasFactory;
    protected $table = 'group_user';
    protected $fillable = [
        'id_notcie',
        'id_user',
        'trang_thai'
    ];
 


}
