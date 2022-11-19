@extends('layouts.app')

@section('content')
<article class="user-profile my-4 mx-5">
    <h1>{{ $user->username }}'s profile</h1>
    
    <div class="d-flex justify-content-start align-items-center">
        <div class="gravatar-wrapper-16 m-2 me-5">
            <img src="{{ asset($user->profile_picture) }}"  alt="{{ $user->username }}'s user avatar" width="100" ,="" height="100" class="avatar-image rounded-circle">
        </div>

        <div class="d-flex justify-content-around flex-column">
            <p class="fw-bold fs-5">{{ $user->username }} </p>
            <p class="fst-italic fs-6"> {{ $role }} </p> 
        </div>
        
    </div>
    
    <div class="d-grid gap-5-lg gap-2 d-md-block my-4">
        <a type="button" class="btn btn-primary" href="{{ route('myQuestions',['id_user' => $user->id_user]) }}">My questions</a>
        <a type="button" class="btn btn-primary" href="{{ route('myAnswers',['id_user' => $user->id_user]) }}">My answers</a>
    </div>

    <div class="user-profile-about">
    <h3>About:</h3>
    <p class="fs-5">{{ $user->personal_text }}</p>
    </div>


    <div class="user-profile-votes">
        <ul class="list-group gap-2">
            <li class="list-group-item d-flex justify-content-between align-items-center">
            Upvotes
            <span class="badge bg-primary rounded-pill">800</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
            Downvotes
            <span class="badge bg-primary rounded-pill">30</span>
            </li>
        </ul>
    </div>

        
 
    <form class="my-3" method='GET' action="{{ route('editProfile',['id_user' => $user->id_user]) }}">
        <button type="submit" class="btn btn-secondary">Edit Profile  <i class="fa fa-pencil" aria-hidden="true"></i></button>
    </form>
</article>
@endsection