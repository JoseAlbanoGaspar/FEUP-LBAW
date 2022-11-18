@php $truncated = (strlen($post_listing->text_body) > 38) ? substr($post_listing->text_body,0,35).'...' :
    $post_listing->text_body;
    include_once(app_path() . '/Includes/Utils.php');

@endphp
@if($post_listing->question)
    <div class="question-card card mx-5 my-2">
        <div class = "card-body d-flex justify-content-center">
            <div class="question-stats col-2 d-flex justify-content-around flex-column">

                <div class="question-stats-item">
                    <span class="question-stats-score-number">{{$post_listing->question->score}}</span>
                    <span class="question-stats-score-unit">votes</span>
                </div>

                <div class="question-stats-item">
                    <span class="question-stats-answers-number">{{count($post_listing->question->answers)}}</span>
                    <span class="s-post-summary--stats-item-unit">answers</span>
                </div>
            </div>

                <div class="post-summary col-10">

                    <div class ="row"><a href="{{route('questions', ['id'=>$post_listing->id_post])}}"><h5 class="card-title">{{$post_listing->question->title}}</h5></a></div>
                    <div class ="row"><h6 class="card-text">{{$truncated}}</h6></div>


                    <div class="post-summary-meta row d-flex justify-content-between">
                        <div class="col d-flex justify-content-start">
                            <ul class="post-summary-meta-tags list-ls-none d-inline">
                                @foreach($post_listing->question->tags as $tag)
                                    <li class="d-inline mr4"><a href="{{route('tags', ['name' => $tag->name])}}" class="post-tag flex--item mt0">{{$tag->name}}</a></li>
                                @endforeach
                            </ul>
                        </div>

                        <div class = "user-card col d-inline d-flex justify-content-end">
                            @include('partials.profile-card', ['user' => $post_listing->user])

                            <time class="user-card-time flex-shrink">
                                &nbsp;&nbsp;asked {{timeElapsedString($post_listing->date)}}
                            </time>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


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

                <div class ="row"><h7 class="original-question-title">Original question:</h7> <a href="{{route('questions', ['id'=>$post_listing->answer->question->id_question])}}"><h7 class="card-title">{{$post_listing->answer->question->title}}</h7></a></div>
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
