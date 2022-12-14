@extends('layouts.app')
@section('content')
    <h5 class="text-left">Your drafts:</h5>

    @if((count($drafts) > 0))
        <section id="search_results">
            @each('partials.draftListing', $drafts, 'draft')
        </section>
        @if ($drafts->links()->paginator->hasPages())
            <div class="mt-4 p-4 box has-text-centered">
                {{ $drafts->links() }}
            </div>
        @endif
    @else
        <div class="d-flex flex-row" ><p id="results_not_found_message">You do not have any drafts.</p></div>
    @endif



@endsection
