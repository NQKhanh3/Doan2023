<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\notice;
use Illuminate\Support\Facades\Hash;

class NoticeController_admin extends Controller
{
    private $viewFolder = 'notice';
    private $page = 'notice';

    public function index(Request $req) {
        $pageInfo = [
            'page'  => $this->page
        ];

        $inputSearch = [
            'id_group'  => $req->id_group,
            'tieu_de'  => $req->tieu_de,
            'noi_dung'     => $req->noi_dung,
            'mau_sac' => $req->mau_sac,
            'ngay' => $req->ngay,
            'lap_lai' => $req->lap_lai
        ];

        $isSearch = false;
        foreach($inputSearch as $key => $value) {
            if (!empty($value)) {
                $isSearch = true;
                break;
            }
        }

        $notice = notice::sortable();

        if (!empty($req->id_group)) {
            $notice->where('id_group', 'like', "%{$req->id_group}%");
        }

        if (!empty($req->tieu_de)) {
            $notice->where('tieu_de', 'like', "%{$req->tieu_de}%");
        }

        if (!empty($req->noi_dung)) {
            $notice->where('noi_dung', 'like', "%{$req->noi_dung}%");
        }

        if (!empty($req->mau_sac)) {
            $notice->where('mau_sac', 'like', "%{$req->mau_sac}%");
        }

        if (!empty($req->ngay)) {
            $notice->where('ngay', 'like', "%{$req->ngay}%");
        }

        if (!empty($req->lap_lai)) {
            $notice->where('lap_lai', 'like', "%{$req->lap_lai}%");
        }

        $notice = $notice->orderBy('id_group')
                               ->paginate($this->limit);
                            //    echo "<pre>";
                            //    print_r($customers);
                            //    exit;
        return view("admin.{$this->viewFolder}.list", compact('pageInfo', 'notice', 'inputSearch', 'isSearch'));
    }

    public function destroy(Request $req) {
        $id = $req->id;

        $notice = notice::find($id);

        if (!empty($notice)) {
            $notice->delete();

            return response()->json([
                'title'     => 'Xóa notice',
                'status'    => 'success',
                'msg'       => $this->msgDeleteSuc
            ]);
        }

        return response()->json([
            'title'     => 'Xóa notice',
            'status'    => 'error',
            'msg'       => $this->msgDeleteErr
        ]);
    }

    // public function changePass(Request $req) {
    //     $status = 'error';

    //     $group = group::find($req->id);

    //     if (!empty($group)) {
    //         $status = 'success';

    //         $group->update([
    //             'password'  => Hash::make($req->new_pass)
    //         ]);

    //         return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $this->msgChangePassSuc);
    //     }

    //     return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $this->msgChangePassErr);
    // }

    // public function lockOrUnlockUser(Request $req) {
    //     $user = User::find($req->id);

    //     if (!empty($user)) {
    //         $user->update(['bi_khoa' => !$user->bi_khoa]);
    //         $title = ($user->bi_khoa == 1) ? 'Khóa' : 'Mở khóa';
    //         return response()->json([
    //             'title'     => "{$title} user",
    //             'status'    => 'success',
    //             'msg'       => 'Thành công'
    //         ]);
    //     }

    //     return response()->json([
    //         'title'     => "{$title} $user",
    //         'status'    => 'error',
    //         'msg'       => 'Có lỗi trong khi thực hiện'
    //     ]);
    // }
}