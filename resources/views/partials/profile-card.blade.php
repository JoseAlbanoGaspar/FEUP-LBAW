<div class="user-card col d-inline d-flex justify-content-end">
    <div class="flex-shrink">
        <a href="{{route('users', ['id_user'=>$user->id_user])}}" class="user-card-avatar">
            <div class="gravatar-wrapper-16">
                <img src="{{$user->profile_picture}}" alt="User avatar" width="16" ,="" height="16" class="avatar-image">
            </div>
        </a>
    </div>

    <div class="user-card-info flex-shrink">
            <div class="user-card-link">
                <a href="{{route('users', ['id_user'=>$user->id_user])}}" class="flex--item">{{$user->username}}</a>
            </div>
    </div>

</div>
