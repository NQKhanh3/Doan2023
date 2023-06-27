<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\group_user;
use Illuminate\Support\Facades\Hash;

class GroupUserController_admin extends Controller
{
    private $viewFolder = 'groupuser';
    private $page = 'groupuser';

    public function index(Request $req) {
        $pageInfo = [
            'page'  => $this->page
        ];

        $inputSearch = [
            'id_group'  => $req->id_group,
            'id_user'  => $req->id_user,
            'vai_tro'     => $req->vai_tro
        ];

        $isSearch = false;
        foreach($inputSearch as $key => $value) {
            if (!empty($value)) {
                $isSearch = true;
                break;
            }
        }

        $groupuser = group_user::sortable();

        if (!empty($req->id_group)) {
            $groupuser->where('id_group', 'like', "%{$req->id_group}%");
        }

        if (!empty($req->id_user)) {
            $groupuser->where('id_user', 'like', "%{$req->id_user}%");
        }

        if (!empty($req->vai_tro)) {
            $groupuser->where('vai_tro', 'like', "%{$req->vai_tro}%");
        }

        $groupuser = $groupuser->orderBy('id_group')
                               ->paginate($this->limit);
                            //    echo "<pre>";
                            //    print_r($customers);
                            //    exit;
        return view("admin.{$this->viewFolder}.list", compact('pageInfo', 'groupuser', 'inputSearch', 'isSearch'));
    }

    public function destroy(Request $req) {
        $id = $req->id;

        $groupuser = group_user::find($id);

        if (!empty($groupuser)) {
            $groupuser->delete();

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