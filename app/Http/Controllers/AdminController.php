<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

use App\Models\User;
use App\Models\Administrator;
use App\Models\Tag;

use App\Http\Controllers\UserController;

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
      return view('pages.admin', ['tags'=> $tags]);
    }
    public function createUser(Request $request){
      $validator = UserController::validator($request->all());
      if($validator->fails()){
        return redirect()->route('admin',['tags' => Tag::all()])->withInput()->withErrors($validator);
      }
      $new_user = UserController::create($request->all());
      return redirect()->route('users',['id_user' => $new_user->id_user]);
    }

}
