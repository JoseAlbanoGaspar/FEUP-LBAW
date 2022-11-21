<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

use App\Models\User;
use App\Models\Administrator;
use App\Models\Moderator;

class UserController extends Controller
{
    public function post_score($posts){
      $up_post = 0;
      $down_post = 0;

      foreach($posts as $vote){
        if($vote->score == -1) $up_post = $up_post + 1;
        if($vote->score == 1) $down_post = $down_post + 1;
      }

      $post_score = ['up' => $up_post,'down' => $down_post];
      return $post_score;
    }
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id)
    {
      $user = User::find($id);
      $role = 'Standard User';
      if(Moderator::find($id)) $role = 'Moderator';
      else if(Administrator::find($id)) $role = 'Administrator';

      $question_votes = $this->post_score($user->question_votes()->get());
      $answer_votes = $this->post_score($user->answer_votes()->get());



      return view('pages.profile', ['user' => $user, 'role'=> $role,'question_votes' => $question_votes,'answer_votes' => $answer_votes]);
    }

    public function getEditProfile($id){
      $user = User::find($id);
      $this->authorize('editProfile',$user);
      return view('pages.edit', ['user' => $user]);
    }

    public function update(Request $request){
      $user = User::find($request->id_user);

      $this->authorize('editProfile',$user);
      //validate results
      $validator = Validator::make($request->all(),[
            'username' => 'min:5|max:25|regex:/^((?!deleted_user).)*$/',
            'email' => 'min:5|max:50|regex:/^((?!deleted_email).)*$/|regex:/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/',
            'personal_text' => 'max:255',
            'password' => 'nullable|confirmed|min:6',
      ]);

      if($validator->fails()){
        return redirect()->route('editProfile',['id_user' => $user->id_user])->withInput()->withErrors($validator);
      }

      //updating...
      $user->username = $request->name;
      $user->email = $request->email;
      $user->personal_text = $request->personal_text;
      if($request->password != NULL) $user->password = bcrypt($request->password);

      $img = $request->profile_picture;
      if($img != null){
          $path = 'storage/images/';
          $imageName = Auth::id(). '-profile-picture.' . $img->extension();
          $img->storeAs('public/images', $imageName);
          $user->profile_picture = $path . $imageName;
      }

      //store updated information
      $user->save();
      return redirect()->route('editProfile',['id_user' => $user->id_user]);
    }


    public function search(Request $request){
        $query = $request->query('query');
        $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10);
        return view('pages.searchUsers', ['users' => $users, 'query' => $query]);
    }
    public function searchApi(Request $request){
        $query = $request->input('query');
        $page = $request->input('page');
        if(is_null($page)){
            $page = 1;
        }
        else{
            $page = intval($page);
        }
        $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10, ['*'], 'page', $page);
        $hasPages =  $users->links()->paginator->hasPages();
        $links =  $users->links()->render();
        $returnHTML = view('pages.searchUsersResults', ['users' => $users, 'query' => $query])->render();
        return response()->json(array('success' => true, 'html'=>$returnHTML));
    }
    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    public static function validator(array $data)
    {
        return Validator::make($data, [
            'username' => 'required|string|min:5|regex:/^((?!deleted_user).)*$/|max:25|unique:users',
            'email' => 'required|string|email|min:5|max:50|regex:/^((?!deleted_email).)*$/|regex:/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'personal_text' => 'max:255',
            'terms'=> 'accepted'
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\Models\User
     */
    public static function create(array $data)
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
