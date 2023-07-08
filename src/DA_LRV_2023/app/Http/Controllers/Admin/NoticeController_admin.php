<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\notice;
use Illuminate\Support\Facades\Hash;
use App\Export\NoticeExport;
use Excel;

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
            'time' => $req->time,
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

        if (!empty($req->time)) {
            $notice->where('time', 'like', "%{$req->time}%");
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

   
    public function getNoticeId($id)
    {   
        $notice = notice::find($id);
        return response()->json($notice);
    }

    public function getNoticeId1($id)
    {   
        $notice = notice::find($id);
        return response()->json($notice);
    }

    public function getNoticeId2($id)
    {   
        $notice = notice::find($id);
        return response()->json($notice);
    }


    public function update(Request $req) {
        // $status = 'error';

        $notice = notice::find($req->id);
        $notice->tieu_de = $req->newtieude;
        $notice->noi_dung = $req->newnoidung;
        $notice->mau_sac = $req->newmausac;
        $notice->ngay = $req->newngay;
        $notice->time = $req->newtime;
        $notice->lap_lai = $req->newlaplai;
        $notice->save();
        return response()->json($notice);
        // if (!empty($user)) {
        //     $status = 'success';

        //     $user->update([
        //         'username'  => $req->new_username
        //     ]);

        //     return redirect()->route("{$this->viewFolder}.list")->with('status', $status)->with('message', $this->msgChangePassSuc);
        // }

       
    }
    public function deleteall(Request $request){
        $id = $request->id;
        notice::whereIn('id',$id)->delete();
        return response()->json([
            'title'     => 'Xóa user',
            'status'    => 'success',
            'msg'       => $this->msgDeleteSuc
        ]);
    }

    // public function exportIntoExcel()
    // {
    //     return Excel::download(new NoticeExport,'Noticelist.xlsx');
    // }

}