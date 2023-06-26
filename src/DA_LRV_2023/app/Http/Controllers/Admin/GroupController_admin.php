<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\group;
use Illuminate\Support\Facades\Hash;

class GroupController_admin extends Controller
{
    private $viewFolder = 'group';
    private $page = 'group';

    public function index(Request $req) {
        $pageInfo = [
            'page'  => $this->page
        ];

        $inputSearch = [
            'id_leader'  => $req->id_leader,
            'name'     => $req->name
        ];

        $isSearch = false;
        foreach($inputSearch as $key => $value) {
            if (!empty($value)) {
                $isSearch = true;
                break;
            }
        }

        $group = group::sortable();

        if (!empty($req->id_leader)) {
            $group->where('id_leader', 'like', "%{$req->id_leader}%");
        }

        if (!empty($req->name)) {
            $group->where('name', 'like', "%{$req->name}%");
        }

        $group = $group->orderBy('id_leader')
                               ->paginate($this->limit);
                            //    echo "<pre>";
                            //    print_r($customers);
                            //    exit;
        return view("admin.{$this->viewFolder}.list", compact('pageInfo', 'group', 'inputSearch', 'isSearch'));
    }

    public function destroy(Request $req) {
        $id = $req->id;

        $group = group::find($id);

        if (!empty($group)) {
            $group->delete();

            return response()->json([
                'title'     => 'Xóa group',
                'status'    => 'success',
                'msg'       => $this->msgDeleteSuc
            ]);
        }

        return response()->json([
            'title'     => 'Xóa group',
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