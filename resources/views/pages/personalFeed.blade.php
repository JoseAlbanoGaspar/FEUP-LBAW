@extends('layouts.app')
@section('title', 'Personal Feed')

@section('content')
    @if((count($posts) > 0))
        <section id="search_results">
            @each('partials.post_listing', $posts, 'post_listing')
        </section>
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">Unable to get your personal feed. </p>&nbsp;</div>
    @endif

    <div class="d-flex flex-row justify-content-center">
        <div class="card">
            <div class="card-body">
                <a href="{{ route('allQuestions') }}">View all questions</a>
            </div>
        </div>

@endsection
