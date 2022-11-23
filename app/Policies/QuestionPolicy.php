<?php

namespace App\Policies;

use App\Models\Post;
use App\Models\Question;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;


class QuestionPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can ask a question.
     *
     * @param  \App\Models\User  $user
     * @return mixed
     */
    public function askQuestion(User $user)
    {
        return !$user->blocked;
    }


}
