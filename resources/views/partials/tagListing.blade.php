<div class="tag-card col d-flex flex-column border border-dark p-3">
    
    <div class=>
        <a role="button" class="btn btn-outline-primary btn-sm" href="{{route('tag', ['id_tag' => $tag->id_tag])}}" class="post-tag flex--item">{{$tag->name}}</a>
    </div>

    <div class="d-flex flex-row">
        <span class="flex--item m-1">Questions: {{count($tag->questions)}}</span>
        <span class="flex--item m-1">Users following: {{count($tag->users)}}</span>
    </div>
</div>