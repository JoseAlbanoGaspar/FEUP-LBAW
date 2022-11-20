<?php

namespace App\Policies;


use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class  AdministratorPolicy extends UserPolicy
{
    use HandlesAuthorization;
}