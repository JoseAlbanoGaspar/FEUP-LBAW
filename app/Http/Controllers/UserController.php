<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class UserController extends Controller
{
    public function search(Request $request){
        $query = $request->query('query');
        $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10);
        return view('pages.search_users', ['users' => $users]);
    }
     public function search_api(Request $request){
        $query = $request->query('query');
        $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10);
        return json_encode($users);
    }

    /*
    public function create(Request $request)
    {
        $user = new User();
        $this->authorize('create', $user);
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->password = $request->input('password');
        $user->save();
        return $user;
    }

    public function update(Request $request, $id)
    {
        $user = User::find($id);
        $this->authorize('update', $user);
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->password = $request->input('password');
        $user->save();
        return $user;
    }

    public function delete(Request $request, $id)
    {
        $user = User::find($id);
        $this->authorize('delete', $user);
        $user->delete();
        return $user;
    }

    public function show($id)
    {
        $user = User::find($id);
        $this->authorize('show', $user);
        return view('pages.user', ['user' => $user]);
    }

    public function list()
    {
        if (!Auth::check()) return redirect('/login');
        $this->authorize('list', User::class);
        $users = Auth::user()->users()->orderBy('id')->get();
        return view('pages.users', ['users' => $users]);
    }
    */
}
