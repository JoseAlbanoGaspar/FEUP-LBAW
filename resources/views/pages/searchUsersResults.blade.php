@extends('layouts.app')

@section('content')
    <form action="{{ route('searchUsers') }}" method="GET">
        <label id="users-search-bar" class="mx-2">
            <input type="text" name="query" placeholder="Search for users" >
        </label>
        <button type="submit">Search</button>
    </form>

    @if((count($users) > 0))
        <section id="search_users_results">
            @each('partials.userListing', $users, 'userListing')
        </section>
        @if ($users->links()->paginator->hasPages())
            <div class="mt-4 p-4 box has-text-centered">
                {{ $users->links() }}
            </div>
        @endif
    @else
        <p id="results_not_found_message">No users found matching your search</p>
    @endif

@endsection
