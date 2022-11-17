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
</article>
