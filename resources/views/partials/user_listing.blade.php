<article class="d-flex flex-row  user_listing">
    @if($user_listing->profile_picture )
        <div class="gravatar-wrapper-40">
            <img src="{{$user_listing->profile_picture}}" alt="User avatar" width="40"  height="40" class="avatar-image">
        </div>
    @else
        <div class="gravatar-wrapper-40">
            <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="User avatar" width="40"  height="40" class="avatar-image">
        </div>
    @endif
   <a class='align-self-end' href="{{route('users', ['id_user' => $user_listing->id_user])}}"> <h4> {{$user_listing->username}}  </h4> </a>
   <!--$user = Auth::user()
    if($user->admin()) -->
    <div class="flex-shrink">
        <a href="{{route('editProfile',['id_user' => $user_listing->id_user]) }}">
            <button>Edit</button>
        </a>
        <a href=""> <!-- define route (not for A8) -->
            <button>Delete</button>
        </a>
        <form method='POST' action="{{route('makeAdmin')}}">
            {{ csrf_field() }}
            <input type="hidden" value="{{$user_listing->id_user}}" name="id_user"/>
            <button type="submit">Make Admin</button>
        </form>
    </div>
</article>
