<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\group;
use Illuminate\Http\Request;
use Validator;
use App\Http\Resources\groupcontroller as GroupResoucre;
use App\Models\group_user;
use Illuminate\Support\Facades\DB;

class groupcontroller extends Controller
{
   
    public function index()
    {
        $group =group::all() ;
        $arr = [
            'status' => true,
            'message' => "Danh sách nhóm",
            'data'=>GroupResoucre::collection($group)
            ];
             return response()->json($arr, 200);
    }

  
    public function create(Request $request)
    {
        // try{
        //     $group = new Group();
        //     $group->id_leader = $request->input('id_leader');
        //     $group->name = $request->input('name');
        //     $group->save();
        //     return response()->json([
        //         'data' => $group,
        //         "message" => "Tạo Group thành công"
        //     ], 200);
        // } catch(Throwable $err){
        //     return $err->getMessage();
        // }
    }

   
    public function store(Request $request)
    {

        $validator = Validator::make($request->all(),[
            'id_leader' => 'required',
        ]);
        if($validator->fails()){
            return response()->json([
                'mess'=> $validator->messages(),
                ],400);
        }
        else{
            
              
                $group = Group::create([
                    'id_leader' => $request->id_leader,
                    'name' => $request->name,
                    'nen'=>""
                ]);

                    group_user::create([
                        'id_group'=>$group->id,
                        'id_user'=>$request->id_leader,
                        'vai_tro'=>'quan ly',
                        'trang_thai'=>1
                    ]);
                if ($group){
                    return response()->json([
                        'status' => 200,
                        "message" => "Tạo Group thành công"
                    ], 200);
                }
                else{
                    return response()->json([
                        'status' => 500,
                        "message" => "Tạo Group không thành công"
                    ], 500);
                }
           
        }

    }

    
    public function show($id)
    {
        $group = Group::find($id);
        if($group){
            return response()->json([
                'status' => 200,
                "group" => $group
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy group"
            ], 404);
        }
    }
    public function showid_leader($id)
    {
        $group = DB::table('group')->where('id_leader','=',$id)->get();
        if($group){
            return response()->json([
                'status' => 200,
                "data" => $group
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy group"
            ], 404);
        }
    }

   
    public function showGroupforuser($id)
    {
        $groupuser = group_user::select('id_user')->where('id_group','=',$id)->get();
       
        //$users = DB::table('users')->join('groupuser','users.id','=',$groupuser)->get();
        $users = DB::table('users')->whereIn('id',$groupuser)->get();;
        
        if($groupuser){
            return response()->json([
                'status' => 200,
                "data" => $users
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy Group User"
            ], 404);
        }
    }
    //usergroup
    public function showUserforgroup($id)
    {
        $groupuser = group_user::select(['id_group'])->where('id_user','=',$id)->get();
        $group = DB::table('group')->whereIn('id',$groupuser)
        ->get();
     
        
        if($groupuser){
            return response()->json([
                'status' => 200,
                "data" => $group
            ], 200);
        }
        else{
            return response()->json([
                'status' => 404,
                "message" => "Không tìm thấy Group User"
            ], 404);
        }
    }
    
    public function update(Request $request)
    {
        // $validator = Validator::make($request->all(),[
        //     'id' => 'required|string',
        // ]);
        // if($validator->fails()){
        //     return response()->json([
        //         'mess'=> $validator->messages(),
        //         ],400);
        // }
        // else{
            $group = Group::find($request->id);
           
              if ($group){
                $group->update([
                    
                    'id_leader' => $request->id_leader,
                    'name' => $request->name,
                   ]);
                return response()->json([
                    'status' => 200,
                    "message" => "Update Group thành công"
                ], 200);
            }
            
          
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "Group không tồn tại"
                ], 500);
            }
        
    }

    public function outGroup($request)
    {
        $group = DB::table('group_user')
        ->where("id_group","=",$request->id_group)
            ->where("id_user","=",$request->id_user)->get();
            
        

        

            if(!$group->isEmpty()){
                $group->delete();
                
                return response()->json([
                    'status' => 200,
                    "message" => "Delete Group thành công"
                ], 200);
            }
            
            else{
                return response()->json([
                    'status' => 400,
                    "message" => "Group không tồn tại"
                ], 400);
            }

    }
    public function destroy($id)
    {
        $group = Group::where('id',$id);
        
        $notice=DB::table("notice")->where("id_group","=",$id)->get();

         if ($group){
            $group_user=DB::table('group_user')->where("id_group","=",$id)->delete();
              
                   
                 
                $group->delete();
                return response()->json([
                    'status' => 200,
                    "message" => "Delete Group thành công"
                   
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 400,
                    "message" => "Group không tồn tại"
                ], 400);
            }
    }
}
