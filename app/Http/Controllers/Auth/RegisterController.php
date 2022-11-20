<?php

namespace App\Http\Controllers\Auth;


use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\RegistersUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
//use App\Http\Controllers\Auth\RegistersUsers;

class RegisterController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    use RegistersUsers;

    /**
     * Where to redirect users after registration.
     *
     * @var string
     */
    public function redirectTo()
    {
        $id = Auth::id();

        return 'users/' . strval($id);
    }
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest');
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'username' => 'required|string|max:255|unique:users',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'personal_text' => 'max:255'
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\Models\User
     */
    protected function create(array $data)
    {
        $path = 'storage/images/';
        $profile_image_url = $path . 'default-user.jpg';
        
        
        
        if(array_key_exists('profile_picture', $data)){
            $img = $data['profile_picture'];
            $new_id = DB::table('users')->latest('id_user')->first()->id_user + 1;
            
            $imageName = strval($new_id). '-profile-picture.' . $img->extension(); 
            $img->storeAs('public/images', $imageName);
            $profile_image_url = $path . $imageName;
        }

        return User::create([
            'username' => $data['username'],
            'email' => $data['email'],
            'password' => bcrypt($data['password']),
            'personal_text' => $data['personal_text'],
            'profile_picture' => $profile_image_url
        ]);
    }

    
}
