<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Models\User;
use App\Http\Resources\usercontroller as UserResoucre;
class usercontroller extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $user =User::all() ;
        $arr = [
            'status' => true,
            'message' => "Danh sách User",
            'data'=>UserResoucre::collection($user)
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
        // $input = $request->all(); 
        // // $validator = Validator::make($input, [
        // // 'email' => 'required', 'password' => 'required'
        // // ]);
        // // if($validator->fails()){
        // //     $arr = [
        // //     'success' => false,
        // //     'message' => 'Lỗi kiểm tra dữ liệu',
        // //     'data' => $validator->errors()
        // //     ];
        // //     return response()->json($arr, 200);
        // // }
        // $user = User::create($input);
        // $arr = ['status' => true,
        //     'message'=>"User đã lưu thành công",
        //     'data'=> new UserResoucre($user)
        // ];
        // return response()->json($arr, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
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
        // $user= User::findOrFail($id);
        // if(!empty($user)){
        // $user->username=$request->username;
        // // $user->old=$request->old;
        // // $user->phone=$request->phone;
        // $user->save();
       
        //     return response()->json([
        //         'code'=>200,
        //     'data'=> $user,
        //     ],200);
        // }
        //     return response()->json([
                
        //     'mess'=>"lỗi ",
        //     ],400);
    
        $user = User::find($request->id);
        if(!empty($user)){
            
            $user->username  = $request->username;
            $user->hinh_dai_dien  = $request->hinh_dai_dien;
            $user->google_id  = $request->google_id;
            $image =$request->file('image');
            if($request ->hasFile('image')){
                $new =rand().'.'.$image->getClientOriginalExtension();
                $image->move(public_path('uploads/images'),$new);
                
            };
            // $user->hinh_dai_dien = 'http://10.0.2.2:8000/uploads/images/'.$new;
            $user->save(); 
            return response()->json(['user'=>$user], 200);
        }
        return response()->json([
            
        'mess'=>"Email không tồn tại",
        ],400);

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {  
        $user = User::find($id);
         if ($user){
                $user->delete();
                return response()->json([
                    'status' => 200,
                    "message" => "Delete user thành công"
                ], 200);
            }
            else{
                return response()->json([
                    'status' => 500,
                    "message" => "user không tồn tại"
                ], 500);
            }
    }
}
