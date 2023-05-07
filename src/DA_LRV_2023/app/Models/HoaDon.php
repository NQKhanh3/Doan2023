<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Kyslik\ColumnSortable\Sortable;

class HoaDon extends Model
{
    use Sortable;
    protected $table = "hoa_don";
    protected $fillable = [
        'ma_hd',
        'khach_hang_id',
        'tong_tien',
        'ngay_dat',
        'dia_chi_nhan',
        'hinh_thuc_thanh_toan',
        'ghi_chu',
        'tinh_trang'
    ];
    public function chitiethoadon() {
        return $this->hasMany(ChiTietHoaDon::class,'hoa_don_id','id');
    }

    public function khachdathang() {
        return $this->belongsTo(KhachHang::class,'khach_hang_id','id');
    }
   
    
    public function scopeGetProductByDate($query, $req) {
        if (empty($req->toDate) && !empty($req->fromDate)) {
            $from = date('Y-m-d', strtotime($req->fromDate));
            $query->whereDate('created_at', '>=', $from);
        }

        if (empty($req->fromDate) && !empty($req->toDate)) {
            $to = date('Y-m-d', strtotime($req->toDate));
            $query->whereDate('created_at', '<=', $to);
        }

        if (!empty($req->fromDate) && !empty($req->toDate)) {
            $from = date('Y-m-d', strtotime($req->fromDate));
            $to = date('Y-m-d', strtotime($req->toDate));
            $query->whereDate('created_at', '>=', $from)
                  ->whereDate('created_at', '<=', $to);
        }

        return $query->select("*")->orderBy('ma_hd');
    }
}
