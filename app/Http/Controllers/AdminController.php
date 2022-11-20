<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

use App\Models\User;
use App\Models\Administrator;
use App\Models\Tag;

use App\Http\Controllers\Auth\RegisterController;

class AdminController extends Controller
{
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function show(Request $request)
    {
      $tags = Tag::all();
      $query = $request->query('query');
      $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10);

      return view('pages.admin', ['users' => $users, 'tags'=> $tags,'query' => $query]);
    }
    public function createUser(Request $request){
      $new_user = RegisterController::create($request->all());
      return redirect()->route('users',['id_user' => $new_user->id_user]);
    }

}
