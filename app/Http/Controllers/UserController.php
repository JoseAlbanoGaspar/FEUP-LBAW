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

      return view('pages.profile', ['user' => $user, 'role'=> $role]);
    }

    public function getEditProfile($id){
      $user = User::find($id);
      return view('pages.edit', ['user' => $user]);
    }

    public function update(Request $request){
      $user = User::find($request->id_user);

      //authorize the edition!!! -> Uncomment after implemented loggin
      //$this->authorize('editProfile',$request->id_user);
      //validate results
      $validator = Validator::make($request->all(),[
            'name' => 'min:5|max:25|regex:/^((?!deleted_user).)*$/',
            'email' => 'min:5|max:30|regex:/^((?!deleted_email).)*$/|regex:/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/',
            'personal_text' => 'max:256',
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
      $path = 'storage/images/';
      $imageName = Auth::id(). '-profile-picture.' . $img->extension();
      $img->storeAs('public/images', $imageName);
      $user->profile_picture = $path . $imageName;

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
        return view('pages.search_users', ['users' => $users, 'query' => $query]);
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
//        return view('partials.searchUsersResults', ['users' => $users])->render();

//        return json_encode(['users' => $users,'hasPages' =>$hasPages, 'links' => $links]);
    }
}
