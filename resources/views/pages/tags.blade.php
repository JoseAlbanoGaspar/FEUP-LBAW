@extends('layouts.app')
@section('title', 'Tags')

@section('content')
    <div class="d-flex flex-row align-items-center justify-content-between mx-5 my-2">
        <h1 class="my-4"> Tags </h1>
        <a role="button" class="btn btn-secondary btn mx-2 text-center" href="{{ route('formToAskQuestion') }}">Ask Question</a>
    </div>

    @if((count($tags) > 0))
        <section id="allTags">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 m-1">
                @each('partials.tagListing', $tags, 'tag')
            </div>
        </section>
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">Unable to get tags. </p>&nbsp;</div>
    @endif



@endsection
