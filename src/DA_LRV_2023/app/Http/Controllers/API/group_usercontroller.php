<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\group_user;
use Illuminate\Http\Request;
use App\Http\Resources\group_userResouce;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class group_usercontroller extends Controller
{
 
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

  
    public function create()
    {
        
    }

    public function store(Request $request)
    {
         $group = group_user::where(
            'id_user', $request->id_user)->
            where('id_group' , $request->id_group)->get();
        if(!$group->isEmpty()){
            return response()->json([
                'status' => 400,
                "message" => "User đã tồn tại trong group"
                ], 400);
        }
        else{
            $groupuser = group_user::create([
                    'id_user' => $request->id_user,
                    'id_group' => $request->id_group,
                    'vai_tro' => 'member',
                    'trang_thai'=>0
                ]);
                if ($groupuser){
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

    public function showforID_user($id)
    {
        $groupuser = group_user::where('id_user',$id)->where("trang_thai",'=',0)->get();
        
        if($groupuser){
            return response()->json([
                'status' => 200,
                "data" => $groupuser
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

     public function updatestatus(Request $request)
     {
         $groupuser = DB::table('group_user')
         ->where('id_user',$request->id_user)
         ->where("id_group",$request->id_group);
        
             if ($groupuser){
                 $groupuser->update([
                     "trang_thai"=>1
                 ]);
                 return response()->json([
                     'status' => 200,
                     //"message" => $groupuser
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
