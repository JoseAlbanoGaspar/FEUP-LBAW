<article class="post_listing" data-id="{{ $post_listing->id_post }}">
    @php $truncated = (strlen($post_listing->text_body) > 38) ? substr($post_listing->text_body,0,35).'...' :
    $post_listing->text_body;
    @endphp
    @if($post_listing->question)
        <a href="{{route('questions', ['id' => $post_listing->id_post])}}"><h4>Q: {{$post_listing->question->title}}</h4></a>
        <p>{{$truncated}}</p>
    @elseif($post_listing->answer)
        <a href="{{route('questions', ['id' => $post_listing->answer->question->id_question])}}#answer-{{$post_listing->id_answer}}"><h4>A: {{$truncated}}</h4></a>
    @endif

</article>
