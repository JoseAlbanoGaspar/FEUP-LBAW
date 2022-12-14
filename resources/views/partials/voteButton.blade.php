@php
$isAnswer = isset($post->id_answer);
if($isAnswer){
    $id = $post->id_answer;
}
else{
    $id = $post->id_question;
}
@endphp
<div class="votecell d-flex flex-column align-items-center">
        <button id="upvote-button-{{$id}}" class="flex--item btn btn-outline-secondary vote-button upvote-button" aria-pressed="false" aria-label="Up vote">
            <i class="fa fa-caret-up"></i>
        </button>

        <div id="post-score-id-{{$id}}" class="flex--item d-flex fd-column ai-center fc-black-500 fs-title post-score" itemprop="upvoteCount" data-value="7">
            {{$post->score}}
        </div>
        <button id="downvote-button-{{$id}}"  class="flex--item btn btn-outline-secondary vote-button downvote-button" aria-pressed="false" aria-label="Down vote">
            <i class="fa fa-caret-down"></i>
        </button>

</div>
<script></script>
