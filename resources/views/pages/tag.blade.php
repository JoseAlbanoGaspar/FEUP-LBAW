@extends('layouts.app')
@section('title', 'Tag')

@section('content')
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h1 class="my-4"> Tag {{$tag->name}} </h1>
        <a role="button" class="btn btn-secondary btn mx-2 text-center" href="{{ route('formToAskQuestion') }}">Ask Question</a>
    </div>

    {{-- button to follow the tag --}}
    @if(!Auth::check())
        <p class="text-center">You need to be logged in to follow a tag.</p>
    @elseif($tag->isFollowedBy(Auth::user()))
        <form action="{{ route('unfollowTag', ['id_tag' => $tag->id_tag]) }}" method="POST">
            @csrf
            @method('DELETE')
            <button type="submit" class="btn btn-danger">Unfollow</button>
        </form>
    @else
        <form action="{{ route('followTag', ['id_tag' => $tag->id_tag]) }}" method="POST">
            @csrf
            <button type="submit" class="btn btn-primary">Follow</button>
        </form>
    @endif

    {{-- list of all questions that have the tag TODO: Questions not appearing --}}
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h4 class="my-4"> Questions with the tag {{$tag->name}} ({{count($tag->questions)}})</h1>
    </div>
    @if((count($tag->questions) > 0))
        <section id="questionList">
                @each('partials.postListing', $tag->questions, 'postListing')
        </section>
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">No questions have this tag. </p>&nbsp;</div>
    @endif


    {{-- list of all users that follow the tag --}}
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h4 class="my-4"> Users following {{$tag->name}} ({{count($tag->users)}})</h1>
    </div>
    @if((count($tag->users) > 0))
        <section id="userList">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 m-1">
                @each('partials.userListing', $tag->users, 'userListing')
            </div>
        </section>
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">No users are following this tag. </p>&nbsp;</div>
    @endif


@endsection