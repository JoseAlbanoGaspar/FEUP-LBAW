@extends('layouts.app')

@section('content')
<article class="user-profile">
<h2>{{ $user->username }}'s profile</h2>
    <img src="{{$user->profile_picture }}">
    <a href="">My questions</a>  <!--definir a route -->
    <a href="">My answers</a>
    <p>{{ $user->username }} </p>
    
    <p>Badges<p>
    <div class="user-profile-votes">
        <ul>
            <li>800 upvotes</li>  <!-- change this based on DB -->
            <li>30 downvotes</li>
        </ul>
    </div>
    <div class="user-profile-about">
    <p>{{ $user->personal_text }}</p>
    </div>
</article>