@php $truncated = (strlen($post->text_body) > 38) ? substr($post->text_body,0,35).'...' :
    $post->text_body;
    include_once(app_path() . '/Includes/Utils.php');
@endphp

<div class="answer-card card mx-5 my-2">
    <div class = "card-body row">
        <div class="answer-stats col-2">

            <div class="answer-stats-item">
                <span class="answer-stats-score-number">{{$post->answer->score}}</span>
                <span class="answer-stats-score-unit">votes</span>
            </div>

            <div class="answer-stats-item">
                <span class="answer-stats-is-solution">{{$post->answer->is_solution}}</span>
            </div>
        </div>

        <div class="post-summary col-10">

            <div class ="row"><h6 class="original-question-title">Original question:</h6> <a href="{{route('questions', ['id'=>$post->answer->question->id_question])}}"><h6 class="card-title">{{$post->answer->question->title}}</h6></a></div>
            <div class ="row"><a href="{{route('questions', ['id'=>$post->answer->question->id_question])}}#{{'answerid-'.$post->answer->id_answer}}"><h5 class="card-text">{{$truncated}}</h5></a></div>


            <div class = "user-card col d-inline d-flex justify-content-end">
                @include('partials.profile-card', ['user' => $post->user])

                <time class="user-card-time flex-shrink">
                    &nbsp;&nbsp;asked {{timeElapsedString($post->date)}}
                </time>
            </div>

        </div>

    </div>
</div>