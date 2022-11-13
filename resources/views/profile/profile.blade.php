@extends('layouts.app')

@section('content')
<article class="user-profile">
    <h2>{{ $user->username }}'s profile</h2>
    <img src="{{$user->profile_picture }}">
    <a href="{{ route('myQuestions',['id_user' => $user->id_user]) }}">My questions</a> 
    <a href="{{ route('myAnswers',['id_user' => $user->id_user]) }}">My answers</a>
    <p>{{ $user->username }} </p>
    <p> {{ $role }} </p> 
    <p>Badges<p>
    <div class="user-profile-votes">
        <ul>
            <li>800 upvotes</li>  <!-- change this based on DB -->
            <li>30 downvotes</li>
        </ul>
    </div>
    <div class="user-profile-about">
    <h3>About:</h3>
    <p>{{ $user->personal_text }}</p>
    </div>
</article>