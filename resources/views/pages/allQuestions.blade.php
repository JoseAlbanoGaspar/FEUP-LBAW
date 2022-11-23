@extends('layouts.app')
@section('title', 'All Questions')

@section('content')
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h1 class="my-4"> Questions </h1>
        <a role="button" class="btn btn-secondary btn mx-2 text-center" href="{{ route('FormToAskQuestion') }}">Ask Question</a>
    </div>
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
        <div class="d-flex flex-row" ><p id="results_not_found_message">Unable to get questions. </p>&nbsp;</div>
    @endif



@endsection
