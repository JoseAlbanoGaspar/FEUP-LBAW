
@if(!str_contains($user->username, 'deleted'))
<div class="flex-shrink">
    <a href="{{route('users', ['id_user'=>$user->id_user])}}" class="user-card-avatar">
        <div class="gravatar-wrapper-16">
            <img src="{{asset($user->profile_picture)}}" alt="{{$user->username}}'s user avatar" width="16" ,="" height="16" class="avatar-image">
        </div>
    </a>
</div>
@endif

<div class="user-card-info flex-shrink">
        <div class="user-card-link">
            @if(str_contains($user->username, 'deleted') === false)
                <a href="{{route('users', ['id_user'=>$user->id_user])}}" class="user-card-name">{{$user->username}}</a>
            @else
                <span class="user-card-name text-muted">Deleted user</span>
            @endif
        </div>
</div>
