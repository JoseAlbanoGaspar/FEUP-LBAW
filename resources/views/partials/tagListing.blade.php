<div class="tag-card col d-flex flex-column border border-dark p-3">
    
    <div class=>
        <a role="button" class="btn btn-outline-primary btn-sm" href="{{route('tag', ['id_tag' => $tag->id_tag])}}" class="post-tag flex--item">{{$tag->name}}</a>
    </div>

    {{-- if a user is authenticated and follows the tag, it should appear a text in green saying he follows that tag --}}
    @if(Auth::check() && $tag->isFollowedBy(Auth::user()->id_user))
        <div class="d-flex flex-row">
            <span class="isFollowedTag flex--item m-1">You follow this tag</span>
        </div>
    @endif

    <div class="d-flex flex-row">
        <span class="flex--item m-1">Questions: {{count($tag->questions)}}</span>
        <span class="flex--item m-1">Users following: {{count($tag->users)}}</span>
    </div>
</div>