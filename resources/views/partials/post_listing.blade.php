@php $truncated = (strlen($post_listing->text_body) > 38) ? substr($post_listing->text_body,0,35).'...' :
    $post_listing->text_body;
@endphp
@if($post_listing->question)
    <div class="question-card card mx-5 my-2">
        <div class = "card-body row">
            <div class="question-stats col-2">

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
                    <div class ="row"><h7 class="card-text">{{$truncated}}</h7></div>


                    <div class="post-summary-meta row d-flex justify-content-between">
                        <div class="col d-flex justify-content-start">
                            <ul class="post-summary-meta-tags list-ls-none d-inline">
                                @foreach($post_listing->question->tags as $tag)
                                    <li class="d-inline mr4"><a href="{{route('tags', ['name' => $tag->name])}}" class="post-tag flex--item mt0">{{$tag->name}}</a></li>
                                @endforeach
                            </ul>
                        </div>


                        @include('partials.profile-card', ['user' => $post_listing->user])

                        <time class="user-card-time flex-shrink">
                            <p> asked 6 mins ago</p>
                        </time>
{{--                        get the how much time ago was $post_listing->date --}}





                    </div>
                </div>

            </div>
        </div>
    </div>


@elseif($post_listing->answer)

    <article class="post_listing" data-id="{{ $post_listing->id_post }}">
        <a href="{{route('questions', ['id' => $post_listing->answer->question->id_question])}}#answer-{{$post_listing->id_answer}}">
            <h4>A: {{$truncated}}</h4></a>
    </article>

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
