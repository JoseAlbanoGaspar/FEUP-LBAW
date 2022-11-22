<?php

namespace App\Policies;


use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class TagPolicy extends UserPolicy
{
    use HandlesAuthorization;

}