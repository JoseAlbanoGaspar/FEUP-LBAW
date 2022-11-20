<form action="{{ route('searchUsers') }}" method="GET">
    <label id="users-search-bar">
        <input  type="text" name="query" placeholder="Search for users" value="{{$query}}">
    </label>
    <button type="submit">Search</button>
</form>

@if((count($users) > 0))
    <section id="search_users_results">
        @each('partials.user_listing', $users, 'user_listing')
    </section>
    @if ($users->links()->paginator->hasPages())
        <div class="mt-4 p-4 box has-text-centered">
            {{ $users->links() }}
        </div>
    @endif
@else
    <p id="results_not_found_message">No users found matching your search</p>
@endif
