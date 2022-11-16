@extends('layouts.app')

@section('title', 'Posts Search')

@section('content')
    @if((count($posts) > 0))
    <section id="search_results">
        @each('partials.post_listing', $posts, 'post_listing')
    </section>
    @else
    <p id="results_not_found_message">No posts found matching your search</p>
    @endif

@endsection
