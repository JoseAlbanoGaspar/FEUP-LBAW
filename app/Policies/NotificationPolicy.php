<?php

namespace App\Policies;

use App\Models\Notification;
use App\Models\User;


use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class NotificationPolicy
{
    use HandlesAuthorization;

    public function owner(User $user, Notification $notification)
    {
        return $user->id_user == $notification->id_user;
    }
}
