<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\group;
use Illuminate\Http\Request;
use Validator;
use App\Http\Resources\groupcontroller as GroupResoucre;
class groupcontroller extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
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

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
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

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
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
            $group = Group::find($request->id_leader);
            if (!empty($group)){
                return response()->json([
                    'status' => 500,
                    "message" => "Group đã tồn tại"
                ], 500);
            }
            else{
                $group = Group::create([
                    'id_leader' => $request->id_leader,
                    'name' => $request->name,
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

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
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
                    // 'id' => $request->id,
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
        // }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $group = Group::find($id);
         if ($group){
                $group->delete();
                return response()->json([
                    'status' => 200,
                    "message" => "Delete Group thành công"
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "Group không tồn tại"
                ], 500);
            }
    }
}
