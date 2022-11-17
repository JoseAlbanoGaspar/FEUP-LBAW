@php $truncated = (strlen($post_listing->text_body) > 38) ? substr($post_listing->text_body,0,35).'...' :
    $post_listing->text_body;
    include_once(app_path() . '/Includes/Utils.php');
@endphp

@if($post_listing->question)
    @include('partials.question-card', ['post' => $post_listing])
@elseif($post_listing->answer)

    <div class="answer-card card mx-5 my-2">
        <div class = "card-body row">
            <div class="answer-stats col-2">

                <div class="answer-stats-item">
                    <span class="answer-stats-score-number">{{$post_listing->answer->score}}</span>
                    <span class="answer-stats-score-unit">votes</span>
                </div>

                <div class="answer-stats-item">
                    <span class="answer-stats-is-solution">{{$post_listing->answer->is_solution}}</span>
                </div>
            </div>

            <div class="post-summary col-10">

                <div class ="row"><h6 class="original-question-title">Original question:</h6> <a href="{{route('questions', ['id'=>$post_listing->answer->question->id_question])}}"><h7 class="card-title">{{$post_listing->answer->question->title}}</h7></a></div>
                <div class ="row"><a href="{{route('questions', ['id'=>$post_listing->answer->question->id_question])}}#{{'answerid-'.$post_listing->answer->id_answer}}"><h5 class="card-text">{{$truncated}}</h5></a></div>


                @include('partials.profile-card', ['user' => $post_listing->user])

                <time class="user-card-time flex-shrink">
                    answered {{timeElapsedString($post_listing->date)}}
                </time>

                </div>
            </div>

        </div>
    </div>
    </div>

@endif

{{--<article class="post_listing" data-id="{{ $post_listing->id_post }}">--}}
{{--    @php $truncated = (strlen($post_listing->text_body) > 38) ? substr($post_listing->text_body,0,35).'...' :--}}
{{--    $post_listing->text_body;--}}
{{--    @endphp--}}
{{--    @if($post_listing->question)--}}
{{--        <a href="{{route('questions', ['id' => $post_listing->id_post])}}"><h4>Q: {{$post_listing->question->title}}</h4></a>--}}
{{--        <p>{{$truncated}}</p>--}}
{{--    @elseif($post_listing->answer)--}}
{{--        <a href="{{route('questions', ['id' => $post_listing->answer->question->id_question])}}#answer-{{$post_listing->id_answer}}"><h4>A: {{$truncated}}</h4></a>--}}
{{--    @endif--}}


{{--</article>--}}
