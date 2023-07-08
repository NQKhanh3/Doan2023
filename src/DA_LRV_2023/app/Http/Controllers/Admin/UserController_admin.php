<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserController_admin extends Controller
{
    private $viewFolder = 'user';
    private $page = 'user';

    public function index(Request $req) {
        $pageInfo = [
            'page'  => $this->page
        ];

        $inputSearch = [
            'username'  => $req->username,
            'email'     => $req->email,
            // 'sdt'       => $req->sdt,
            'bi_khoa'   => $req->bi_khoa
        ];

        $isSearch = false;
        foreach($inputSearch as $key => $value) {
            if (!empty($value)) {
                $isSearch = true;
                break;
            }
        }

        $user = User::sortable();

        if (!empty($req->username)) {
            $user->where('username', 'like', "%{$req->username}%");
        }

        if (!empty($req->email)) {
            $user->where('email', 'like', "%{$req->email}%");
        }

        // if (!empty($req->sdt)) {
        //     $user->where('sdt', $req->sdt);
        // }

        if (isset($req->bi_khoa)) {
            $user->where('bi_khoa', $req->bi_khoa);
        }

        $user = $user->orderBy('username')
                               ->paginate($this->limit);
                            // ->paginate(3);
                            //    echo "<pre>";
                            //    print_r($customers);
                            //    exit;  

        return view("admin.{$this->viewFolder}.list", compact('pageInfo', 'user', 'inputSearch', 'isSearch'));

        // $user = User::paginate(3);
        // return view("admin.user.list")->with('user',$user);


    }

    public function deleteall(Request $request){
        $id = $request->id;
        User::whereIn('id',$id)->delete();
        return response()->json([
            'title'     => 'Xóa user',
            'status'    => 'success',
            'msg'       => $this->msgDeleteSuc
        ]);
    }

    public function lockall(Request $request){
        $id = $request->id;
        $user = User::whereIn('id',$id)->update(['bi_khoa'  => "1"]);
        // $user->bi_khoa = "1";
        // $user->save();
        // $user->update([
        //     'bi_khoa'  => "1"
        // ]);
        $user->save(); 
        return response()->json([
            'title'     => "Update user",
            'status'    => 'success',
            'msg'       => 'Thành công'
        ]);

    }

    public function unlockall(Request $request){
        $id = $request->id;
        $user = User::whereIn('id',$id)->update(['bi_khoa'  => "0"]);
        // $user->bi_khoa = "0";
        // $user->save();
        // $user->update([
        //     'bi_khoa'  => "0"
        // ]);
        $user->save(); 
        return response()->json([
            'title'     => "Update user",
            'status'    => 'success',
            'msg'       => 'Thành công'
        ]);

    }

    public function destroy(Request $req) {
        $id = $req->id;

        $user = User::find($id);

        if (!empty($user)) {
            $user->delete();

            return response()->json([
                'title'     => 'Xóa user',
                'status'    => 'success',
                'msg'       => $this->msgDeleteSuc
            ]);
        }

        return response()->json([
            'title'     => 'Xóa user',
            'status'    => 'error',
            'msg'       => $this->msgDeleteErr
        ]);
    }

    public function changePass(Request $req) {
        $status = 'error';

        $user = User::find($req->id);

        if (!empty($user)) {
            $status = 'success';

            $user->update([
                'password'  => Hash::make($req->new_pass)
            ]);

            return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $this->msgChangePassSuc);
        }

        return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $this->msgChangePassErr);
    }

    public function lockOrUnlockUser(Request $req) {
        $user = User::find($req->id);

        if (!empty($user)) {
            $user->update(['bi_khoa' => !$user->bi_khoa]);
            $title = ($user->bi_khoa == 1) ? 'Khóa' : 'Mở khóa';
            return response()->json([
                'title'     => "{$title} user",
                'status'    => 'success',
                'msg'       => 'Thành công'
            ]);
        }

        return response()->json([
            'title'     => "{$title} $user",
            'status'    => 'error',
            'msg'       => 'Có lỗi trong khi thực hiện'
        ]);
    }

    public function getUserById($id)
    {   
        $user = User::find($id);
        return response()->json($user);
    }

    public function update(Request $req) {
        // $status = 'error';

        $user = User::find($req->id);
        $user->username = $req->newusername;
        $user->save();
        return response()->json($user);
        // if (!empty($user)) {
        //     $status = 'success';

        //     $user->update([
        //         'username'  => $req->new_username
        //     ]);

        //     return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $this->msgChangePassSuc);
        // }

       
    }
}