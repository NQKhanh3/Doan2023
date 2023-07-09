<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\noticecontroller as noticeResouce;
use App\Models\notice;
use App\Models\group;
use Illuminate\Support\Facades\DB;

class noticecontroller extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $u =notice::all() ;
        $arr = [
            'status' => true,
            'message' => "Danh sách thong bao",
            'data'=> noticeResouce::collection($u)
            ];
             return response()->json($arr, 200);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // $group = group::where('id', 'like',$request->id )->get();
        // // $group = Group::where('id_leader', 'like')
        // // $check=['id_group' => $request->id_group, 'id_user' => $user[0]->id];
        // if( 'id_group' == $request->id_group & 'id_user' == $user[0]->id ){
        //     return response()->json([
        //         'status' => 500,
        //         "message" => "User đã tồn tại trong group"
        //     ], 500);
        // }
        // else{
            $notice = notice::create([
                    'id_group' => $request->id_group,
                    'tieu_de' => $request->tieu_de,
                    'noi_dung' => $request->noi_dung,
                    'mau_sac' => $request->mau_sac,
                    'ngay' => $request->ngay,
                    'lap_lai' => $request->lap_lai
                ]);
                if ($notice){
                    return response()->json([
                        'status' => 200,
                        "message" => "Tạo Notice thành công"
                    ], 200);
                }
                else{
                    return response()->json([
                        'status' => 500,
                        "message" => "Tạo task không thành công"
                    ], 500);
                }
        // }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $notice = notice::find($id);
        if($notice){
            return response()->json([
                'status' => 200,
                "Notice" => $notice
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy Notice"
            ], 404);
        }
    }
    public function showforGroup($id)
    {
        $notice = DB::table('notice')->where('id_group','=',$id)->get();
        if($notice){
            return response()->json([
                'status' => 200,
                "data" => $notice
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy Notice"
            ], 404);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $notice = notice::find($request->id);
            if ($notice){
                $notice->update([
                    'id_group' => $request->id_group,
                    'tieu_de' => $request->tieu_de,
                    'noi_dung' => $request->noi_dung,
                    'mau_sac' => $request->mau_sac,
                    'ngay' => $request->ngay,
                    'time' => $request->time,
                    'lap_lai' => $request->lap_lai,
                ]);
                return response()->json([
                    'status' => 200,
                    "message" => "Update Notice thành công"
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "Notice không tồn tại"
                ], 500);
            }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $notice = notice::find($id);
            if ($notice){
                $notice->delete();
                return response()->json([
                    'status' => 200,
                    "message" => "Delete Notice thành công"
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "Notice không tồn tại"
                ], 500);
            }
    }
}
