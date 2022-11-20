<?php

namespace App\Policies;


use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class  AdministrationPolicy
{
    use HandlesAuthorization;

    public function isAdmin(User $user){
        var_dump(count(Auth::user()->administrator()->get()));
        die();
        return count(Auth::user()->administrator()->get());
    }
}