 <div class = "mx-4">
    <form action="" class="m-4 d-flex flex-row" >
{{--        {{ csrf_field() }}--}}
        <label id="users-search-bar" class="mx-2">
            <input  class="form-control mx-2" type="text" name='query' placeholder="Search for users" value="{{$query}}">
        </label>
        <button class="btn btn-secondary mx-3" type="button"><i class="fa fa-search"></i></button>
    </form>

@if(Auth::check() && Auth::user()->administrator)
<label>See as admin</label>
<input type="checkbox" checked="true" onclick="adminMode()"/>
@endif
    @if((count($users) > 0))
        <section id="search_users_results my-3 mx-3">
            @each('partials.userListing', $users, 'userListing')
        </section>
        @if ($users->links()->paginator->hasPages())
            <div class="box has-text-centered my-3">
                {{ $users->links() }}
            </div>
        @endif
    @else
        <div class="box has-text-centered">
            <p id="results_not_found_message">No users found matching your search</p>
            @include('partials.goBackButton')
        </div>
    @endif
 </div>
