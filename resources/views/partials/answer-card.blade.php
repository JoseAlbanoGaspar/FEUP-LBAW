@php $truncated = (strlen($post->text_body) > 38) ? substr($post->text_body,0,35).'...' :
    $post->text_body;
    include_once(app_path() . '/Includes/Utils.php');
@endphp

<div class="answer-card card mx-5 my-2">
    <div class = "card-body d-flex justify-content-center p-3">
        <div class="answer-stats col-2 d-flex justify-content-center flex-column py-4">

            @include('partials.stats-score', ['score' => $post->answer->score])

        </div>

        <div class="post-summary col-10">

            <div class ="row">
                <h6 class="original-question-title">Original question:</h6>
                <a href="{{route('questions', ['id'=>$post->answer->question->id_question])}}">
                    <h6 class="card-title">{{$post->answer->question->title}}</h6>
                </a>
            </div>

            <div class ="row">

                @if($post->answer->is_solution)
                    <a class="text-decoration-none" href="{{route('questions', ['id'=>$post->answer->question->id_question])}}#{{'answerid-'.$post->answer->id_answer}}">
                        <h5 class="card-text is-solution-{{$post->answer->is_solution}}">{{$truncated}} <a href='#' data-toogle="tooltip" data-bs-placement="right" title="The question onwer accepted this as the best answer"><i class="fa fa-check" aria-hidden="true"></i></a></h5>
                    </a>
                @else
                <a class="text-decoration-none" href="{{route('questions', ['id'=>$post->answer->question->id_question])}}#{{'answerid-'.$post->answer->id_answer}}">
                    <h5 class="card-text is-solution-{{$post->answer->is_solution}}">{{$truncated}}</h5>
                </a>
                @endif

            </div>


            <div class = "user-card col d-inline d-flex justify-content-end">
                @include('partials.profile-card', ['user' => $post->user])

                <time class="user-card-time flex-shrink">
                    &nbsp;&nbsp;answered {{timeElapsedString($post->date)}}
                </time>
            </div>

        </div>

    </div>
</div>
