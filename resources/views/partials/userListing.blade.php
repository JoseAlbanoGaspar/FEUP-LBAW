<article class="d-flex flex-row  user_listing my-2">
    @if($userListing->profile_picture )
        <div class="gravatar-wrapper-40">
            <img src="{{$userListing->profile_picture}}" alt="User avatar" width="40"  height="40" class="avatar-image">
        </div>
    @else
        <div class="gravatar-wrapper-40">
            <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="User avatar" width="40"  height="40" class="avatar-image">
        </div>
    @endif
    <a class='align-self-end text-decoration-none' href="{{route('users', ['id_user' => $userListing->id_user])}}">
        <h4> {{$userListing->username}}
        </h4>
    </a>

    @if(Auth::check() && Auth::user()->administrator())
    <div class="d-flex align-items-center">
        <a role="button" type="button" class="btn btn-secondary btn-sm mx-2 text-center admin" href="{{route('editProfile',['id_user' => $userListing->id_user]) }}">Edit</a>
        <form class="mx-2 d-flex" method='POST' action="{{route('deleteUser')}}">
            @method('DELETE')
            {{ csrf_field() }}
            <input type="hidden" value="{{$userListing->id_user}}" name="id_user"/>
            <button type="submit" class="btn btn-danger btn-sm mx-2 text-center admin">Delete</button>
        </form>
        @if(! $userListing->administrator)
        <form class="mx-2 d-flex" method='POST' action="{{route('makeAdmin')}}">
            {{ csrf_field() }}
            <input type="hidden" value="{{$userListing->id_user}}" name="id_user"/>
            <button type="submit" class="btn btn-warning btn-sm h-auto admin">Make Admin</button>
        </form>
        @endif
    </div>
    @endif
</article>
