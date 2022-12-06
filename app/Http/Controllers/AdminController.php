<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

use App\Models\User;
use App\Models\Administrator;
use App\Models\Tag;
use App\Models\Report;
use App\Models\Post;

use App\Http\Controllers\UserController;


class AdminController extends Controller
{
    /**
     * Shows the user for a given id.
     * @param  int  $id
     * @return Response
     */
    public function show(Request $request)
    {
      $this->authorize('isAdministrator', User::class);
      $tags = Tag::all();
      
      $reports = Report::select('id_post')->distinct()->get();
      $ret_reports = array();
      foreach($reports as $id_post){
        $rep = array();
        $rep['id_post'] = $id_post['id_post'];
        $number = Report::where('id_post','=',$id_post['id_post'])->get();
        $rep['counter'] = count($number);
        $reasons = array();
        foreach($number as $reason){
          $reasons[] = $reason->reason;
        }
        $rep['reasons'] = $reasons;
        $rep['post'] = Post::find($id_post['id_post']);
        $ret_reports[] = $rep;
      }

      return view('pages.admin', ['tags'=> $tags,'reports' => $ret_reports]);
    }

    /**
     * Create a new user
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function createUser(Request $request){
      $this->authorize('isAdministrator', User::class);
      $validator =   Validator::make($request->all(), [
            'username' => 'required|string|min:5|regex:/^((?!deleted_user).)*$/|max:25|unique:users',
            'email' => 'required|string|email|min:5|max:50|regex:/^((?!deleted_email).)*$/|regex:/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'personal_text' => 'max:255'
        ]);

      if($validator->fails()){
        return redirect()->route('admin',['tags' => Tag::all()])->withInput()->withErrors($validator);
      }
      $new_user = UserController::create($request->all());
      return redirect()->route('users',['id_user' => $new_user->id_user]);
    }

    public function makeAdmin(Request $request){
      //$this->authorize('isAdministrator', App\Model\User::class);
      Administrator::create(['id_admin' => $request->id_user]);
      return redirect()->route('users',['id_user' => $request->id_user]);
    }

}
