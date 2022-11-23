@if($postListing->question)
    @include('partials.questionCard', ['post' => $postListing])
@elseif($postListing->answer)
    @include('partials.answerCard', ['post' => $postListing])
@endif


