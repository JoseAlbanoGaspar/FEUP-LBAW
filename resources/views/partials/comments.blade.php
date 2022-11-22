<div id="comments" class="comments bt bc-black-075 mt12 ">
    <ul class="comments-list">      
        @foreach ($comments as $comment)
        <li class="comment p-2 border-bottom">
            <span class="comment-body">{{ $comment->post->text_body}}</span>

            <div class="d-inline-flex ai-center">
                –&nbsp;<a href="/users/{{ $comment->post->user->id_user}}" class="comment-user">{{ $comment->post->user->username}}</a>
            </div>
            <div class="comment-date d-inline-flex ai-center">
                &nbsp;{{ $comment->post->date}}
            </div>
        </li>
        @endforeach
    </ul>
    <form id="post-comment-form" action="/questions/{{$post->id_post}}/comment/submit" method="post" class="d-inline">
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Add comment" aria-label="Add comment" aria-describedby="basic-addon2">
            <div class="input-group-append">
              <button class="btn btn-outline-secondary mx-3" type="button">Submit</button>
            </div>
        </div>
    </form>
</div>