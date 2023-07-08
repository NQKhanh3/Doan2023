<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\noticeforuser;
use Illuminate\Http\Request;
use App\Http\Resources\noticeforuserResouce as noticeforuserResouce;
use App\Models\User;

class noticeforusercontroller extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $u =noticeforuser::all() ;
        $arr = [
            'status' => true,
            'message' => "Danh sách xem thong bao",
            'data'=> noticeforuserResouce::collection($u)
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
        
        if( 'id_notcie' == $request->id_notcie & 'id_user' == $request->id ){
            return response()->json([
                'status' => 500,
                "message" => "đã có"
            ], 400);
        }
        else{
            $noticeuser = noticeforuser::create([
                    'id_user' => $request->id,
                    'id_notcie' => $request->id_notcie,
                    'trang_thai' => '1'
                ]);
                if ($noticeuser){
                    return response()->json([
                        'status' => 200,
                        "message" => "Add user vào Group thành công"
                    ], 200);
                }
                else{
                    return response()->json([
                        'status' => 400,
                        "message" => "Add user vào Group không thành công"
                    ], 400);
                }
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
       $not =noticeforuser::where("id_notcie","=",$id)->get();
       if($not){
        $count=noticeforuser::where("id_notcie","=",$id)->count();
        return response()->json([
            'status' => 200,
            "data" => $not,
            "count"=>$count
        ], 200);
       }
       else{
        return response()->json([
            'status' => 401,
            "message" => "Tạo Group không thành công"
        ], 401);
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
