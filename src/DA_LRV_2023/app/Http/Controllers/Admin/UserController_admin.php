<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
// use App\Models\ChiTietSP;
use App\Models\User;

class UserController_admin extends Controller
{
    private $viewFolder = 'user';
    private $page = 'user';

    public function index(Request $req) {
        $pageInfo = [
            'page'  => $this->page
        ];

        $keyword = (empty($req->keyword)) ? null : $req->keyword;

        $user = User::sortable();

        if (!empty($keyword)) {
            $user->where('email', 'like', "%{$keyword}%");
        }

        $user = $user->orderBy('email')
                                     ->paginate($this->limit);

        return view("admin.{$this->viewFolder}.list", compact('pageInfo', 'user', 'keyword'));
    }

    public function create() {
        $pageInfo = [
            'subtitle'  => $this->add,
            'page'      => $this->page,
            'route'     => $this->viewFolder
        ];

        return view("admin.{$this->viewFolder}.store-edit", compact('pageInfo'));
    }

    public function store(Request $req) {
        $status = "error";
        $message = $this->msgStoreErr;

        $valid = $this->validate($req, [
            // 'ten'   => 'required|unique:nha_san_xuat,ten|regex:/^[\w_ÀÁÃẢẠÂẤẦẨẪẬĂẮẰẲẴẶÈÉẸẺẼÊỀẾỂỄỆÌÍĨỈỊÒÓÕỌỎÔỐỒỔỖỘƠỚỜỞỠỢÙÚŨỤỦƯỨỪỬỮỰỲỴÝỶỸĐàáãạảâấầẩẫậăắằẳẵặèéẹẻẽêềếểễệìíĩỉịòóõọỏôốồổỗộơớờởỡợùúũụủưứừửữựỳýỵỷỹđ\s]{1,50}$/',
        ], [
            'email.required'  => 'Vui lòng nhập tên',
            'email.unique'    => 'Tên đã tồn tại'
            // 'ten.regex'     => 'Tên không đúng định dạng'
        ]);

        $user = User::create($valid);

        if (!empty($user)) {
            $status = "success";
            $message = $this->msgStoreSuc;
        }

        return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $message);
    }

    public function edit($id) {
        $pageInfo = [
            'subtitle'  => $this->edit,
            'page'      => $this->page,
            'route'     => $this->viewFolder
        ];

        $user = User::find($id);

        if (!empty($user)) {
            return view("admin.{$this->viewFolder}.store-edit", compact('pageInfo', 'user'));
        }

        $status = 'error';
        $message = $this->msgNotFound;

        return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $message);
    }

    public function update(Request $req, $id) {
        $status = 'error';
        $message = $this->msgUpdateErr;

        $user = User::find($id);

        if (!empty($user)) {
            $valid = $this->validate($req, [
                // 'email'   => "required|unique:user,email,{$user->id}|regex:/^[\w_ÀÁÃẢẠÂẤẦẨẪẬĂẮẰẲẴẶÈÉẸẺẼÊỀẾỂỄỆÌÍĨỈỊÒÓÕỌỎÔỐỒỔỖỘƠỚỜỞỠỢÙÚŨỤỦƯỨỪỬỮỰỲỴÝỶỸĐàáãạảâấầẩẫậăắằẳẵặèéẹẻẽêềếểễệìíĩỉịòóõọỏôốồổỗộơớờởỡợùúũụủưứừửữựỳýỵỷỹđ\s]{1,50}$/",
            ], [
                'email.required'  => 'Vui lòng nhập tên',
                'email.unique'    => 'Tên đã tồn tại'
                // 'ten.regex'     => 'Tên không đúng định dạng'
            ]);

            $user->update($valid);

            $status = 'success';
            $message = $this->msgUpdateSuc;
        }

        return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $message);
    }

    public function destroy(Request $req) {
        // $id = $req->id;

        // $user = User::find($id);

        // if (!empty($user)) {
        //     $detail_product = ChiTietSP::where('nha_sx_id', $manufacture->id)
        //                                ->first();
        //     if (empty($detail_product)) {
        //         $manufacture->delete();

        //         return response()->json([
        //             'title'     => 'Xóa nhà sản xuất',
        //             'status'    => 'success',
        //             'msg'       => $this->msgDeleteSuc
        //         ]);
        //     }

        //     return response()->json([
        //         'title'     => 'Xóa nhà sản xuất',
        //         'status'    => 'error',
        //         'msg'       => $this->msgDeleteCant
        //     ]);
        // }

        // return response()->json([
        //     'title'     => 'Xóa nhà sản xuất',
        //     'status'    => 'error',
        //     'msg'       => $this->msgDeleteErr
        // ]);
    }
}