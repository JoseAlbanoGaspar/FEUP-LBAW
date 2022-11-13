<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

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
      if(Administrator::find($id)) $role = 'Administrator';

      return view('profile.profile', ['user' => $user, 'role'=> $role]);
    }
}
