@extends('layouts.app')

@section('content')
<article class="user-profile my-4 mx-5">
    <h1>{{ $user->username }}'s profile</h1>

    <div class="d-flex">    
        <div>
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
                <a type="button" class="btn btn-primary" href="{{ route('userQuestions',['id_user' => $user->id_user]) }}">My questions</a>
                <a type="button" class="btn btn-primary" href="{{ route('userAnswers',['id_user' => $user->id_user]) }}">My answers</a>
                <a type="button" class="btn btn-primary" href="{{ route('drafts')}}">My drafts</a>
                @if (Auth::check() && Auth::user()->can('editProfile', $user) && Auth::id() == $user->id_user && (count(Auth::user()->administrator()->get()) || count(Auth::user()->moderator()->get())))
                <a type="button" class="btn btn-primary" href="{{ route('admin') }}">Admin</a>
                @endif
            </div>
        </div>
        <div class="badges">
            <h3>Badges</h3>
            <div class="d-flex">
                <div class="dropdown">
                    <button class="btn btn-warning">Gold
                        <span class="btn btn-light btn-sm">{{$badges['Gold']}}</span>
                    </button>
                    <ul>
                        @foreach($gold as $g)
                        <li>{{$g->name}}</li>
                        @endforeach
                    </ul>
                </div>
                
                
                <div class="dropdown">
                    <button class="btn btn-light">Silver
                        <span class="btn btn-secondary btn-sm">{{$badges['Silver']}}</span>
                    </button>
                    <ul>
                        @foreach($silver as $g)
                        <li>{{$g->name}}</li>
                        @endforeach
                    </ul>
                </div>
                
                <div class="dropdown">
                    <button class="btn btn-secondary">Bronze
                        <span class="btn btn-light btn-sm">{{$badges['Gold']}}</span>
                    </button>
                    <ul>
                        @foreach($bronze as $g)
                        <li>{{$g->name}}</li>
                        @endforeach
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="user-profile-about">
    <h3>About:</h3>
    @if(empty($user->personal_text))
        <i class="fs-5">No personal text available.</i>
    @else
        <p class="fs-5">{{ $user->personal_text }}</p>
    @endif
    </div>


    <div class="user-profile-votes">
        <h3>Interactions with questions:</h3>
        <ul class="list-group gap-2">
            <li class="list-group-item d-flex justify-content-between align-items-center">
            Upvotes
            <span class="badge bg-primary rounded-pill">{{$question_votes['up']}}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
            Downvotes
            <span class="badge bg-primary rounded-pill">{{$question_votes['down']}}</span>
            </li>
        </ul>
    </div>
    <div class="user-profile-votes">
        <h3>Interactions with answers:</h3>
        <ul class="list-group gap-2">
            <li class="list-group-item d-flex justify-content-between align-items-center">
            Upvotes
            <span class="badge bg-primary rounded-pill">{{$answer_votes['up']}}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
            Downvotes
            <span class="badge bg-primary rounded-pill">{{$answer_votes['down']}}</span>
            </li>
        </ul>
    </div>


    @if (Auth::check() && Auth::user()->can('editProfile', $user))
    <div class="d-flex align-items-center my-2">
        <form class="my-2" method='GET' action="{{ route('editProfile',['id_user' => $user->id_user]) }}">
            <button type="submit" class="btn btn-secondary">Edit Profile  <i class="fa fa-pencil" aria-hidden="true"></i></button>
        </form>
        <form class="mx-2" method='POST' action="{{route('deleteUser')}}">
            @method('DELETE')
            {{ csrf_field() }}
            <input type="hidden" value="{{$user->id_user}}" name="id_user"/>
            <button type="submit" class="btn btn-danger btn-secondary mx-2 text-center admin">Delete Account</button>
        </form>
    </div>
    @endif

</article>
@endsection
