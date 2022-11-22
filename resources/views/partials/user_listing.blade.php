<article class="d-flex flex-row  user_listing my-2">
    @if($user_listing->profile_picture )
        <div class="gravatar-wrapper-40">
            <img src="{{$user_listing->profile_picture}}" alt="User avatar" width="40"  height="40" class="avatar-image">
        </div>
    @else
        <div class="gravatar-wrapper-40">
            <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="User avatar" width="40"  height="40" class="avatar-image">
        </div>
    @endif
    <a class='align-self-end text-decoration-none' href="{{route('users', ['id_user' => $user_listing->id_user])}}">
        <h4> {{$user_listing->username}}
        </h4>
    </a>

    @if(Auth::check() && Auth::user()->administrator())
    <div class="d-flex align-items-center">
         <a role="button" type="button" class="btn btn-secondary btn-sm mx-2 text-center admin" href="{{route('editProfile',['id_user' => $user_listing->id_user]) }}">Edit</a>

        <!-- define route (not for A8) -->
        <a role="button" type="button" class="btn btn-danger btn-sm mx-2 text-center admin" href="\">Delete</a>
        @if(! $user_listing->administrator)
        <form class="mx-2 d-flex" method='POST' action="{{route('makeAdmin')}}">
            {{ csrf_field() }}
            <input type="hidden" value="{{$user_listing->id_user}}" name="id_user"/>
            <button type="submit" class="btn btn-warning btn-sm h-auto admin">Make Admin</button>
        </form>
        @endif
    </div>
    @endif
</article>
