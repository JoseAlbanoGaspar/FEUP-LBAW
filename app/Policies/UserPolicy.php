<?php

namespace App\Policies;

use App\Models\Post;
use App\Models\User;


use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class UserPolicy
{
    use HandlesAuthorization;

    public function show(User $user, Card $card)
    {
      // Only a card owner can see it
      return $user->id == $card->user_id;
    }

    public function list(User $user)
    {
      // Any user can list its own cards
      return Auth::check();
    }

    public function create(User $user)
    {
      // Any user can create a new card
      return Auth::check();
    }
    public function isAdministrator(User $user){
      return count($user->administrator()->get());
    }
    public function editProfile(User $auth,User $user){
      //Users can only edit their own profiles or admin

      return (Auth::check() && $user->id_user == Auth::id()) || count(Auth::user()->administrator()->get());
    }
    public function delete(User $user, Card $card)
    {
      // Only a card owner can delete it
      return $user->id == $card->user_id;
    }
    public function owner(User $user, Post $post)
    {
      return $user->id_user == $post->id_author;
    }

    public function ownerOrPrivileged(User $user, Post $post)
    {
      return $user->id_user == $post->id_author || $user->administrator || $user->moderator;
    }
}
