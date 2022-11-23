@extends('layouts.app')
@section('title', 'All Questions')

@section('content')
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h1 class="my-4"> Questions </h1>
        <a role="button" class="btn btn-secondary btn mx-2 text-center" href="{{ route('formToAskQuestion') }}">Ask Question</a>
    </div>

    <div class="d-flex flex-row">
        <div id="dropdown-sort" class="dropdown">
            <button class="btn btn-sm btn-neutral dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                Sort by
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a id="search-sort-score" class="search-sort dropdown-item" >Score</a>
                <div class="dropdown-divider"></div>
                <a id="search-sort-date" class="search-sort dropdown-item">Date</a>
                <div class="dropdown-divider"></div>
                <a id="search-sort-answercount" class="search-sort dropdown-item">Number of answers</a>
            </div>
        </div>
        <div id="dropdown-order" class="dropdown">
            <i class="align-self-end fa fa-chevron-right" aria-hidden="true"></i>

            <button class="btn btn-sm btn-neutral dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                Order
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a id="search-order-ascending" class="search-order dropdown-item" >Ascending</a>
                <div class="dropdown-divider"></div>
                <a id="search-order-descending" class="search-order dropdown-item">Descending</a>
            </div>
        </div>
    </div>


    @if((count($posts) > 0))
        <section id="search_results">
            @each('partials.postListing', $posts, 'postListing')
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
