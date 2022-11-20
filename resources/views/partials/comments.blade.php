<div class="post-layout--right js-post-comments-component">
    <div id="comments" class="comments js-comments-container bt bc-black-075 mt12 " data-post-id="54894" data-min-length="15">
        <ul class="comments-list js-comments-list" data-remaining-comments-count="2" data-canpost="false" data-cansee="true" data-comments-unavailable="false" data-addlink-disabled="true">      
            @foreach ($comments as $comment)

            <li class="comment">
                <span class="comment-copy">{{ $comment->post->text_body}}</span>

                <div class="d-inline-flex ai-center">
                    –&nbsp;<a href="/users/{{ $comment->post->user->id_user}}" class="comment-user">{{ $comment->post->user->username}}</a>
                </div>
            </li>

            @endforeach
        </ul>
    </div>

    {{--<div id="comments-link-54894" data-rep="50" data-anon="true">
        <a class="js-add-link comments-link dno" title="Use comments to ask for more information or suggest improvements. Avoid answering questions in comments." href="#" role="button"></a>
        <span class="js-link-separator dno">&nbsp;|&nbsp;</span>
        <a class="js-show-link comments-link " title="Expand to show all comments on this post" href="#" onclick="" role="button">Show <b>2</b> more comments</a>
    </div>--}}
</div>