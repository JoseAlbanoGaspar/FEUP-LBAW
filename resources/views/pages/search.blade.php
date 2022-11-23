@extends('layouts.app')
@php
use Illuminate\Http\Request;
$request = Request::capture();
@endphp
{{--@section('title', 'Posts Search')--}}

@section('content')
<h5 class="text-left">Search results for: {{$request->input('query')}}</h5>
<div class="d-flex flex-row">
    <div id="dropdown-filter" class="dropdown">
        <button class="btn btn-sm btn-neutral dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            Filters
        </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <a  id="search-filter-all" class="search-filter dropdown-item" >All</a>
            <div class="dropdown-divider"></div>
            <a id="search-filter-questions" class="search-filter dropdown-item">Questions</a>
            <div class="dropdown-divider"></div>
            <a id="search-filter-answers" class="search-filter dropdown-item">Answers</a>
        </div>
    </div>
    <div id="dropdown-sort" class="dropdown">
        <button class="btn btn-sm btn-neutral dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            Sort by
        </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <a id="search-sort-score" class="search-sort dropdown-item" >Score</a>
            <div class="dropdown-divider"></div>
            <a id="search-sort-date" class="search-sort dropdown-item">Date</a>
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
            {{ $posts->withQueryString()->links() }}
        </div>
    @endif
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">No posts found matching your search: </p>&nbsp;<strong>{{$request->query('query')}}</strong></div>
    @endif



@endsection
