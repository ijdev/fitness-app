<?php

namespace App\Http\Controllers;
use App\Http\Requests\RegisterRequest;
use App\Http\Resources\UserResource;
use App\User;
use Illuminate\Http\Request;
use Auth;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class UserController extends Controller
{

//    public function __construct()
//    {
//        $this->middleware('auth:api', ['except' => ['login']]);
//    }

    /**
     * Get a JWT via given credentials.
     *
     * @param RegisterRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
//    public function login()
//    {
//        $credentials = request(['email', 'password']);
//
//        if (! $token = auth()->attempt($credentials)) {
//            return response()->json(['error' => 'Unauthorized'], 401);
//        }
//
//        return $this->respondWithToken($token);
//    }

    public function register(RegisterRequest $request){
       // $plainPassword=$request->password;
//        $password=bcrypt($request->password);
//        $request->request->add(['password' => $password]);
        // create the user account
        $created=User::create([
            'name' => request('name'),
            'email' => request('email'),
            'password' => bcrypt(request('password'))
        ]);
        //$request->request->add(['password' => $plainPassword]);
        // login now..
        return $this->login($request);
    }
    public function login(Request $request){

        $creds = $request->only('email', 'password');
        $token = auth()->attempt($creds);
        if ($token == false) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid Email or Password',
            ], 401);
        }
        // get the user
        $user = Auth::user();

        return response()->json([
            'success' => true,
            'token' => $token,
            'user' => $user
        ]);
    }
}
