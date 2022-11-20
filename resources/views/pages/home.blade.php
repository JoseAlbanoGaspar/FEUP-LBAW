@extends('layouts.app')

@section('title', 'Home')

@section('content')
    <h1 class="my-4 mx-5"> Home </h1>

    @if((count($posts) > 0))
        <section id="search_results">
            @each('partials.post_listing', $posts, 'post_listing')
        </section>

        @if ($posts->links()->paginator->hasPages())
            <div class="mt-4 p-4 box has-text-centered">
                {{ $posts->links() }}
            </div>
        @endif
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">Unable to get posts. </p>&nbsp;</div>
    @endif



@endsection
