@php $truncated = (strlen($post->text_body) > 38) ? substr($post->text_body,0,35).'...' :
    $post->text_body;
    include_once(app_path() . '/Includes/Utils.php');
@endphp

<div class="question-card card mx-5 my-2">
    <div class = "card-body d-flex justify-content-center">
        <div class="question-stats col-2 d-flex justify-content-around flex-column">

            <div class="question-stats-item">
                <span class="question-stats-score-number">{{$post->question->score}}</span>
                <span class="question-stats-score-unit">votes</span>
            </div>

            <div class="question-stats-item">
                <span class="question-stats-answers-number">{{count($post->question->answers)}}</span>
                <span class="s-post-summary--stats-item-unit">answers</span>
            </div>
        </div>

        <div class="post-summary col-10">

            <div class ="row"><a href="{{route('questions', ['id'=>$post->id_post])}}"><h5 class="card-title">{{$post->question->title}}</h5></a></div>
            <div class ="row"><h6 class="card-text">{{$truncated}}</h6></div>


            <div class="post-summary-meta row d-flex justify-content-between">
                <div class="col d-flex justify-content-start">
                    <ul class="post-summary-meta-tags list-ls-none d-inline">
                        @foreach($post->question->tags as $tag)
                            <li class="d-inline mr4"><a href="{{route('tags', ['name' => $tag->name])}}" class="post-tag flex--item mt0">{{$tag->name}}</a></li>
                        @endforeach
                    </ul>
                </div>

                <div class = "user-card col d-inline d-flex justify-content-end">
                    @include('partials.profile-card', ['user' => $post->user])

                    <time class="user-card-time flex-shrink">
                        &nbsp;&nbsp;asked {{timeElapsedString($post->date)}}
                    </time>
                </div>
            </div>
        </div>

    </div>
</div>