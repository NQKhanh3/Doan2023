<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\group_user;
use Illuminate\Http\Request;
use App\Http\Resources\group_userResouce;
use App\Models\User;

class group_usercontroller extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $group =group_user::all() ;
        $arr = [
            'status' => true,
            'message' => "Danh sách user theo nhóm",
            'data'=>group_userResouce::collection($group)
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
        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $user = User::where('email', 'like',$request->email )->get();
        // $group = Group::where('id_leader', 'like')
        // $check=['id_group' => $request->id_group, 'id_user' => $user[0]->id];
        if( 'id_group' == $request->id_group & 'id_user' == $user[0]->id ){
            return response()->json([
                'status' => 500,
                "message" => "User đã tồn tại trong group"
            ], 500);
        }
        else{
            $groupuser = group_user::create([
                    'id_user' => $user[0]->id,
                    'id_group' => $request->id_group,
                    'vai_tro' => 'member'
                ]);
                if ($groupuser){
                    return response()->json([
                        'status' => 200,
                        "message" => "Add user vào Group thành công"
                    ], 200);
                }
                else{
                    return response()->json([
                        'status' => 500,
                        "message" => "Add user vào Group không thành công"
                    ], 500);
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
        $groupuser = group_user::find($id);
        if($groupuser){
            return response()->json([
                'status' => 200,
                "Group User" => $groupuser
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy Group User"
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
    public function update(Request $request)
    {
        $groupuser = group_user::find($request->id);
            if ($groupuser){
                $groupuser->update([
                    'id_group' => $request->id_group,
                    'id_user' => $request->id_user,
                    'vai_tro' => $request->vai_tro,
                ]);
                return response()->json([
                    'status' => 200,
                    "message" => "Update Group User thành công"
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "Group User không tồn tại"
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
        $groupuser = group_user::find($id);
            if ($groupuser){
                $groupuser->delete();
                return response()->json([
                    'status' => 200,
                    "message" => "Delete Group User thành công"
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "Group User không tồn tại"
                ], 500);
            }
    }
}
