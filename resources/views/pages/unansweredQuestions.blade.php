@extends('layouts.app')
@section('title', 'Unanswered Questions')

@section('content')
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h1 class="my-4"> Unanswered Questions </h1>
        <a role="button" class="btn btn-secondary btn mx-2 text-center" href="{{ route('formToAskQuestion') }}">Ask Question</a>
    </div>

    <div class="d-flex justify-content-center flex-column my-3">
        <p class="text-center">Questions that have not been answered yet.</p>
        <p class="text-center">Questions that have been answered are moved to the <a href="{{ route('allQuestions') }}">All Questions</a> page.</p>
        <p class="text-center"><strong>Contribute to the community by answering questions.</strong></p>
    </div>


    @if((count($posts) > 0))
        <section id="search_results">
            @each('partials.postListing', $posts, 'postListing')
        </section>

        @if ($posts->links()->paginator->hasPages())
            <div class="mt-4 p-4 box has-text-centered">
                {{ $posts->withQueryString()->links() }}
            </div>
        @endif
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">Unable to get questions. </p>&nbsp;</div>
    @endif



@endsection
