<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Auth;
use Validator;
use App\Models\User;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'username' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:8'
            ]        
        );
        if($validator->fails())return response()->json($validator->errors());
        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'bi_khoa' => "0"
         ]);
         $token = $user->createToken('auth_token')->plainTextToken;
         return response()->json(
         ['data' => $user,'access_token' => $token, 'token_type' => 'Bearer', ]);
    }

    public function login(Request $request) 
    {
        // if (!Auth::attempt($request->only('email', 'mat_khau')))  {
        //    return response()->json(['message' => 'Unauthorized'], 401);
        // }
        // $user = User::where('email', $request['email'])->firstOrFail();
        // $token = $user->createToken('auth_token')->plainTextToken;
        // return response()->json(['message' => 'Chào '.$user->username.'! Chúc an lành',
        //    'access_token' => $token, 'token_type' => 'Bearer',]);
        // }
        // public function logout()  {
        //   auth()->user()->tokens()->delete();
        //   return ['message' => 'Bạn đã thoát ứng dụng và token đã xóa'];

         $checklogin=['email' => $request->email, 'password' => $request->password, 'bi_khoa' => 0];
      
        if (Auth::attempt($checklogin)) {
        // //     // $checktoken =SessionUser::where('id','=',Auth::id())->first();
            // $user =Auth::id();
            $user = User::where('email', $request['email'])->firstOrFail();
        // //    if(empty( $checktoken)){
        // //     $usersession= SessionUser::create([
        // //     'token'=>Str::random(40),
        // //     'refresh_token'=>Str::random(40),
        // //     'token_expried'=>date('Y-m-d H:i:s', strtotime('+1 day')),
        // //     'refresh_token_expried'=>date('Y-m-d H:i:s', strtotime('+7 day')),
        // //     'id'=>Auth::id(),
        // //    ]);
        // // } else {
        // //     $usersession = $checktoken;
        // // }
        return response()->json(['message' => 'Chào '.$user->username.'! Chúc an lành']);
        } 
        else{
            return response()->json([
            'code'=>401,
        'message'=>'Email hoặc Password sai hoặc tài khoản đã bị khóa! Vui lòng nhập lại',
        ],401
        );
        }
    }
    
}
