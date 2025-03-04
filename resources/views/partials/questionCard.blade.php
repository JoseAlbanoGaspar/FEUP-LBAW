@php $truncated = (strlen($post->text_body) > 273) ? substr($post->text_body,0,270).'...' :
    $post->text_body;
    include_once(app_path() . '/Includes/Utils.php');
@endphp

<div class="questionCard card mx-5 my-2">
    <div class = "card-body d-flex justify-content-center p-3">
        <div class="question-stats col-2 d-flex justify-content-between flex-column py-4">

            @include('partials.statsScore', ['score' => $post->question->score])

            <div class="question-stats-item">
                <span class="question-stats-answers-number">{{count($post->question->answers)}}</span>
                <span class="s-post-summary--stats-item-unit">answers</span>
            </div>
        </div>

        <div class="post-summary col-10">

            <div class ="row">
                <a class="text-decoration-none" href="{{route('question', ['id_question'=>$post->id_post])}}">
                    <h5 class="card-title">{{$post->question->title}}
                    {{--if the question is followed by the user, show a filled star--}}
                    @if (Auth::check() && $post->question->isFollowedBy(Auth::user()->id_user))
                        <span class="isFollowedQuestionCard"> 
                            <i class="fa fa-star" aria-hidden="true"></i>
                        </span>
                    @endif
                    </h5>
                </a>
            </div>

            <div class ="row"><h6 class="card-text">{{$truncated}}</h6></div>


            <div class="post-summary-meta row d-flex justify-content-between mt-2">
                <div class="col d-flex justify-content-start">
                    <ul class="post-summary-meta-tags list-ls-none d-inline">
                        @foreach($post->question->tags as $tag)
                            @if (Auth::check()  && $tag->isFollowedBy(Auth::user()->id_user))
                                <li class="d-inline mr4">
                                    <a role="button" class="isFollowedTagCard btn btn-outline-success btn-sm" href="{{route('tag', ['id_tag' => $tag->id_tag])}}" class="post-tag flex--item">{{$tag->name}}</a>
                                </li>
                            @else
                                <li class="d-inline mr4">
                                    <a role="button" class="btn btn-outline-primary btn-sm" href="{{route('tag', ['id_tag' => $tag->id_tag])}}" class="post-tag flex--item">{{$tag->name}}</a>
                                </li>
                            @endif
                        @endforeach
                    </ul>
                </div>

                <div class = "user-card col d-inline d-flex justify-content-end text-wrap">
                    @include('partials.profileCard', ['user' => $post->user])

                    <time class="user-card-time flex-shrink">
                        &nbsp;&nbsp;asked {{timeElapsedString($post->date)}}
                    </time>
                </div>
            </div>
        </div>

    </div>
</div>
